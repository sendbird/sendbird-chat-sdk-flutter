// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';

class GroupChannelMarkAsDeliveredRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  GroupChannelMarkAsDeliveredRequest(
    Chat chat, {
    required String channelUrl,
    required String userId,
    required int timestamp,
  }) : super(chat: chat, userId: userId) {
    url = 'group_channels/$channelUrl/messages/mark_as_delivered';
    body = {'user_id': userId, 'ts': timestamp};
  }

  @override
  Future<int> response(Map<String, dynamic> res) async {
    return res['ts'];
  }
}
