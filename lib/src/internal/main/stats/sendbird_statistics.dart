// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';

// For internal use only.
class SendbirdStatistics {
  static const String apiResultType = 'api:result';
  static const String wsConnectType = 'ws:connect';
  static const String wsDisconnectType = 'ws:disconnect';
  static const String featureLocalCacheType = 'feature:local_cache';
  static const String featureLocalCacheEventType = 'feature:local_cache_event';
  static const String notiStatsType = 'noti:stats';

  static Future<bool> appendStat({
    required String type,
    required Map<String, dynamic> data,
    Chat? chat,
  }) async {
    sbLog.i(StackTrace.current, 'type: $type');
    return await (chat ?? SendbirdChat().chat)
        .statManager
        .appendStat(type: type, data: data);
  }
}
