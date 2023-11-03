// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/command/command_type.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/file_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/file_message_create_params.dart';

class ChannelFileMessageSendRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  ChannelType channelType;

  ChannelFileMessageSendRequest(
    Chat chat, {
    required this.channelType,
    required String channelUrl,
    required FileMessageCreateParams params,
    String? senderId,
    List<dynamic>? thumbnails,
    bool markAsRead = false,
    bool? requireAuth,
    List<String>? additionalMentionedUserIds,
  }) : super(chat: chat) {
    url = '${channelType.urlString}/$channelUrl/messages';

    body = {
      'message_type': CommandString.fileMessage,
      'user_id': senderId ?? chat.chatContext.currentUserId,
      'mark_as_read': markAsRead,
      'require_auth': requireAuth,
      'mentioned_user_ids': additionalMentionedUserIds,
      'thumbnails': thumbnails,
      'file_size': params.fileInfo.fileSize,
      'file_name': params.fileInfo.fileName,
      'file_type': params.fileInfo.mimeType,
      'url': params.fileInfo.fileUrl,
    };

    body.addAll(params.toJson());
    body.removeWhere((key, value) => value == null);
  }

  @override
  Future<FileMessage> response(Map<String, dynamic> res) async {
    return RootMessage.getMessageFromJsonWithChat<FileMessage>(chat, res,
        channelType: channelType) as FileMessage;
  }
}
