// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';

class GroupChannelLeaveRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  GroupChannelLeaveRequest(
    Chat chat, {
    required String channelUrl,
    String? userId,
    bool? shouldRemoveOperatorStatus,
  }) : super(chat: chat, userId: userId) {
    url = 'group_channels/$channelUrl/leave';
    body = {
      'should_remove_operator_status': shouldRemoveOperatorStatus ?? false
    };
  }
}
