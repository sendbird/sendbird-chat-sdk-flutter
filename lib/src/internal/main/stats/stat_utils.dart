// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
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
      case StatType.notificationStats:
        return 'noti:stats';
    }
  }
}
