// Copyright (c) 2025 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';

class GroupChannelMessageDeletionTimestampGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  GroupChannelMessageDeletionTimestampGetRequest(
    Chat chat,
    String channelUrl,
  ) : super(chat: chat) {
    url = 'group_channels/$channelUrl/message_purge_offset';
  }

  @override
  Future<int?> response(Map<String, dynamic> res) async {
    final messagePurgeOffset = res['message_purge_offset'];
    if (messagePurgeOffset != null && messagePurgeOffset is int) {
      return messagePurgeOffset;
    }
    return null;
  }
}
