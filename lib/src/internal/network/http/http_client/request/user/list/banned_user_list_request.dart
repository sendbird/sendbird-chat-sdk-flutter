// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/restricted_user.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';

class BannedUserListRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  BannedUserListRequest(
    Chat chat, {
    required int limit,
    required ChannelType channelType,
    required String channelUrl,
    String? token,
  }) : super(chat: chat) {
    url = '${channelType.urlString}/$channelUrl/ban';
    queryParams = {
      'limit': limit,
      if (token != null) 'token': token,
    };
  }

  @override
  Future<UserListQueryResponse> response(Map<String, dynamic> res) async {
    final users = List<Map>.from(res['banned_list']);
    for (final e in users) {
      e['type'] = 'banned';
    }

    final output = {'users': users, 'next': res['next']};
    return UserListQueryResponse<RestrictedUser>.fromJsonWithChat(chat, output);
  }
}
