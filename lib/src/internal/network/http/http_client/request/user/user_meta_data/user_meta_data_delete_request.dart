// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';

class UserMetaDataDeleteRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.delete;

  UserMetaDataDeleteRequest(
    Chat chat,
    String key, {
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/metadata/$key';
  }
}

class UserMetaDataDeleteAllRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.delete;

  UserMetaDataDeleteAllRequest(
    Chat chat, {
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/metadata';
  }
}
