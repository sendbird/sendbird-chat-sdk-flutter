// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

class ChannelMetaCounterDeleteRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.delete;

  ChannelMetaCounterDeleteRequest(
    Chat chat, {
    required ChannelType channelType,
    required String channelUrl,
    required String key,
  }) : super(chat: chat) {
    url = '${channelType.urlString}/$channelUrl/metacounter/$key';
  }
}

class ChannelMetaCounterDeleteAllRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.delete;

  ChannelMetaCounterDeleteAllRequest(
    Chat chat, {
    required ChannelType channelType,
    required String channelUrl,
  }) : super(chat: chat) {
    url = '${channelType.urlString}/$channelUrl/metacounter';
  }
}
