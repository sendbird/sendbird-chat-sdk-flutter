// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/model/default/local_cache_event_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_type.dart';

class StatUtils {
  static StatType? getStatType(String type) {
    switch (type) {
      case 'api:result':
        return StatType.apiResult;
      case 'ws:connect':
        return StatType.wsConnect;
      case 'feature:local_cache':
        return StatType.featureLocalCache;
      case 'feature:local_cache_event':
        return StatType.featureLocalCacheEvent;
      case 'noti:stats':
        return StatType.notificationStats;
    }
    sbLog.w(StackTrace.current, 'return null');
    return null;
  }

  static String getStatTypeString(StatType type) {
    switch (type) {
      case StatType.apiResult:
        return 'api:result';
      case StatType.wsConnect:
        return 'ws:connect';
      case StatType.featureLocalCache:
        return 'feature:local_cache';
      case StatType.featureLocalCacheEvent:
        return 'feature:local_cache_event';
      case StatType.notificationStats:
        return 'noti:stats';
    }
  }

  static LocalCacheEventMeasuredOn? getLocalCacheEventMeasuredOn(
      String measuredOn) {
    switch (measuredOn) {
      case 'initial_load':
        return LocalCacheEventMeasuredOn.initialLoad;
      case 'load_prev':
        return LocalCacheEventMeasuredOn.loadPrev;
      case 'load_next':
        return LocalCacheEventMeasuredOn.loadNext;
    }
    sbLog.w(StackTrace.current, 'return null');
    return null;
  }

  static String getLocalCacheEventMeasuredOnString(
      LocalCacheEventMeasuredOn measuredOn) {
    switch (measuredOn) {
      case LocalCacheEventMeasuredOn.initialLoad:
        return 'initial_load';
      case LocalCacheEventMeasuredOn.loadPrev:
        return 'load_prev';
      case LocalCacheEventMeasuredOn.loadNext:
        return 'load_next';
    }
  }

  static LocalCacheEvent? getLocalCacheEvent(String event) {
    switch (event) {
      case 'cache_miss':
        return LocalCacheEvent.cacheMiss;
      case 'cache_hit':
        return LocalCacheEvent.cacheHit;
    }
    sbLog.w(StackTrace.current, 'return null');
    return null;
  }

  static String getLocalCacheEventString(LocalCacheEvent event) {
    switch (event) {
      case LocalCacheEvent.cacheMiss:
        return 'cache_miss';
      case LocalCacheEvent.cacheHit:
        return 'cache_hit';
    }
  }
}
