// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/daily_record_stat_prefs.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/default_stat_prefs.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/model/base_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/model/daily_record/daily_record_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/model/daily_record/local_cache_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/model/default/api_result_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/model/default/default_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/model/default/local_cache_event_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/model/default/notification_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/model/default/ws_connect_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/model/default/ws_disconnect_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_state.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_type.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/json_converter.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/upload_notification_stat_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/upload_stat_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/event/login_event.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:uuid/uuid.dart';

class StatManager {
  static const Map<String, Set<StatType>> _sdkStatsAttributeTable = {
    'allow_sdk_request_log_publish': {
      StatType.apiResult,
      StatType.wsConnect,
      StatType.wsDisconnect,
    },
    'allow_sdk_feature_local_cache_log_publish': {
      StatType.featureLocalCache,
      StatType.featureLocalCacheEvent,
    },
    'allow_sdk_noti_stats_log_publish': {
      StatType.notificationStats,
    },
  };
  static const int _errStatUploadNotAllowed = 403200;
  static const int _intervalCountToTryAgain = 20;
  static const int _maxRetryCount = 20;

  final Chat _chat;
  final Random _random = Random();
  Timer? sendingTimer;

  int _initialMinStatCount = 100;
  int _currentMinStatCount = 100;
  int _minIntervalMilliSec =
      const Duration(hours: 3).inMilliseconds; // milliseconds
  int _maxStatCountPerRequest = 1000;
  int _lowerThresholdCount = 10;
  int _requestDelayRangeSec = 180; // seconds
  int _retryCount = 0; // consecutive stat-upload failures (circuit breaker)
  int _flushGeneration = 0; // bumped on logout to invalidate in-flight flushes
  // Async mutex serializing a flush's result-write / appends with onLogout()'s
  // _clearAll, so a late write can't re-persist stats that logout removed
  // (session isolation). Held only for the short write sections, never across
  // the network upload. Non-null while held. (CLNP-8835)
  Completer<void>? _prefsLock;
  // ws:disconnect is recorded once per connection span, mirroring native's
  // WebSocketStatCollector (which calls onDisconnected() only while Connected,
  // then leaves that state). Set true when a connection is established
  // (endWsConnectStat success) and cleared when the first terminal disconnect
  // stat is recorded — so a second disconnect in the same span (e.g. a network
  // drop right after cause=background) is dropped instead of double-counted.
  // (CLNP-8835)
  bool _wsSpanConnected = false;
  set wsSpanConnectedForTest(bool value) => _wsSpanConnected = value;
  // Test seams for the logout-mid-flush race: when flushWriteGateForTest is set,
  // _sendStats signals flushWriteGateReachedForTest and awaits it just before the
  // serialized write, letting a test fire logout in between. (CLNP-8835)
  Completer<void>? flushWriteGateForTest;
  Completer<void>? flushWriteGateReachedForTest;
  Completer<void>? clearDisallowedGateForTest;
  Completer<void>? clearDisallowedGateReachedForTest;
  Completer<void>? dailyAppendGateForTest;
  Completer<void>? dailyAppendGateReachedForTest;
  // for tests only: forces a small per-request cap so a flush leaves stats in
  // `remaining`, making a buggy logout-mid-flush re-persist observable.
  // (CLNP-8835)
  set maxStatCountPerRequestForTest(int value) =>
      _maxStatCountPerRequest = value;

  StatState state = StatState.pending;
  bool _isLoaded = false;

  void _setStatConfig(LoginEvent event) {
    final config = event.logPublishConfig?.defaultConfig;
    if (config?.minStatCount != null) {
      _initialMinStatCount = config!.minStatCount!;
      _currentMinStatCount = config.minStatCount!;
    }
    if (config?.minInterval != null) {
      _minIntervalMilliSec =
          config!.minInterval! * 1000; // Convert seconds to milliseconds
    }
    if (config?.maxStatCountPerRequest != null) {
      _maxStatCountPerRequest = config!.maxStatCountPerRequest!;
    }
    if (config?.lowerThreshold != null) {
      _lowerThresholdCount = config!.lowerThreshold!;
    }
    if (config?.requestDelayRange != null) {
      _requestDelayRangeSec = config!.requestDelayRange!;
    }
  }

