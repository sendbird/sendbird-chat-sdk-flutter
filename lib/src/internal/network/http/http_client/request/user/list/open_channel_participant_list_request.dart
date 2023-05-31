// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/response/responses.dart';

class OpenChannelParticipantListRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  OpenChannelParticipantListRequest(
    Chat chat, {
    required int limit,
    required String channelUrl,
    String? token,
  }) : super(chat: chat) {
    url = 'open_channels/$channelUrl/participants';
    queryParams = {
      'limit': limit,
      if (token != null) 'token': token,
    };
  }

  @override
  Future<UserListQueryResponse> response(Map<String, dynamic> res) async {
    final output = {'users': res['participants'], 'next': res['next']};
    return UserListQueryResponse.fromJsonWithChat(chat, output);
  }
}
