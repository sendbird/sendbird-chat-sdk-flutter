// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';

class ChannelInvitationPreferenceSetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  ChannelInvitationPreferenceSetRequest(
    Chat chat,
    bool autoAccept, {
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url =
        'users/${getUrlEncodedUserId(chat, userId)}/channel_invitation_preference';
    body = {'auto_accept': autoAccept};
  }
}

class ChannelInvitationPreferenceGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  ChannelInvitationPreferenceGetRequest(
    Chat chat, {
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url =
        'users/${getUrlEncodedUserId(chat, userId)}/channel_invitation_preference';
  }

  @override
  Future<bool> response(Map<String, dynamic> res) async {
    return res['auto_accept'] as bool;
  }
}
