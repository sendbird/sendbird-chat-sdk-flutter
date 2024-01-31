// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/model/daily_record/daily_record_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/model/daily_record/local_cache_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_type.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyRecordStatPrefs {
  final deleted = 'deleted';

  SharedPreferences? _sharedPreferences;

  Future<SharedPreferences> get _prefs async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  Future<List<DailyRecordStat>> get stats async {
    sbLog.d(StackTrace.current);

    final prefs = (await _prefs);
    final dailyRecordStats = prefs
        .getKeys()
        .map((key) {
          if (key.contains(DailyRecordStat.keyPrefix)) {
            final json = prefs.getString(key);
            if (json != null && json.isNotEmpty) {
              return _getDailyRecordStat(json);
            }
            return null;
          }
        })
        .whereNotNull()
        .toList();

    return dailyRecordStats;
  }

  Future<List<DailyRecordStat>> get uploadCandidateStats async {
    sbLog.d(StackTrace.current);

    final prefs = (await _prefs);
    final now = DateTime.now().millisecondsSinceEpoch;
    final todayDateString = DailyRecordStat.getDateString(now);
    final dailyRecordStats = prefs
        .getKeys()
        .map((key) {
          if (key.contains(DailyRecordStat.keyPrefix) &&
              key.contains(todayDateString) == false) {
            final json = prefs.getString(key);
            if (json != null && json.isNotEmpty) {
              return _getDailyRecordStat(json);
            }
          }
          return null;
        })
        .whereNotNull()
        .toList();

    return dailyRecordStats;
  }

  Future<int> get uploadCandidateStatCount async {
    sbLog.d(StackTrace.current);

    final prefs = (await _prefs);
    final now = DateTime.now().millisecondsSinceEpoch;
    final todayDateString = DailyRecordStat.getDateString(now);
    final count = prefs
        .getKeys()
        .where((key) => (key.contains(DailyRecordStat.keyPrefix) &&
            key.contains(todayDateString) == false))
        .length;

    return count;
  }

  DailyRecordStat? _getDailyRecordStat(String json) {
    if (json == deleted) return null;

    Map<String, dynamic> stat = jsonDecode(json);
    final type = stat['stat_type'] as String;
    final ts = stat['ts'] as int;
    final data = stat['data'] as Map<String, dynamic>;
    final statType = StatUtils.getStatType(type);

    if (statType != null) {
      switch (statType) {
        case StatType.apiResult:
          return null;
        case StatType.wsConnect:
          return null;
        case StatType.featureLocalCache:
          return LocalCacheStat.fromJson(ts: ts, data: data);
        case StatType.featureLocalCacheEvent:
          return null;
        case StatType.notificationStats:
          return null;
      }
    }
    return null;
  }

  Future<void> upsert(DailyRecordStat stat) async {
    sbLog.d(StackTrace.current);

    final prefs = (await _prefs);
    final json = prefs.getString(stat.key);

    if (json != null && json.isNotEmpty) {
      if (json == deleted) return;

      final newStat = _getDailyRecordStat(json);
      if (newStat != null) {
        newStat.update(stat);
        await prefs.setString(newStat.key, jsonEncode(newStat));
      }
    } else {
      await prefs.setString(stat.key, jsonEncode(stat));
    }
  }

  Future<void> remove(List<DailyRecordStat> stats) async {
    sbLog.d(StackTrace.current);

    final prefs = (await _prefs);
    for (final stat in stats) {
      await prefs.setString(stat.key, deleted);
    }
  }

  Future<void> clearDisallowedStats(Set<StatType> allowedStatTypes) async {
    sbLog.d(StackTrace.current);

    final prefs = (await _prefs);
    for (final key in prefs.getKeys()) {
      if (key.contains(DailyRecordStat.keyPrefix)) {
        final json = prefs.getString(key);
        if (json != null && json.isNotEmpty) {
          final dailyRecordStat = _getDailyRecordStat(json);
          if (dailyRecordStat != null) {
            if (allowedStatTypes.contains(dailyRecordStat.type) == false) {
              await prefs.remove(key);
            }
          }
        }
      }
    }
  }

  Future<void> clearAll() async {
    sbLog.d(StackTrace.current);

    final prefs = (await _prefs);
    for (final key in prefs.getKeys()) {
      if (key.contains(DailyRecordStat.keyPrefix)) {
        await prefs.remove(key);
      }
    }
  }
}
