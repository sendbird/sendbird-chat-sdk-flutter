// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat/src/public/main/model/poll/poll.dart';

class PollCloseRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  PollCloseRequest(
    Chat chat, {
    required int pollId,
  }) : super(chat: chat) {
    url = 'polls/$pollId/close';
  }

  @override
  Future<Poll> response(Map<String, dynamic> res) async {
    return Poll.fromJson(res);
  }
}
