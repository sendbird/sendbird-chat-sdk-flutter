// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/default_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_type.dart';

class NotificationStat extends DefaultStat {
  final String action;
  final String templateKey;
  final String channelUrl;
  final List<String> tags;
  final String messageId;
  final String source;
  final int messageTs;

  NotificationStat({
    required int ts,
    required this.action,
    required this.templateKey,
    required this.channelUrl,
    required this.tags,
    required this.messageId,
    required this.source,
    required this.messageTs,
  }) : super(StatType.notificationStats, ts);

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'action': action,
      'template_key': templateKey,
      'channel_url': channelUrl,
      'tags': tags,
      'message_id': messageId,
      'source': source,
      'message_ts': messageTs,
    };
    final result = super.toJson();
    result['data'] = json;
    return result;
  }

  // {
  //   'stat_type' : 'noti:stats',
  //   'ts': int, // timestamp for log creation,
  //   'data' : {
  //     'action': String, // 'clicked'
  //     'template_key': String,
  //     'channel_url': String,
  //     'tags': List<String>,
  //     'message_id': int,
  //     'source': 'notification',
  //     'message_ts': int,
  //   },
  // }
  static NotificationStat? fromJson({
    required int ts,
    required Map<String, dynamic> data,
  }) {
    try {
      final String? action = data['action'] as String?;
      final String? templateKey = data['template_key'] as String?;
      final String? channelUrl = data['channel_url'] as String?;
      final List<String> tags = (data['tags'] as List<dynamic>?)
              ?.map((tag) => tag as String)
              .toList() ??
          [];
      final String? messageId = data['message_id'];
      final String? source = data['source'] as String?;
      final int? messageTs = data['message_ts'] as int?;

      if (action == null ||
          templateKey == null ||
          channelUrl == null ||
          messageId == null ||
          source == null ||
          messageTs == null) {
        return null;
      }

      return NotificationStat(
        ts: ts,
        action: action,
        templateKey: templateKey,
        channelUrl: channelUrl,
        tags: tags,
        messageId: messageId,
        source: source,
        messageTs: messageTs,
      );
    } catch (e) {
      sbLog.d(StackTrace.current, 'e: ${e.toString()}');
    }
    return null;
  }
}
