// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/file_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/scheduled_file_message_create_params.dart';

class GroupChannelScheduledFileMessageSendRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  GroupChannelScheduledFileMessageSendRequest(
    Chat chat, {
    required String channelUrl,
    required ScheduledFileMessageCreateParams params,
  }) : super(chat: chat) {
    if (userId == null) {
      throw InvalidParameterException;
    }
    url = 'group_channels/$channelUrl/scheduled_messages';
    body = {
      'user_id': userId,
      'message_type': 'FILE',
    };
    body.addAll(params.toJson());
    body.remove('file');
  }

  @override
  Future<FileMessage> response(Map<String, dynamic> res) async {
    return FileMessage.fromJsonWithChat(chat, res);
  }
}
