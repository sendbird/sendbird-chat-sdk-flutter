// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';

class ApplicationUserListRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  ApplicationUserListRequest(
    Chat chat, {
    required int limit,
    String? token,
    String? metaDataKey,
    List<String>? metaDataValues,
    String? nicknameStartsWith,
    List<String>? userIds,
  }) : super(chat: chat) {
    url = 'users';
    queryParams = {
      'limit': limit,
      if (token != null) 'token': token,
      if (userIds != null && userIds.isNotEmpty) 'user_ids': userIds,
      if (metaDataKey != null) 'metadatakey': metaDataKey,
      if (metaDataValues != null && metaDataValues.isNotEmpty)
        'metadatavalues_in': metaDataValues,
      if (nicknameStartsWith != null) 'nickname_startswith': nicknameStartsWith,
    };
  }

  @override
  Future<UserListQueryResponse> response(Map<String, dynamic> res) async =>
      UserListQueryResponse.fromJsonWithChat(chat, res);
}
