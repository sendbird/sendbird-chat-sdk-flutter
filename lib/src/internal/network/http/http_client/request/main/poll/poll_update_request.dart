// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/poll/poll.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/poll/poll_update_params.dart';

class PollUpdateRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  PollUpdateRequest(
    Chat chat, {
    required int pollId,
    required PollUpdateParams params,
  }) : super(chat: chat) {
    url = 'polls/$pollId';
    body.addAll(params.toJson());
    body.removeWhere((key, value) => value == null);
  }

  @override
  Future<Poll> response(Map<String, dynamic> res) async {
    return Poll.fromJson(res);
  }
}
