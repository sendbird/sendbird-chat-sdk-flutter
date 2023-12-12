// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/command/command_type.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/user_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/user_message_create_params.dart';

class ChannelUserMessageSendRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  ChannelType channelType;

  ChannelUserMessageSendRequest(
    Chat chat, {
    required UserMessageCreateParams params,
    required this.channelType,
    required String channelUrl,
    String? senderId,
    bool markAsRead = false,
    List<String>? additionalMentionedUserIds,
  }) : super(chat: chat, userId: senderId) {
    url = '${channelType.urlString}/$channelUrl/messages';
    body = {
      'message_type': CommandString.userMessage,
      'user_id': senderId,
      'mark_as_read': markAsRead,
      if (additionalMentionedUserIds != null)
        'mentioned_user_ids': additionalMentionedUserIds,
    };

    body.addAll(params.toJson());
    body.removeWhere((key, value) => value == null);
  }

  @override
  Future<BaseMessage> response(Map<String, dynamic> res) async {
    return RootMessage.getMessageFromJsonWithChat<UserMessage>(chat, res,
        channelType: channelType) as BaseMessage;
  }
}
