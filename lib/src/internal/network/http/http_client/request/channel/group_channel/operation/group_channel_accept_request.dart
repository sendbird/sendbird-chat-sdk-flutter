// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';

class GroupChannelInvitationAcceptRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  GroupChannelInvitationAcceptRequest(
    Chat chat, {
    required String channelUrl,
    String? accessCode,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'group_channels/$channelUrl/accept';
    body = {
      if (accessCode != null) 'access_code': accessCode,
    };
  }
}
