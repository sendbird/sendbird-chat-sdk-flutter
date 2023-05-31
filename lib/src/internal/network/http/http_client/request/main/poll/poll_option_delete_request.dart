// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';

class PollOptionDeleteRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.delete;

  PollOptionDeleteRequest(
    Chat chat, {
    required int pollId,
    required int pollOptionId,
  }) : super(chat: chat) {
    url = 'polls/$pollId/options/$pollOptionId';
  }
}
