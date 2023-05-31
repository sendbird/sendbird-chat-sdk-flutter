// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat/src/public/main/params/message/total_scheduled_message_count_params.dart';

class GroupChannelScheduledMessageTotalCountRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  GroupChannelScheduledMessageTotalCountRequest(
    Chat chat, {
    TotalScheduledMessageCountParams? params,
  }) : super(chat: chat) {
    url = 'scheduled_messages/count';
    if (params != null) {
      queryParams.addAll(params.toJson());
    }
  }

  @override
  Future<int> response(Map<String, dynamic> res) async {
    return res['count'];
  }
}
