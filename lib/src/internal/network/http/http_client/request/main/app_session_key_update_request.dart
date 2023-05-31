// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';

class AppSessionKeyUpdateRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  AppSessionKeyUpdateRequest(
    Chat chat, {
    required String appId,
    required String accessToken,
    bool expiringSession = false,
    String? userId,
  }) : super(chat: chat) {
    url = 'users/${userId ?? chat.chatContext.currentUserId}/session_key';
    body = {'expiring_session': expiringSession};
    headers = {'App-Id': appId, 'Access-Token': accessToken};
  }

  @override
  Future<Map<String, dynamic>> response(Map<String, dynamic> res) async {
    return Map.from(res);
  }
}
