// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';

class GroupChannelHistoryResetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  GroupChannelHistoryResetRequest(
    Chat chat, {
    required String channelUrl,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'group_channels/$channelUrl/reset_user_history';
  }

  @override
  Future<int> response(Map<String, dynamic> res) async {
    return res['ts_message_offset'];
  }
}
