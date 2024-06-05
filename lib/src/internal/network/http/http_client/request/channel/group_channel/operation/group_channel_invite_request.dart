// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';

class GroupChannelInviteRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  GroupChannelInviteRequest(
    Chat chat, {
    required String channelUrl,
    required List<String> userIds,
    String? inviterId,
  }) : super(chat: chat) {
    url = 'group_channels/$channelUrl/invite';
    body = {
      'inviter_id': inviterId ?? chat.chatContext.currentUserId,
      'user_ids': userIds,
    };
  }

  @override
  Future<GroupChannel> response(Map<String, dynamic> res) async {
    final channel = GroupChannel.fromJsonWithChat(chat, res);
    channel.saveToCache(
      chat,
      channel: channel,
      res: res,
    );
    return channel;
  }
}
