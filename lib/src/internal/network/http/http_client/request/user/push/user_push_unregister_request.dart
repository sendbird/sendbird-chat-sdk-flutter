// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

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
    url = 'users/${getUrlEncodedUserId(chat, userId)}/push/$typeString/$token';
  }

  @override
  Future<int?> response(Map<String, dynamic> res) async {
    if (res.containsKey('device_token_last_deleted_at')) {
      return res['device_token_last_deleted_at'] as int?;
    }
    return null;
  }
}

class UserPushTokenUnregisterAllRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.delete;

  UserPushTokenUnregisterAllRequest(
    Chat chat, {
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/push';
  }

  @override
  Future<int?> response(Map<String, dynamic> res) async {
    if (res.containsKey('device_token_last_deleted_at')) {
      return res['device_token_last_deleted_at'] as int?;
    }
    return null;
  }
}
