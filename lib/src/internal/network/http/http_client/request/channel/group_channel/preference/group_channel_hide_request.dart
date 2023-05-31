// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';

class GroupChannelHideRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  GroupChannelHideRequest(
    Chat chat,
    String channelUrl, {
    bool hidePreviousMessages = false,
    bool allowAutoUnhide = true,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'group_channels/$channelUrl/hide';
    body = {
      'hide_previous_messages': hidePreviousMessages,
      'allow_auto_unhide': allowAutoUnhide,
    };
  }
}

class GroupChannelUnhideRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.delete;

  GroupChannelUnhideRequest(
    Chat chat, {
    required String channelUrl,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'group_channels/$channelUrl/hide';
  }
}