  Future<void> _setState(value) async {
    state = value;
    switch (value) {
      case StatState.pending:
        break;
      case StatState.enabled:
      case StatState.collectOnly:
        await _onStatOn();
        break;
      case StatState.disabled:
        await _onStatOff();
        break;
    }
  }

  final Set<StatType> allowedStatTypes =
      _sdkStatsAttributeTable.values.flattened.toSet();
  final List<DefaultStat> pendingDefaultStats = [];
  final List<DefaultStat> cachedDefaultStats = [];
  final DefaultStatPrefs defaultStatPrefs;
  final DailyRecordStatPrefs dailyRecordStatPrefs;

  bool _isFlushing = false;

  final Map<String, int> _apiResultStartTsMap = {};
  final Map<String, int> _wsConnectStartTsMap = {};

  int? lastWsLatency;
  int? lastWsLogiLatency;

  StatManager({required Chat chat})
      : _chat = chat,
        defaultStatPrefs = DefaultStatPrefs(),
        dailyRecordStatPrefs = DailyRecordStatPrefs();

  //+ Public
  Future<bool> appendStat({
    required String type,
    required Map<String, dynamic> data,
  }) async {
    sbLog.d(StackTrace.current, 'type: $type');
    return await _doAppendStat(type: type, data: data);
  }

  //- Public

  Future<bool> _doAppendStat({
    required String type,
    required Map<String, dynamic> data,
  }) async {
    sbLog.d(StackTrace.current);

    bool result = false;
    final statType = StatUtils.getStatType(type);
    BaseStat? stat;
    if (statType != null) {
      stat = _createStat(statType, data);
      if (stat != null) {
        result = await _append(stat);
      }
    }
    return result;
  }

  BaseStat? _createStat(StatType statType, Map<String, dynamic> data) {
    sbLog.d(StackTrace.current);

    switch (statType) {
      case StatType.apiResult:
        return ApiResultStat.fromJson(
          ts: DateTime.now().millisecondsSinceEpoch,
          data: data,
        );
      case StatType.wsConnect:
        return WsConnectStat.fromJson(
          ts: DateTime.now().millisecondsSinceEpoch,
          data: data,
        );
      case StatType.wsDisconnect:
        return WsDisconnectStat.fromJson(
          ts: DateTime.now().millisecondsSinceEpoch,
          data: data,
        );
      case StatType.featureLocalCache:
        return LocalCacheStat.fromJson(
          ts: DateTime.now().millisecondsSinceEpoch,
          data: data,
        );
      case StatType.featureLocalCacheEvent:
        return LocalCacheEventStat.fromJson(
          ts: DateTime.now().millisecondsSinceEpoch,
          data: data,
        );
      case StatType.notificationStats:
        return NotificationStat.fromJson(
          ts: DateTime.now().millisecondsSinceEpoch,
          data: data,
        );
    }
  }

  Future<bool> _append(BaseStat stat) async {
    sbLog.d(StackTrace.current);

    if (allowedStatTypes.contains(stat.type)) {
      if (state == StatState.pending ||
          state == StatState.enabled ||
          state == StatState.collectOnly) {
        return await _doAppend(stat);
      }
    }
    return false;
  }

