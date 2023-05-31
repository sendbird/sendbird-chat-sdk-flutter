// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat/src/public/main/define/enums.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/response/responses.dart';

class MutedUserListRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  MutedUserListRequest(
    Chat chat, {
    required int limit,
    required ChannelType channelType,
    required String channelUrl,
    String? token,
  }) : super(chat: chat) {
    url = '${channelType.urlString}/$channelUrl/mute';
    queryParams = {
      'limit': limit,
      if (token != null) 'token': token,
    };
  }

  @override
  Future<UserListQueryResponse> response(Map<String, dynamic> res) async {
    final output = {'users': res['muted_list'], 'next': res['next']};
    return UserListQueryResponse.fromJsonWithChat(chat, output);
  }
}
