// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';

class BlockedUserListRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  BlockedUserListRequest(
    Chat chat, {
    required int limit,
    List<String> userIds = const [],
    String? token,
    String? userId,
  }) : super(chat: chat) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/block';
    queryParams = {
      'limit': limit,
      if (token != null) 'token': token,
      if (userIds.isNotEmpty) 'user_ids': userIds,
    };
  }

  @override
  Future<UserListQueryResponse> response(Map<String, dynamic> res) async =>
      UserListQueryResponse.fromJsonWithChat(chat, res);
}
