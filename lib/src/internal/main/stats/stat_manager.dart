// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/base_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/default_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/default_stat_prefs.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/notification_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_state.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_type.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/upload_stat_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/event/login_event.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';

class StatManager {
  static const Map<String, Set<StatType>> _sdkStatsAttributeTable = {
    'allow_sdk_request_log_publish': {StatType.apiResult, StatType.wsConnect},
    'allow_sdk_feature_local_cache_log_publish': {StatType.featureLocalCache},
    'allow_sdk_noti_stats_log_publish': {StatType.notificationStats},
  };
  static const int _errStatUploadNotAllowed = 403200;

  final Chat _chat;
  final int _maxStatCountPerRequest = 1000;
  final int _minStatCount = 100;
  final int _minInterval = const Duration(hours: 3).inMilliseconds;
  final int _lowerThreshold = 10;

  StatState state = StatState.pending;
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

  bool _isLoaded = false;
  bool _isFlushing = false;

  CancelableOperation? _appendPendingDefaultStatsOperation;
  CancelableOperation? _doAppendStatOperation;
  CancelableOperation? _sendStatsOperation;

  StatManager({required Chat chat})
      : _chat = chat,
        defaultStatPrefs = DefaultStatPrefs();

  //+ Public
  Future<bool> appendStat({
    required String type,
    required Map<String, dynamic> data,
  }) async {
    sbLog.d(StackTrace.current, 'type: $type');

    _doAppendStatOperation = CancelableOperation.fromFuture(
      _doAppendStat(type: type, data: data),
    );
    return await _doAppendStatOperation?.value;
  }
  //- Public

  Future<bool> _doAppendStat({
    required String type,
    required Map<String, dynamic> data,
  }) async {
    sbLog.d(StackTrace.current, 'type: $type');

    bool result = false;
    final statType = StatUtils.getStatType(type);
    BaseStat? stat;
    if (statType != null) {
      stat = _createStat(statType, data);
      if (stat != null) {
        result = await _append(stat);
      }
    }

    if (result) {
      if (stat is NotificationStat) {
        sbLog.i(
          StackTrace.current,
          'type: $type, _state: $state, result: $result, stat: ${stat.toJson().toString()}',
        );
      }
    } else {
      sbLog.w(
          StackTrace.current, 'type: $type, _state: $state, result: $result');
    }
    return result;
  }

  BaseStat? _createStat(StatType statType, Map<String, dynamic> data) {
    sbLog.d(StackTrace.current);

    switch (statType) {
      case StatType.apiResult:
      case StatType.wsConnect:
      case StatType.featureLocalCache:
        return null;
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
    sbLog.d(StackTrace.current);

    switch (state) {
      case StatState.pending:
        if (stat is DefaultStat) {
          pendingDefaultStats.add(stat);
          await defaultStatPrefs.appendStat(stat);
          return true;
        }
        break;
      case StatState.enabled:
      case StatState.collectOnly:
        if (stat is DefaultStat) {
          cachedDefaultStats.add(stat);
          await defaultStatPrefs.appendStat(stat);

          await _checkToSendStats();
          return true;
        }
        break;
      case StatState.disabled:
        break;
    }
    return false;
  }

  Future<void> _checkToSendStats() async {
    sbLog.d(StackTrace.current);

    final count = cachedDefaultStats.length;
    sbLog.d(StackTrace.current, 'count: $count');

    if (state == StatState.enabled && count >= _lowerThreshold) {
      final lastSentAt = await defaultStatPrefs.lastSentAt;
      final interval = DateTime.now().millisecondsSinceEpoch - lastSentAt;
      sbLog.d(StackTrace.current, 'interval(sec): ${interval / 1000}');

      final canSendRegardingInterval = (interval > _minInterval);
      final canSendRegardingCount = (count == _minStatCount ||
          (count > _minStatCount && count % 20 == 0));

      if (canSendRegardingInterval || canSendRegardingCount) {
        _sendStatsOperation = CancelableOperation.fromFuture(_sendStats());
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
    final copiedStats =
        cachedDefaultStats.take(_maxStatCountPerRequest).toList();

    Object? exception;
    try {
      await _chat.apiClient.send(
        UploadStatRequest(_chat, deviceId: deviceId, stats: copiedStats),
      );
    } catch (e) {
      exception = e;
      if (e is SendbirdException && e.code == _errStatUploadNotAllowed) {
        sbLog.w(StackTrace.current, 'errStatUploadNotAllowed: 403200');
        await _setState(StatState.collectOnly);
      } else {
        sbLog.w(StackTrace.current, 'e: ${e.toString()}');
      }
    }

    if (exception == null) {
      sbLog.i(StackTrace.current,
          '[Sent] deviceId: $deviceId, count: ${copiedStats.length}');

      final List<DefaultStat> remainingStats = [];
      try {
        remainingStats.addAll(cachedDefaultStats
            .sublist(copiedStats.length, cachedDefaultStats.length)
            .toList());
      } catch (e) {
        sbLog.d(StackTrace.current, 'e: ${e.toString()}');
      }

      cachedDefaultStats.clear();
      cachedDefaultStats.addAll(remainingStats);
      await defaultStatPrefs
          .updateLastSentAt(DateTime.now().millisecondsSinceEpoch);
      await defaultStatPrefs.putStats(remainingStats);
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
    await _setState(StatState.disabled);
  }
  //- EventDispatcher

  Future<void> _onStatOn() async {
    sbLog.d(StackTrace.current);

    await _loadOnce();

    _appendPendingDefaultStatsOperation =
        CancelableOperation.fromFuture(_appendPendingDefaultStats());
  }

  Future<void> _loadOnce() async {
    if (_isLoaded) return;

    pendingDefaultStats.addAll(await defaultStatPrefs.stats);
    sbLog.d(StackTrace.current,
        '_pendingDefaultStats.length: ${pendingDefaultStats.length}');

    _isLoaded = true;
  }

  Future<void> _appendPendingDefaultStats() async {
    sbLog.d(StackTrace.current);

    for (final stat in pendingDefaultStats) {
      await _append(stat);
    }
    pendingDefaultStats.clear();
  }

  Future<void> _onStatOff() async {
    sbLog.d(StackTrace.current);

    await _appendPendingDefaultStatsOperation?.cancel();
    await _doAppendStatOperation?.cancel();
    await _sendStatsOperation?.cancel();

    await _clearAll();
  }

  Future<void> _clearAll() async {
    sbLog.d(StackTrace.current);

    pendingDefaultStats.clear();
    cachedDefaultStats.clear();

    await defaultStatPrefs.clearAll();
  }

  Future<void> _checkLoginEvent(LoginEvent event) async {
    sbLog.d(StackTrace.current);

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
}
