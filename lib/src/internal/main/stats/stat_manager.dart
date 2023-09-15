// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:collection/collection.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/api_result_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/base_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/default_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/default_stat_prefs.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/notification_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_state.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_type.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/ws_connect_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/json_converter.dart';
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
  static const int _initialMinStatCount = 100;

  final Chat _chat;
  final int _maxStatCountPerRequest = 1000;
  int _minStatCount = _initialMinStatCount;
  final int _intervalCountToTryAgain = 20;
  final int _minInterval = const Duration(hours: 3).inMilliseconds;
  final int _lowerThreshold = 10;

  StatState state = StatState.pending;
  bool _isLoaded = false;

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

  bool _isFlushing = false;

  final Map<String, int> _apiResultStartTsMap = {};
  final Map<String, int> _wsConnectStartTsMap = {};

  StatManager({required Chat chat})
      : _chat = chat,
        defaultStatPrefs = DefaultStatPrefs();

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
        }
        break;
      case StatState.disabled:
        break;
    }
    return result;
  }

  Future<void> _checkToSendStats(BaseStat stat) async {
    final count = cachedDefaultStats.length;
    sbLog.d(StackTrace.current, 'cachedDefaultStats: $count');

    if (state == StatState.enabled && count >= _lowerThreshold) {
      final lastSentAt = await defaultStatPrefs.lastSentAt;
      final interval = DateTime.now().millisecondsSinceEpoch - lastSentAt;
      sbLog.d(StackTrace.current, 'interval(sec): ${interval / 1000}');

      final canSendRegardingInterval = (interval > _minInterval);
      final canSendRegardingCount = (count >= _minStatCount);

      if (canSendRegardingInterval || canSendRegardingCount) {
        if (stat is ApiResultStat &&
            stat.endpoint.contains(UploadStatRequest.statUrl)) {
          // Defensive code
          sbLog.w(StackTrace.current, 'Ignored the stat for statistics API');
          return;
        }

        await _sendStats();
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
      _minStatCount += _intervalCountToTryAgain;

      exception = e;
      if (e is SendbirdException && e.code == _errStatUploadNotAllowed) {
        sbLog.w(StackTrace.current, 'errStatUploadNotAllowed: 403200');
        await _setState(StatState.collectOnly);
      } else {
        sbLog.w(StackTrace.current, 'e: ${e.toString()}');
      }
    }

    if (exception == null) {
      _minStatCount = _initialMinStatCount;

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

      sbLog.d(
          StackTrace.current,
          '[StatTest][Sent] deviceId: $deviceId,'
          ' pendingDefaultStats: ${pendingDefaultStats.length},'
          ' cachedDefaultStats: ${cachedDefaultStats.length},'
          ' defaultStatPrefs: ${await defaultStatPrefs.statCount}');
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
    int? errorCode,
    String? errorDescription,
  }) async {
    sbLog.d(StackTrace.current);

    final startTs = _wsConnectStartTsMap[hostUrl];
    if (startTs == null) return;

    final latency = DateTime.now().millisecondsSinceEpoch - startTs;

    await appendStat(
      type: StatUtils.getStatTypeString(StatType.wsConnect),
      data: <String, dynamic>{
        'host_url': hostUrl,
        'success': success,
        'latency': latency,
        'error_code': errorCode,
        'error_description': errorDescription,
      },
    );

    _wsConnectStartTsMap.remove(hostUrl);
  }

  //- WsConnectStat

  //+ ApiResultStat
  void startApiResultStat({
    required String endpoint,
  }) {
    sbLog.d(StackTrace.current);

    if (_wsConnectStartTsMap[endpoint] == null) {
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
