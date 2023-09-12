// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';

class UserMetaDataCreateRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  UserMetaDataCreateRequest(
    Chat chat,
    Map<String, String> metaData, {
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/metadata';
    body = {'metadata': metaData, 'upsert': true};
  }

  @override
  Future<Map> response(Map<String, dynamic> res) async {
    return Map.from(res);
  }
}
