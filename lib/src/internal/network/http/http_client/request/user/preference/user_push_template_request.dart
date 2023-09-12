// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';

class UserPushTemplateSetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  UserPushTemplateSetRequest(
    Chat chat,
    String name, {
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/push/template';
    body = {'name': name};
  }
}

class UserPushTemplateGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  UserPushTemplateGetRequest(
    Chat chat, {
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/push/template';
  }

  @override
  Future<String> response(Map<String, dynamic> res) async {
    return res['name'];
  }
}
