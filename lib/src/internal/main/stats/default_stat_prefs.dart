// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/api_result_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/default_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/notification_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_type.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/ws_connect_stat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DefaultStatPrefs {
  final prefDefaultStats = 'com.sendbird.chat.default_stats';
  final prefDefaultStatsCount = 'com.sendbird.chat.default_stats_count';
  final prefDefaultStatsLastSentAt =
      'com.sendbird.chat.default_stats_last_sent_at';
  final prefDefaultStatsDeviceId = 'com.sendbird.chat.default_stats_device_id';

  SharedPreferences? _sharedPreferences;

  Future<SharedPreferences> get _prefs async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  Future<List<DefaultStat>> get stats async {
    final List<String>? stats = (await _prefs).getStringList(prefDefaultStats);
    final List<DefaultStat> defaultStats =
        stats?.map((json) => _getDefaultStat(json)).whereNotNull().toList() ??
            [];
    return defaultStats;
  }

  Future<int> get statCount async {
    final count = (await _prefs).getInt(prefDefaultStatsCount) ?? 0;
    return count;
  }

  Future<void> checkToInitLastSentAt() async {
    final prefs = await _prefs;
    int? lastSentAt = prefs.getInt(prefDefaultStatsLastSentAt);

    if (lastSentAt == null) {
      lastSentAt = DateTime.now().millisecondsSinceEpoch;
      await prefs.setInt(prefDefaultStatsLastSentAt, lastSentAt);
    }
  }

  Future<int> get lastSentAt async {
    final prefs = await _prefs;
    int? lastSentAt = prefs.getInt(prefDefaultStatsLastSentAt);

    if (lastSentAt == null) {
      lastSentAt = DateTime.now().millisecondsSinceEpoch;
      await prefs.setInt(prefDefaultStatsLastSentAt, lastSentAt);
    }
    return lastSentAt;
  }

  Future<String> get deviceId async {
    final prefs = (await _prefs);
    String? deviceId = prefs.getString(prefDefaultStatsDeviceId);
    if (deviceId == null) {
      deviceId = const Uuid().v1();
      prefs.setString(prefDefaultStatsDeviceId, deviceId);
    }
    return deviceId;
  }

  DefaultStat? _getDefaultStat(String json) {
    Map<String, dynamic> stat = jsonDecode(json);
    final type = stat['stat_type'] as String;
    final ts = stat['ts'] as int;
    final data = stat['data'] as Map<String, dynamic>;
    final statType = StatUtils.getStatType(type);

    if (statType != null) {
      switch (statType) {
        case StatType.apiResult:
          return ApiResultStat.fromJson(ts: ts, data: data);
        case StatType.wsConnect:
          return WsConnectStat.fromJson(ts: ts, data: data);
        case StatType.featureLocalCache:
          return null;
        case StatType.notificationStats:
          return NotificationStat.fromJson(ts: ts, data: data);
      }
    }
    return null;
  }

  Future<void> putStats(List<DefaultStat> stats) async {
    sbLog.d(StackTrace.current);

    final prefs = (await _prefs);
    final List<String> statsString =
        stats.map((stat) => jsonEncode(stat)).whereNotNull().toList();
    await prefs.setStringList(prefDefaultStats, statsString);
    await prefs.setInt(prefDefaultStatsCount, stats.length);
  }

  Future<void> appendStat(DefaultStat stat) async {
    sbLog.d(StackTrace.current);

    await putStats((await stats)..add(stat));
  }

  Future<void> updateLastSentAt(int ts) async {
    sbLog.d(StackTrace.current);

    if (ts > (await lastSentAt)) {
      await (await _prefs).setInt(prefDefaultStatsLastSentAt, ts);
    }
  }

  Future<void> clearDisallowedStats(Set<StatType> allowedStatTypes) async {
    sbLog.d(StackTrace.current);

    await putStats((await stats)
        .where((stat) => allowedStatTypes.contains(stat.type))
        .toList());
  }

  Future<void> clearAll() async {
    sbLog.d(StackTrace.current);

    final prefs = (await _prefs);
    await prefs.remove(prefDefaultStats);
    await prefs.remove(prefDefaultStatsCount);
    await prefs.remove(prefDefaultStatsLastSentAt);
    await prefs.remove(prefDefaultStatsDeviceId);
  }
}
