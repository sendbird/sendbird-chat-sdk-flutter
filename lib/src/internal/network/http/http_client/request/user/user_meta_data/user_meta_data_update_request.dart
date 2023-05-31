// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';

class UserMetaDataUpdateRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  UserMetaDataUpdateRequest(
    Chat chat,
    Map<String, String> metaData, {
    String? userId,
    bool upsert = true,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${userId ?? chat.chatContext.currentUserId}/metadata';
    body = {'metadata': metaData, 'upsert': upsert};
  }

  @override
  Future<Map> response(Map<String, dynamic> res) async {
    return Map.from(res);
  }
}
