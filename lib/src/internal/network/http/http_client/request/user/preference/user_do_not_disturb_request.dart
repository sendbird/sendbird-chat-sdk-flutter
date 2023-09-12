// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/chat/do_not_disturb.dart';

class UserDoNotDisturbSetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  UserDoNotDisturbSetRequest(
    Chat chat, {
    required bool enable,
    int startHour = 0,
    int startMin = 0,
    int endHour = 23,
    int endMin = 59,
    String timezone = 'UTC',
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/push_preference';
    body = {
      'do_not_disturb': enable,
      'start_hour': startHour,
      'start_min': startMin,
      'end_hour': endHour,
      'end_min': endMin,
      'timezone': timezone
    };
  }
}

class UserDoNotDisturbGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  UserDoNotDisturbGetRequest(
    Chat chat, {
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/push_preference';
  }

  @override
  Future<DoNotDisturb> response(Map<String, dynamic> res) async {
    return DoNotDisturb.fromJson(res);
  }
}
