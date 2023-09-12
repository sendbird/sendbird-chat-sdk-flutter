// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';

class AuthenticateFeedRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  AuthenticateFeedRequest(
    Chat chat,
    String userId, {
    String? accessToken,
    String? apiHost,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/login';

    isAuthenticateFeed = true; // Check

    headers = {
      if (accessToken != null) 'Access-Token': accessToken,
    };

    final expiringSession =
        accessToken == null || chat.eventManager.getSessionHandler() != null;

    body = {
      'userId': userId,
      'expiring_session': expiringSession,
      'services': ['feed'],
      'app_id': chat.chatContext.appId,
      'include_logi': true,
      'include_extra_data': chat.extraData.join(','),
    };
    body.removeWhere((key, value) => value == null);

    if (apiHost != null) chat.chatContext.apiHost = apiHost;
  }

  @override
  Future<User> response(Map<String, dynamic> res) async {
    chat.commandManager.processUnreadMessageCountPayload(res);
    await chat.commandManager
        .processLoginPayload(fromWebSocket: false, loginPayload: res);
    return chat.chatContext.currentUser!;
  }
}
