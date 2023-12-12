// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/channel/group_channel_unread_item_count.dart';

class UserUnreadItemCountGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  final unreadItemKeyEnumMap = <UnreadItemKey, String>{
    UnreadItemKey.nonSuperGroupChannelUnreadMessageCount:
        'non_super_group_channel_unread_message_count',
    UnreadItemKey.superGroupChannelUnreadMessageCount:
        'super_group_channel_unread_message_count',
    UnreadItemKey.groupChannelUnreadMessageCount:
        'group_channel_unread_message_count',
    UnreadItemKey.nonSuperGroupChannelUnreadMentionCount:
        'non_super_group_channel_unread_mention_count',
    UnreadItemKey.superGroupChannelUnreadMentionCount:
        'super_group_channel_unread_mention_count',
    UnreadItemKey.groupChannelUnreadMentionCount:
        'group_channel_unread_mention_count',
    UnreadItemKey.nonSuperGroupChannelInvitationCount:
        'non_super_group_channel_invitation_count',
    UnreadItemKey.superGroupChannelInvitationCount:
        'super_group_channel_invitation_count',
    UnreadItemKey.groupChannelInvitationCount: 'group_channel_invitation_count',
  };

  UserUnreadItemCountGetRequest(
    Chat chat,
    List<UnreadItemKey> keys, {
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/unread_item_count';
    queryParams = {
      'item_keys': keys.map((e) => unreadItemKeyEnumMap[e]).toList()
    };
  }

  @override
  Future<GroupChannelUnreadItemCount> response(Map<String, dynamic> res) async {
    return GroupChannelUnreadItemCount.fromJson(res);
  }
}
