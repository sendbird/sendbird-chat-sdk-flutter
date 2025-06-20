// Copyright (c) 2025 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/event_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';

class GroupChannelMarkAsReadRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  GroupChannelMarkAsReadRequest(
    Chat chat, {
    required String channelUrl,
    required int messageId,
    required bool
        isExcluded, // Whether to exclude read processing for the specified message
    String? uniqueId,
  }) : super(chat: chat) {
    url = 'group_channels/$channelUrl/messages/mark_as_read';

    body = {
      'message_id': messageId,
      'user_id': userId,
      'is_excluded': isExcluded,
    };

    if (uniqueId != null) {
      body['unique_id'] = uniqueId;
    }
  }

  @override
  Future<void> response(Map<String, dynamic> res) async {
    if (res['channel_url'] != null && res['channel_url'] is String) {
      final channel =
          await GroupChannel.getChannel(res['channel_url'] as String);

      bool isMyLastReadChanged = false;
      if (res['ts'] != null && res['ts'] is int) {
        isMyLastReadChanged = (channel.myLastRead != res['ts'] as int);
        channel.myLastRead = res['ts'] as int;
      }

      bool isUnreadMessageCountChanged = false;
      if (res['unread_message_count'] != null &&
          res['unread_message_count'] is int) {
        isUnreadMessageCountChanged =
            (channel.unreadMessageCount != res['unread_message_count'] as int);
        channel.unreadMessageCount = res['unread_message_count'] as int;
      }

      channel.saveToCache(chat);

      if (isMyLastReadChanged) {
        chat.eventManager.notifyReadStatusUpdated(
          channel: channel,
          readType: ReadType.unread,
          userIds: [if (chat.currentUser != null) chat.currentUser!.userId],
        );
      }

      if (isUnreadMessageCountChanged) {
        chat.eventManager.notifyChannelChanged(channel);
      }

      // `total_unread_count` is processed by `unread_cnt` in `propChanged` event.
      // if (res['total_unread_count'] != null) {
      //   chat.commandManager
      //       .processUnreadMessageCountPayload(res['total_unread_count']);
      // }
    }
  }
}
