// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';

class GroupChannelScheduledMessageCancelRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.delete;

  GroupChannelScheduledMessageCancelRequest(
    Chat chat, {
    required String channelUrl,
    required int scheduledMessageId,
  }) : super(chat: chat) {
    url = 'group_channels/$channelUrl/scheduled_messages/$scheduledMessageId';
  }
}
