// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';

class GroupChannelFreezeSetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  GroupChannelFreezeSetRequest(
    Chat chat, {
    required String channelUrl,
    required bool freeze,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'group_channels/$channelUrl/freeze';
    body = {'freeze': freeze};
  }
}
