// Copyright (c) 2025 Sendbird, Inc. All rights reserved.

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/type_checker.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/mfm/multiple_files_message_create_params.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/mfm/uploaded_file_info.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/sender.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/info/scheduled_info.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/message_meta_array.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/og/og_meta_data.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/reaction/reaction.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/thread/thread_info.dart';
import 'package:uuid/uuid.dart';

part 'multiple_files_message.g.dart';

/// Represents a multiple files message.
/// @since 4.8.0
@JsonSerializable()
class MultipleFilesMessage extends BaseMessage {
  /// It represents the information of the files stored on the Sendbird server that are included in this file message.
  List<UploadedFileInfo> files;

  /// [MultipleFilesMessageCreateParams] object that used for sending this message.
  @JsonKey(includeFromJson: false, includeToJson: false)
  MultipleFilesMessageCreateParams? messageCreateParams;

  bool requireAuth;

  MultipleFilesMessage({
    required String channelUrl,
    required ChannelType channelType,
    required int messageId,
    required this.files,
    this.requireAuth = false,
    String? requestId,
    String? message,
    SendingStatus? sendingStatus,
    Sender? sender,
    List<User> mentionedUsers = const [],
    MentionType mentionType = MentionType.users,
    int createdAt = 0,
    int updatedAt = 0,
    int? parentMessageId,
    ThreadInfo? threadInfo,
    List<MessageMetaArray>? metaArrays,
    String? customType,
    int? messageSurvivalSeconds,
    bool forceUpdateLastMessage = false,
    bool isSilent = false,
    bool isOperatorMessage = false,
    String? data,
    OGMetaData? ogMetaData,
    List<Reaction>? reactions,
    bool replyToChannel = false,
    Map<String, dynamic>? parentMessage,
  }) : super(
          parentMessage: parentMessage,
          isReplyToChannel: replyToChannel,
          requestId: requestId,
          messageId: messageId,
          message: message ?? '',
          sendingStatus: sendingStatus,
          sender: sender,
          channelUrl: channelUrl,
          channelType: channelType,
          mentionedUsers: mentionedUsers,
          mentionType: mentionType,
          createdAt: createdAt,
          updatedAt: updatedAt,
          parentMessageId: parentMessageId,
          threadInfo: threadInfo,
          allMetaArrays: metaArrays,
          customType: customType,
          messageSurvivalSeconds: messageSurvivalSeconds,
          forceUpdateLastMessage: forceUpdateLastMessage,
          isSilent: isSilent,
          isOperatorMessage: isOperatorMessage,
          data: data,
          ogMetaData: ogMetaData,
          reactions: reactions,
        );

  factory MultipleFilesMessage.fromJson(Map<String, dynamic> json) {
    MultipleFilesMessage multipleFilesMessage =
        _$MultipleFilesMessageFromJson(json)
          ..set(SendbirdChat().chat); // Set the singleton chat

    for (final uploadedFileInfo in multipleFilesMessage.files) {
      if (uploadedFileInfo.thumbnails != null &&
          uploadedFileInfo.thumbnails!.isNotEmpty) {
        for (final thumbnail in uploadedFileInfo.thumbnails!) {
          thumbnail.set(
            chat: multipleFilesMessage.chat,
            requireAuth: multipleFilesMessage.requireAuth,
          );
        }
      }
    }

    // Scheduled message
    if (json['scheduled_message_id'] != null) {
      multipleFilesMessage.scheduledInfo = ScheduledInfo.fromJson(json);
    }
    return multipleFilesMessage;
  }

  factory MultipleFilesMessage.fromJsonWithChat(
      Chat chat, Map<String, dynamic> json) {
    return MultipleFilesMessage.fromJson(json)..set(chat);
  }

  @override
  Map<String, dynamic> toJson() {
    final json = _$MultipleFilesMessageToJson(this);
    json['message_type'] = MessageType.file.name; // Check
    return json;
  }

  factory MultipleFilesMessage.fromParams({
    required MultipleFilesMessageCreateParams params,
    required BaseChannel channel,
  }) {
    List<UploadedFileInfo> files = [];
    for (final uploadableFileInfo in params.uploadableFileInfoList) {
      if (uploadableFileInfo != null) {
        final uploadedFileInfo = UploadedFileInfo(
          url: uploadableFileInfo.fileInfo.fileUrl ?? '',
          name: uploadableFileInfo.fileInfo.fileName,
          size: uploadableFileInfo.fileInfo.fileSize ?? 0,
          type: uploadableFileInfo.fileInfo.mimeType,
          requireAuth: false,
        )..chat = SendbirdChat().chat;
        files.add(uploadedFileInfo);
      }
    }

    final message = MultipleFilesMessage(
      channelType: channel.channelType,
      channelUrl: channel.channelUrl,
      messageId: 0,
      requestId: const Uuid().v4(),
      // BaseMessageCreateParams
      data: params.data,
      customType: params.customType,
      mentionType: params.mentionType,
      metaArrays: params.metaArrays,
      parentMessageId: params.parentMessageId,
      replyToChannel: params.replyToChannel,
      // MultipleFilesMessageCreateParams
      files: files,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      requireAuth: false,
    );

    // mentionedUserIds
    if (params.mentionedUserIds != null &&
        params.mentionedUserIds!.isNotEmpty) {
      message.mentionedUserIds.addAll(params.mentionedUserIds!);
    }
    return message;
  }

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;
    if (!(super == (other))) return false;

    final eq = const ListEquality().equals;
    return other is MultipleFilesMessage &&
        eq(other.files, files) &&
        other.requireAuth == requireAuth;
  }

  @override
  int get hashCode => Object.hash(
        super.hashCode,
        files,
        requireAuth,
      );
}
