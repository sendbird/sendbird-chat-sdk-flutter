// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';

class UserPushSoundSetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  UserPushSoundSetRequest(
    Chat chat,
    String sound, {
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/push_preference';
    body = {'push_sound': sound};
  }
}

class UserPushSoundGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  UserPushSoundGetRequest(
    Chat chat, {
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/push_preference';
  }

  @override
  Future<String> response(Map<String, dynamic> res) async {
    return res['push_sound'];
  }
}
