// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat/src/public/main/model/poll/poll.dart';
import 'package:sendbird_chat/src/public/main/params/poll/poll_create_params.dart';

class PollCreateRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  PollCreateRequest(
    Chat chat, {
    required PollCreateParams params,
  }) : super(chat: chat) {
    url = 'polls';

    body.addAll(params.toJson());
    body.removeWhere((key, value) => value == null);
  }

  @override
  Future<Poll> response(Map<String, dynamic> res) async {
    return Poll.fromJson(res);
  }
}
