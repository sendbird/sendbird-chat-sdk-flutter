// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat/src/internal/network/websocket/command/command_type.dart';
import 'package:sendbird_chat/src/public/main/define/enums.dart';
import 'package:sendbird_chat/src/public/main/params/message/user_message_update_params.dart';

class ChannelUserMessageUpdateRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  ChannelUserMessageUpdateRequest(
    Chat chat, {
    required UserMessageUpdateParams params,
    required ChannelType channelType,
    required String channelUrl,
    required int messageId,
    String? senderId,
    List<String>? additionalMentionedUserIds,
  }) : super(chat: chat, userId: senderId) {
    url = '${channelType.urlString}/$channelUrl/messages/$messageId';

    body = {
      'message_type': CommandString.userMessage,
      'user_id': senderId ?? chat.chatContext.currentUserId,
      if (additionalMentionedUserIds != null)
        'mentioned_user_ids': additionalMentionedUserIds,
    };

    body.addAll(params.toJson());
    body.removeWhere((key, value) => value == null);
  }
}
