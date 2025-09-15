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
          pendingDefaultStats.add(stat);
          await defaultStatPrefs.appendStat(stat);

          sbLog.d(
              StackTrace.current,
              '[StatTest][Append] state: $state'
              ' pendingDefaultStats: ${pendingDefaultStats.length},'
              ' cachedDefaultStats: ${cachedDefaultStats.length},'
              ' defaultStatPrefs: ${await defaultStatPrefs.statCount},'
              ' stat: \n${jsonEncoder.convert(stat.toJson())}');

          result = true;
        } else if (stat is DailyRecordStat) {
          await dailyRecordStatPrefs.upsert(stat);
          result = true;
        }
        break;
      case StatState.enabled:
      case StatState.collectOnly:
        if (stat is DefaultStat) {
          cachedDefaultStats.add(stat);
          await defaultStatPrefs.appendStat(stat);

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
          await dailyRecordStatPrefs.upsert(stat);

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

    await _clearDisallowedStats(); // Defensive code

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
      if (copiedStats.length >= _currentMinStatCount) {
        _currentMinStatCount += _intervalCountToTryAgain;
      }

      exception = e;
      if (e is SendbirdException && e.code == _errStatUploadNotAllowed) {
        sbLog.w(StackTrace.current, 'errStatUploadNotAllowed: 403200');
        await _setState(StatState.collectOnly);
      } else {
        sbLog.w(StackTrace.current, 'e: ${e.toString()}');
      }
    }

    if (exception == null) {
      _currentMinStatCount = _initialMinStatCount;

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

    _isFlushing = false;
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

  Future<void> _clearAll() async {
    sbLog.d(StackTrace.current);

    pendingDefaultStats.clear();
    cachedDefaultStats.clear();

    await defaultStatPrefs.clearAll();
    await dailyRecordStatPrefs.clearAll();
  }

  Future<void> _checkLoginEvent(LoginEvent event) async {
    sbLog.d(StackTrace.current);

    _setStatConfig(event);

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
  }) async {
    sbLog.d(StackTrace.current);

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
        'connection_id': connectionId ?? const Uuid().v1(),
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
  }) async {
    sbLog.d(StackTrace.current);

    await appendStat(
      type: StatUtils.getStatTypeString(StatType.wsDisconnect),
      data: <String, dynamic>{
        'success': success,
        'error_code': errorCode,
        'error_description': errorDescription,
      },
    );
  }

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
