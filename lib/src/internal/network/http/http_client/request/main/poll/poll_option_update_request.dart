// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/poll/poll.dart';

class PollOptionUpdateRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  PollOptionUpdateRequest(
    Chat chat, {
    required int pollId,
    required int pollOptionId,
    required String text,
  }) : super(chat: chat) {
    url = 'polls/$pollId/options/$pollOptionId';
    body = {'text': text};
  }

  @override
  Future<Poll> response(Map<String, dynamic> res) async {
    return Poll.fromJson(res);
  }
}