  Future<bool> _doAppend(BaseStat stat) async {
    bool result = false;

    switch (state) {
      case StatState.pending:
        if (stat is DefaultStat) {
          // Add to the in-memory list synchronously (as before the mutex) so a
          // fire-and-forget append is reflected immediately; only the prefs
          // read-modify-write needs serialization. A racing logout is handled by
          // the state check above (blocks post-logout appends) and by _clearAll
          // clearing the list. (CLNP-8835)
          pendingDefaultStats.add(stat);
          final gen = _flushGeneration;
          await _synchronizedPrefs(() async {
            if (gen != _flushGeneration) return; // dropped by a racing logout
            await defaultStatPrefs.appendStat(stat);
          });

          sbLog.d(
              StackTrace.current,
              '[StatTest][Append] state: $state'
              ' pendingDefaultStats: ${pendingDefaultStats.length},'
              ' cachedDefaultStats: ${cachedDefaultStats.length},'
              ' defaultStatPrefs: ${await defaultStatPrefs.statCount},'
              ' stat: \n${jsonEncoder.convert(stat.toJson())}');

          result = true;
        } else if (stat is DailyRecordStat) {
          final gen = _flushGeneration;
          await _synchronizedPrefs(() async {
            if (gen != _flushGeneration) return; // dropped by a racing logout
            await dailyRecordStatPrefs.upsert(stat);
          });
          result = true;
        }
        break;
      case StatState.enabled:
      case StatState.collectOnly:
        if (stat is DefaultStat) {
          // Add to the in-memory cache synchronously (as before the mutex) so a
          // fire-and-forget append is reflected immediately; only the prefs
          // read-modify-write needs serialization. A racing logout is handled by
          // the state check above (blocks post-logout appends) and by _clearAll
          // clearing the cache. (CLNP-8835)
          cachedDefaultStats.add(stat);
          final gen = _flushGeneration;
          await _synchronizedPrefs(() async {
            if (gen != _flushGeneration) return; // dropped by a racing logout
            await defaultStatPrefs.appendStat(stat);
          });

          sbLog.d(
              StackTrace.current,
              '[StatTest][Append] state: $state'
              ' pendingDefaultStats: ${pendingDefaultStats.length},'
              ' cachedDefaultStats: ${cachedDefaultStats.length},'
              ' defaultStatPrefs: ${await defaultStatPrefs.statCount},'
              ' stat: \n${jsonEncoder.convert(stat.toJson())}');

          await _checkToSendStats(stat);
          result = true;
        } else if (stat is DailyRecordStat) {
          final gen = _flushGeneration;
          // Test seam: pause AFTER capturing the generation (mirrors an append
          // that began before a logout) so a test can log out right here.
          if (dailyAppendGateForTest != null) {
            dailyAppendGateReachedForTest?.complete();
            await dailyAppendGateForTest!.future;
          }
          await _synchronizedPrefs(() async {
            if (gen != _flushGeneration) return; // dropped by a racing logout
            await dailyRecordStatPrefs.upsert(stat);
          });

          await _checkToSendStats(stat);
          result = true;
        }
        break;
      case StatState.disabled:
        break;
    }
    return result;
  }

  Future<void> _checkToSendStats(BaseStat stat) async {
    final dailyRecordStatCount =
        await dailyRecordStatPrefs.uploadCandidateStatCount;
    final count = cachedDefaultStats.length + dailyRecordStatCount;
    sbLog.d(
        StackTrace.current, 'cachedDefaultStats: ${cachedDefaultStats.length}');
    sbLog.d(StackTrace.current, 'dailyRecordStatCount: $dailyRecordStatCount');
    sbLog.d(StackTrace.current, 'count: $count');

    if (state == StatState.enabled && count >= _lowerThresholdCount) {
      final lastSentAt = await defaultStatPrefs.lastSentAt;
      final interval = DateTime.now().millisecondsSinceEpoch - lastSentAt;
      sbLog.d(StackTrace.current, 'interval(sec): ${interval / 1000}');

      final canSendRegardingInterval = (interval > _minIntervalMilliSec);
      final canSendRegardingCount = (count >= _currentMinStatCount);

      if (canSendRegardingInterval || canSendRegardingCount) {
        if (stat is ApiResultStat) {
          if (stat.endpoint.contains(UploadStatRequest.statUrl) ||
              stat.endpoint.contains(UploadNotificationStatRequest.statUrl)) {
            // Defensive code
            sbLog.w(StackTrace.current, 'Ignored the stat for statistics API');
            return;
          }
        }

        if (_chat.isTest) {
          await _sendStats();
        } else {
          if (sendingTimer == null || sendingTimer!.isActive == false) {
            final delaySeconds = _random.nextInt(_requestDelayRangeSec) + 1;
            sbLog.d(StackTrace.current,
                'Sending stats after $delaySeconds seconds');
            sendingTimer = Timer(Duration(seconds: delaySeconds), () async {
              try {
                await _sendStats();
              } catch (e) {
                sbLog.e(StackTrace.current, 'Error while sending stats: $e');
              } finally {
                sendingTimer = null;
              }
            });
          } else {
            sbLog.d(StackTrace.current,
                'Sending timer is already active, skipping this time');
          }
        }
      }
    }
  }

