// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';

class GroupChannelMarkAsReadRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  GroupChannelMarkAsReadRequest(
    Chat chat, {
    List<String>? channelUrls,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/mark_as_read_all';
    body = {
      if (channelUrls != null && channelUrls.isNotEmpty)
        'channel_urls': channelUrls,
    };
  }
}
