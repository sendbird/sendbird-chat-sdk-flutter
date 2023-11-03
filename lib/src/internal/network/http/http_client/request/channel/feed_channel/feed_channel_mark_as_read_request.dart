// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';

class FeedChannelMarkAsReadRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  FeedChannelMarkAsReadRequest(
    Chat chat, {
    required String channelUrl,
    int? timestamp,
    List<String>? messageIds,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'group_channels/$channelUrl/messages/mark_as_read';
    body = {
      'channel_url': channelUrl,
    };

    if (timestamp != null) {
      body['timestamp'] = timestamp;
    }

    if (messageIds != null && messageIds.isNotEmpty) {
      body['message_ids'] = messageIds;
    }
  }

  @override
  Future<Map<String, dynamic>> response(Map<String, dynamic> res) async {
    return res;
  }
}
