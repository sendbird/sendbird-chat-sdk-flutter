// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat/src/public/core/message/user_message.dart';
import 'package:sendbird_chat/src/public/main/params/message/scheduled_user_message_update_params.dart';

class GroupChannelScheduledUserMessageUpdateRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  GroupChannelScheduledUserMessageUpdateRequest(
    Chat chat, {
    required String channelUrl,
    required int scheduledMessageId,
    required ScheduledUserMessageUpdateParams params,
  }) : super(chat: chat) {
    url = 'group_channels/$channelUrl/scheduled_messages/$scheduledMessageId';

    body.addAll(params.toJson());
  }

  @override
  Future<UserMessage> response(Map<String, dynamic> res) async {
    return UserMessage.fromJsonWithChat(chat, res);
  }
}
