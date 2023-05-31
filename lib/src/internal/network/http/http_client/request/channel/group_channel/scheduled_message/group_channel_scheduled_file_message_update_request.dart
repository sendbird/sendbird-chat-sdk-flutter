// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/file_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/scheduled_file_message_update_params.dart';

class GroupChannelScheduledFileMessageUpdateRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  GroupChannelScheduledFileMessageUpdateRequest(
    Chat chat, {
    required String channelUrl,
    required int scheduledMessageId,
    required ScheduledFileMessageUpdateParams params,
  }) : super(chat: chat) {
    url = 'group_channels/$channelUrl/scheduled_messages/$scheduledMessageId';
    body.addAll(params.toJson());
  }

  @override
  Future<FileMessage> response(Map<String, dynamic> res) async {
    return FileMessage.fromJsonWithChat(chat, res);
  }
}
