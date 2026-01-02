// Copyright (c) 2025 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/command/command_type.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/mfm/multiple_files_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/mfm/multiple_files_message_create_params.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

class ChannelMultipleFilesMessageSendRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  ChannelType channelType;

  ChannelMultipleFilesMessageSendRequest(
    Chat chat, {
    required this.channelType,
    required String channelUrl,
    required MultipleFilesMessageCreateParams params,
    required List<bool?> requireAuthList,
    required List<List<dynamic>?> thumbnailsList,
    String? senderId,
    bool markAsRead = false,
    List<String>? additionalMentionedUserIds,
    String? requestId,
  }) : super(chat: chat) {
    url = '${channelType.urlString}/$channelUrl/messages';

    List<Map<String, dynamic>> uploadableFileInfoList = [];
    for (int i = 0; i < params.uploadableFileInfoList.length; i++) {
      final uploadableFileInfo = params.uploadableFileInfoList[i];
      if (uploadableFileInfo != null) {
        final fileInfo = {
          'url': uploadableFileInfo.fileInfo.fileUrl,
          'file_name': uploadableFileInfo.fileInfo.fileName,
          'file_type': uploadableFileInfo.fileInfo.mimeType,
          'file_size': uploadableFileInfo.fileInfo.fileSize,
          'require_auth': requireAuthList[i],
          'thumbnails': thumbnailsList[i],
        };
        fileInfo.removeWhere((key, value) => value == null);
        uploadableFileInfoList.add(fileInfo);
      }
    }

    body = {
      'message_type': CommandString.fileMessage,
      'user_id': senderId ?? chat.chatContext.currentUserId,
      'mark_as_read': markAsRead,
      'mentioned_user_ids': additionalMentionedUserIds,
      'req_id': requestId,
      'files': uploadableFileInfoList,
    };

    body.addAll(params.toJson());
    body.removeWhere((key, value) => value == null);
  }

  @override
  Future<MultipleFilesMessage> response(Map<String, dynamic> res) async {
    return RootMessage.getMessageFromJsonWithChat<MultipleFilesMessage>(
      chat,
      res,
      channelType: channelType,
    ) as MultipleFilesMessage;
  }
}