  Future<void> _sendStats() async {
    if (_isFlushing) {
      sbLog.d(StackTrace.current, '_isFlushing: $_isFlushing');
      return;
    }
    _isFlushing = true;
    try {
      await _doSendStats();
    } finally {
      _isFlushing = false;
    }
  }

  // Extracted so _sendStats can guarantee _isFlushing is reset via try/finally
  // even if an await below throws. A stuck _isFlushing would make every future
  // _sendStats early-return, silently halting all stat uploads for the rest of
  // the session. (CLNP-8835)
  Future<void> _doSendStats() async {
    final int generation = _flushGeneration;

    // Test seam: lets a test fire logout right before the _clearDisallowedStats
    // prefs rewrite. (CLNP-8835)
    if (clearDisallowedGateForTest != null) {
      clearDisallowedGateReachedForTest?.complete();
      await clearDisallowedGateForTest!.future;
    }

    // _clearDisallowedStats rewrites the whole prefs list (read-modify-write via
    // putStats), so serialize it with onLogout()'s _clearAll and drop it if a
    // logout already happened — otherwise it would re-persist stats logout just
    // removed. (CLNP-8835)
    await _synchronizedPrefs(() async {
      if (generation != _flushGeneration) return;
      await _clearDisallowedStats();
    });
    if (generation != _flushGeneration) return; // logout raced -> abort flush

    final deviceId = await defaultStatPrefs.deviceId;

    final dailyRecordStats = (await dailyRecordStatPrefs.uploadCandidateStats)
        .take(_maxStatCountPerRequest)
        .toList();

    final copiedStats = cachedDefaultStats
        .take(_maxStatCountPerRequest - dailyRecordStats.length)
        .toList();

    final List<NotificationStat> notificationStats = [];
    final List<DefaultStat> otherStats = [];
    final List<DefaultStat> remainingDefaultStats = [...cachedDefaultStats];

    for (DefaultStat stat in copiedStats) {
      if (stat is NotificationStat) {
        notificationStats.add(stat);
      } else {
        otherStats.add(stat);
      }
    }

    Object? exception;
    bool wereNotificationStatsSent = false;
    try {
      if (notificationStats.isNotEmpty) {
        // Send notificationStats
        await _chat.apiClient.send(
          UploadNotificationStatRequest(_chat,
              deviceId: deviceId, stats: notificationStats),
        );

        for (NotificationStat stat in notificationStats) {
          remainingDefaultStats.remove(stat);
        }

        wereNotificationStatsSent = true;
      }

      if (dailyRecordStats.isNotEmpty || otherStats.isNotEmpty) {
        // Send otherStats
        await _chat.apiClient.send(
          UploadStatRequest(_chat,
              deviceId: deviceId, stats: [...dailyRecordStats, ...otherStats]),
        );

        for (DefaultStat stat in otherStats) {
          remainingDefaultStats.remove(stat);
        }
      }
    } catch (e) {
      // If a logout raced this in-flight upload, drop the result — applying it
      // would revive collectOnly / re-populate stats after the cache was cleared,
      // leaking into the next session. (CLNP-8835)
      if (generation != _flushGeneration) return;
      if (copiedStats.length >= _currentMinStatCount) {
        _currentMinStatCount += _intervalCountToTryAgain;
      }

      exception = e;
      if (e is SendbirdException && e.code == _errStatUploadNotAllowed) {
        sbLog.w(StackTrace.current, 'errStatUploadNotAllowed: 403200');
        await _setState(StatState.collectOnly);
      } else {
        // Circuit breaker: after more than _maxRetryCount consecutive upload
        // failures (e.g. poor network) stop uploading so we don't keep hammering
        // a dead connection. Recovers to enabled on the next login/reconnect via
        // _checkLoginEvent. Uses `>` to trip on the (_maxRetryCount + 1)th
        // failure, matching Android/chat-js (retryCount > MAX). (CLNP-8835)
        _retryCount++;
        sbLog.w(
            StackTrace.current, 'e: ${e.toString()}, retryCount: $_retryCount');
        if (_retryCount > _maxRetryCount) {
          sbLog.w(StackTrace.current,
              'Stat upload failed $_retryCount times; switching to collectOnly');
          _retryCount = 0;
          await _setState(StatState.collectOnly);
        }
      }
    }

    // A logout during the upload invalidated this flush (see the catch above):
    // the cache/prefs were cleared, so skip writing this result back. (CLNP-8835)
    if (generation != _flushGeneration) return;

    // Test seam: lets a logout-mid-flush test interleave right here, before the
    // serialized write section.
    if (flushWriteGateForTest != null) {
      flushWriteGateReachedForTest?.complete();
      await flushWriteGateForTest!.future;
    }

    // Serialize the result-write with onLogout()'s _clearAll and re-check the
    // generation under the lock, so a logout that raced the upload wins and the
    // removed stats are never re-persisted. (CLNP-8835)
    await _synchronizedPrefs(() async {
      if (generation != _flushGeneration) return;

      if (exception == null) {
        _currentMinStatCount = _initialMinStatCount;
        _retryCount = 0;

        cachedDefaultStats.clear();
        cachedDefaultStats.addAll(remainingDefaultStats);
        await defaultStatPrefs
            .updateLastSentAt(DateTime.now().millisecondsSinceEpoch);
        await defaultStatPrefs.putStats(remainingDefaultStats);
        await dailyRecordStatPrefs.remove(dailyRecordStats);

        sbLog.d(
            StackTrace.current,
            '[StatTest][Sent] deviceId: $deviceId,'
            ' pendingDefaultStats: ${pendingDefaultStats.length},'
            ' cachedDefaultStats: ${cachedDefaultStats.length},'
            ' defaultStatPrefs: ${await defaultStatPrefs.statCount},'
            ' dailyRecordStatPrefs: ${(await dailyRecordStatPrefs.stats).length}');
      } else if (wereNotificationStatsSent) {
        _currentMinStatCount = _initialMinStatCount;

        cachedDefaultStats.clear();
        cachedDefaultStats.addAll(remainingDefaultStats);
        await defaultStatPrefs
            .updateLastSentAt(DateTime.now().millisecondsSinceEpoch);
        await defaultStatPrefs.putStats(remainingDefaultStats);

        sbLog.d(
            StackTrace.current,
            '[StatTest][NotificationStatsSent] deviceId: $deviceId,'
            ' pendingDefaultStats: ${pendingDefaultStats.length},'
            ' cachedDefaultStats: ${cachedDefaultStats.length},'
            ' defaultStatPrefs: ${await defaultStatPrefs.statCount},'
            ' dailyRecordStatPrefs: ${(await dailyRecordStatPrefs.stats).length}');
      }
    });
  }

