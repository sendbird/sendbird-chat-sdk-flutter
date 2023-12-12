// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/enum_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/unread_message_count.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/channel/group_channel_total_unread_message_count_params.dart';

class UserTotalUnreadMessageCountGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  UserTotalUnreadMessageCountGetRequest(
    Chat chat, {
    GroupChannelTotalUnreadMessageCountParams? params,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/unread_message_count';
    final customTypes = params?.channelCustomTypes ?? [];
    final superFilter = params?.superChannelFilter ?? SuperChannelFilter.all;
    queryParams = {
      if (customTypes.isNotEmpty) 'custom_types': customTypes,
      'super_mode': groupChannelSuperFilterEnum(superFilter),
      if (chat.chatContext.appInfo?.notificationInfo?.feedChannels.isNotEmpty ??
          false)
        'include_feed_channel': true,
    };
  }

  @override
  Future<UnreadMessageCount> response(Map<String, dynamic> res) async {
    final int groupChannelUnreadMessageCount = res['unread_count'] ?? 0;
    final int feedChannelUnreadMessageCount = res['unread_feed_count'] ?? 0;
    return UnreadMessageCount(
      totalCountForGroupChannels: groupChannelUnreadMessageCount,
      totalCountForFeedChannels: feedChannelUnreadMessageCount,
      totalCountByCustomType: {},
    );
  }
}
