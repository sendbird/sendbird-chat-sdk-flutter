// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat/src/public/main/define/enums.dart';

class UserPushTokenUnregisterRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.delete;

  UserPushTokenUnregisterRequest(
    Chat chat, {
    required PushTokenType type,
    required String token,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    final typeString = type == PushTokenType.fcm ? 'gcm' : type.asString();
    url =
        'users/${userId ?? chat.chatContext.currentUserId}/push/$typeString/$token';
  }
}

class UserPushTokenUnregisterAllRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.delete;

  UserPushTokenUnregisterAllRequest(
    Chat chat, {
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${userId ?? chat.chatContext.currentUserId}/push';
  }
}