  //+ EventDispatcher
  Future<void> onConnecting() async {
    sbLog.d(StackTrace.current);
    await _setState(StatState.pending);
  }

  Future<void> onLogin(LoginEvent event) async {
    sbLog.d(StackTrace.current);
    await _checkLoginEvent(event);
  }

  Future<void> onReconnected(LoginEvent event) async {
    sbLog.d(StackTrace.current);
    await _checkLoginEvent(event);
  }

  Future<void> onLogout() async {
    sbLog.d(StackTrace.current);
    // Invalidate any in-flight flush: onLogout disables collection and clears the
    // cache, so a late-completing upload must not revive collectOnly or write
    // stale stats back into the next session. (CLNP-8835)
    _flushGeneration++;
    if (sendingTimer != null && sendingTimer!.isActive) {
      sendingTimer!.cancel();
      sendingTimer = null;
    }
    await _setState(StatState.disabled);
  }

  //- EventDispatcher

  Future<void> _onStatOn() async {
    sbLog.d(StackTrace.current);

    if (_isLoaded == false) {
      pendingDefaultStats.addAll(await defaultStatPrefs.stats);
      _isLoaded = true;
    }

    cachedDefaultStats.addAll(pendingDefaultStats);
    pendingDefaultStats.clear();

    sbLog.d(
        StackTrace.current,
        '[StatTest][StatOn] '
        ' pendingDefaultStats: ${pendingDefaultStats.length},'
        ' cachedDefaultStats: ${cachedDefaultStats.length},'
        ' defaultStatPrefs: ${await defaultStatPrefs.statCount}');
  }

