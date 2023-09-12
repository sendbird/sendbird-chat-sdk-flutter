// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';

class UserUnblockRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.delete;

  UserUnblockRequest(
    Chat chat, {
    String? userId,
    required String targetId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/block/$targetId';
    body = {'target_id': targetId};
  }
}
