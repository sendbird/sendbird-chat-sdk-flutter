// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';

class AppSessionKeyUpdateRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  AppSessionKeyUpdateRequest(
    Chat chat, {
    required String appId,
    String? accessToken,
    String? userId,
  }) : super(chat: chat) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/session_key';

    headers = {'App-Id': appId};

    if (accessToken != null) {
      headers['Access-Token'] = accessToken;
    }

    body = {
      'expiring_session': chat.chatContext.isFeedAuthenticated
          ? true
          : (chat.eventManager.getSessionHandler() != null),
    };

    if (chat.chatContext.isChatConnected) {
      body['services'] = ['chat', 'feed'];
    } else if (chat.chatContext.isFeedAuthenticated) {
      body['services'] = ['feed'];
    }
  }

  @override
  Future<Map<String, dynamic>> response(Map<String, dynamic> res) async {
    return Map.from(res);
  }
}
