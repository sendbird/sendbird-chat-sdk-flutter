// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';

class PollDeleteRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.delete;

  PollDeleteRequest(
    Chat chat, {
    required int pollId,
  }) : super(chat: chat) {
    url = 'polls/$pollId';
  }
}