  Future<void> _onStatOff() async {
    sbLog.d(StackTrace.current);
    await _clearAll();
  }

  // FIFO async mutex over prefs mutations (see _prefsMutex). Each call runs after
  // the previous one completes; the write section re-checks _flushGeneration
  // inside the lock so logout deterministically wins the race. (CLNP-8835)
  Future<T> _synchronizedPrefs<T>(Future<T> Function() action) async {
    // Wait for any current holder. Uncontended (_prefsLock == null) means the
    // loop is skipped and `action` is invoked synchronously below — no added
    // microtask latency vs a direct await, so a fire-and-forget append is not
    // delayed past a concurrent SharedPreferences reset in tests.
    while (_prefsLock != null) {
      await _prefsLock!.future;
    }
    final lock = Completer<void>();
    _prefsLock = lock;
    try {
      return await action();
    } finally {
      _prefsLock = null;
      lock.complete();
    }
  }

  // Triggers a flush directly; for tests only. (CLNP-8835)
  Future<void> sendStatsForTest() => _sendStats();

  Future<void> _clearAll() async {
    sbLog.d(StackTrace.current);

    await _synchronizedPrefs(() async {
      pendingDefaultStats.clear();
      cachedDefaultStats.clear();

      await defaultStatPrefs.clearAll();
      await dailyRecordStatPrefs.clearAll();
    });
  }

  Future<void> _checkLoginEvent(LoginEvent event) async {
    sbLog.d(StackTrace.current);

    _setStatConfig(event);
    _retryCount = 0; // reset circuit breaker on (re)login (CLNP-8835)

    await defaultStatPrefs.checkToInitLastSentAt();

    allowedStatTypes.clear();
    Iterable<StatType>? statTypes = _chat.chatContext.appInfo?.attributesInUse
        .toSet()
        .intersection(_sdkStatsAttributeTable.keys.toSet())
        .map((key) => _sdkStatsAttributeTable[key])
        .whereNotNull()
        .flattened;
    if (statTypes != null) {
      allowedStatTypes.addAll(statTypes);
    }

    await _clearDisallowedStats();

    if (_isSdkStatsAllowed()) {
      if (_isSdkStatsUploadAllowed()) {
        await _setState(StatState.enabled);
      } else {
        await _setState(StatState.collectOnly);
      }
    } else {
      await _setState(StatState.disabled);
    }
  }

  Future<void> _clearDisallowedStats() async {
    sbLog.d(StackTrace.current);

    pendingDefaultStats
        .removeWhere((stat) => allowedStatTypes.contains(stat.type) == false);
    cachedDefaultStats
        .removeWhere((stat) => allowedStatTypes.contains(stat.type) == false);

    await defaultStatPrefs.clearDisallowedStats(allowedStatTypes);
    await dailyRecordStatPrefs.clearDisallowedStats(allowedStatTypes);
  }

  bool _isSdkStatsAllowed() {
    final result = _chat.chatContext.appInfo?.attributesInUse
            .toSet()
            .intersection(_sdkStatsAttributeTable.keys.toSet())
            .isNotEmpty ??
        false;
    sbLog.d(StackTrace.current, 'result: $result');
    return result;
  }

  bool _isSdkStatsUploadAllowed() {
    final result = _chat.chatContext.appInfo?.allowSdkStatsUpload ?? false;
    sbLog.d(StackTrace.current, 'result: $result');
    return result;
  }

  //+ WsConnectStat
  void startWsConnectStat({
    required String hostUrl,
  }) {
    sbLog.d(StackTrace.current);

    if (_wsConnectStartTsMap[hostUrl] == null) {
      _wsConnectStartTsMap[hostUrl] = DateTime.now().millisecondsSinceEpoch;
    }
  }

