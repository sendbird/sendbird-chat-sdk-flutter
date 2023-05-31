// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat/src/public/core/message/user_message.dart';
import 'package:sendbird_chat/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat/src/public/main/params/message/scheduled_user_message_create_params.dart';

class GroupChannelScheduledUserMessageSendRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  GroupChannelScheduledUserMessageSendRequest(
    Chat chat, {
    required String channelUrl,
    required ScheduledUserMessageCreateParams params,
  }) : super(chat: chat) {
    if (userId == null) {
      throw InvalidParameterException;
    }
    url = 'group_channels/$channelUrl/scheduled_messages';
    body = {
      'user_id': userId,
      'message_type': 'MESG',
    };
    body.addAll(params.toJson());
  }

  @override
  Future<UserMessage> response(Map<String, dynamic> res) async {
    return UserMessage.fromJsonWithChat(chat, res);
  }
}