  void endWsConnectStat({
    required String hostUrl,
    required bool success,
    required int accumTrial,
    int? connectedTs,
    int? logiTs,
    int? errorCode,
    String? errorDescription,
    String? connectionId,
    bool? isSoftRateLimited,
  }) async {
    sbLog.d(StackTrace.current);

    if (success) {
      // A successful (re)connect opens a new ws:disconnect span (native: the
      // collector enters Connected). Done before the startTs guard below so the
      // span still opens even if connect-latency tracking was missed.
      // (CLNP-8835)
      _wsSpanConnected = true;
    }

    final startTs = _wsConnectStartTsMap[hostUrl];
    if (startTs == null) return;

    final now = DateTime.now().millisecondsSinceEpoch;
    final connectedLatency = (connectedTs ?? now) - startTs;
    final logiLatency = (logiTs ?? now) - startTs;

    lastWsLatency = connectedLatency;
    lastWsLogiLatency = logiLatency;

    await appendStat(
      type: StatUtils.getStatTypeString(StatType.wsConnect),
      data: <String, dynamic>{
        'host_url': hostUrl,
        'success': success,
        'latency': connectedLatency,
        'accum_trial': accumTrial,
        'logi_latency': logiLatency,
        'error_code': errorCode,
        'error_description': errorDescription,
        'connection_id': connectionId ?? const Uuid().v4(),
        'is_soft_rate_limited': isSoftRateLimited,
      },
    );

    _wsConnectStartTsMap.remove(hostUrl);
  }

  //- WsConnectStat

  //+ WsDisconnectStat
  void appendWsDisconnectStat({
    required bool success,
    required int errorCode,
    required String errorDescription,
    bool spanGuarded = true,
  }) async {
    sbLog.d(StackTrace.current);

    // One ws:disconnect per connection span (native WebSocketStatCollector:
    // onDisconnected() records only while Connected, then leaves that state, so
    // a later disconnect in the same span is ignored). spanGuarded=false is for
    // non-terminal events (session_expired) that must always record without
    // closing the span. The flag is touched synchronously before any await, so
    // concurrent appends can't both pass the guard. (CLNP-8835)
    if (spanGuarded) {
      if (!_wsSpanConnected) return;
      _wsSpanConnected = false;
    }

    sbLog.e(StackTrace.current, 'errorDescription: $errorDescription');

    await appendStat(
      type: StatUtils.getStatTypeString(StatType.wsDisconnect),
      data: <String, dynamic>{
        'success': success,
        'error_code': errorCode,
        'error_description': errorDescription,
      },
    );
  }

  // Close the ws:disconnect span when a connection is torn down without a
  // disconnect stat — logout, or connecting a different user (doDisconnect with
  // clear/logout) — so a span opened by a previous connection can't attach a
  // phantom cause=<code> to the next connection's pre-LOGI failure. (CLNP-8835)
  void closeWsSpan() => _wsSpanConnected = false;

  //- WsDisconnectStat

  //+ ApiResultStat
  void startApiResultStat({
    required String endpoint,
  }) {
    sbLog.d(StackTrace.current);

    if (_apiResultStartTsMap[endpoint] == null) {
      _apiResultStartTsMap[endpoint] = DateTime.now().millisecondsSinceEpoch;
    }
  }

  void endApiResultStat({
    required String endpoint,
    required String method,
    required bool success,
    int? errorCode,
    String? errorDescription,
  }) async {
    sbLog.d(StackTrace.current);

    final startTs = _apiResultStartTsMap[endpoint];
    if (startTs == null) return;

    final latency = DateTime.now().millisecondsSinceEpoch - startTs;

    if (endpoint.contains(UploadStatRequest.statUrl) ||
        endpoint.contains(UploadNotificationStatRequest.statUrl)) {
      await Future.delayed(const Duration(milliseconds: 100)); // Check
    }

    await appendStat(
      type: StatUtils.getStatTypeString(StatType.apiResult),
      data: <String, dynamic>{
        'endpoint': endpoint,
        'method': method,
        'success': success,
        'latency': latency,
        'error_code': errorCode,
        'error_description': errorDescription,
      },
    );

    _apiResultStartTsMap.remove(endpoint);
  }

//- ApiResultStat
}
