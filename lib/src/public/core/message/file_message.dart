// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/type_checker.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
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
import 'package:sendbird_chat_sdk/src/public/main/params/message/file_message_create_params.dart';
import 'package:universal_io/io.dart';
import 'package:uuid/uuid.dart';

part 'file_message.g.dart';

/// Object representing a file.
@JsonSerializable()
class FileMessage extends BaseMessage {
  /// The file URL.
  final String url;

  /// The secure file URL.
  String? get secureUrl {
    final eKey = chat.chatContext.eKey;
    if (requireAuth && eKey != null) {
      // https://github.com/flutter/flutter/issues/25107
      // final urlString = url.replaceAll('https://', 'http://');
      return '$url?auth=$eKey';
    }
    return url;
  }

  /// Represents the name of the file.
  String? name;

  /// Represents the size of the file.
  int? size;

  /// Represents the type of the file. **MIME preferred.**
  String? type;

  /// Represents the thumbnail information of image file.
  /// To make thumbnail of image when you send it,
  /// please refer to [BaseChannelMessage.sendFileMessage].
  List<Thumbnail>? thumbnails;

  /// [FileMessageCreateParams] object that used for sending this message.
  @JsonKey(includeFromJson: false, includeToJson: false)
  FileMessageCreateParams? messageCreateParams;

  bool requireAuth;

  @JsonKey(includeFromJson: false, includeToJson: false)
  File? file;

  FileMessage({
    required String channelUrl,
    required ChannelType channelType,
    required int messageId,
    required this.url,
    this.name,
    this.size = 0,
    this.type,
    this.thumbnails,
    this.requireAuth = false,
    this.file,
    String? requestId,
    String? message,
    SendingStatus? sendingStatus,
    Sender? sender,
    List<User> mentionedUsers = const [],
    MentionType mentionType = MentionType.users,
    List<String>? requestedMentionUserIds,
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

  factory FileMessage.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? file = json['file'];
    if (file != null) {
      json['url'] = file['url'];
      json['type'] = file['type'];
      json['size'] = file['size'];
      json['name'] = file['name'];
      json['data'] = file['data'];
      json['require_auth'] = json['require_auth'] ?? file['require_auth'];
    }

    FileMessage fileMessage = _$FileMessageFromJson(json)
      ..set(SendbirdChat().chat); // Set the singleton chat

    if (fileMessage.thumbnails != null && fileMessage.thumbnails!.isNotEmpty) {
      for (final thumbnail in fileMessage.thumbnails!) {
        thumbnail.set(
          chat: fileMessage.chat,
          requireAuth: fileMessage.requireAuth,
        );
      }
    }

    // Scheduled message
    if (json['scheduled_message_id'] != null) {
      fileMessage.scheduledInfo = ScheduledInfo.fromJson(json);
    }
    return fileMessage;
  }

  factory FileMessage.fromJsonWithChat(Chat chat, Map<String, dynamic> json) {
    return FileMessage.fromJson(json)..set(chat);
  }

  @override
  Map<String, dynamic> toJson() {
    final json = _$FileMessageToJson(this);
    json['message_type'] = MessageType.file.name; // Check
    return json;
  }

  factory FileMessage.fromParams({
    required FileMessageCreateParams params,
    required BaseChannel channel,
  }) {
    final message = FileMessage(
      channelType: channel.channelType,
      channelUrl: channel.channelUrl,
      messageId: 0,
      requestId: const Uuid().v1(),
      // BaseMessageCreateParams
      data: params.data,
      customType: params.customType,
      mentionType: params.mentionType,
      metaArrays: params.metaArrays,
      parentMessageId: params.parentMessageId,
      replyToChannel: params.replyToChannel,
      // FileMessageCreateParams
      url: params.fileInfo.fileUrl ?? '',
      file: params.fileInfo.file,
      name: params.fileInfo.fileName,
      type: params.fileInfo.mimeType,
      size: params.fileInfo.fileSize ?? 0,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      requireAuth: false,
    );
    return message;
  }

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;
    if (!(super == (other))) return false;

    final eq = const ListEquality().equals;
    return other is FileMessage &&
        other.url == url &&
        other.name == name &&
        other.size == size &&
        other.type == type &&
        eq(other.thumbnails, thumbnails) &&
        other.requireAuth == requireAuth;
  }

  @override
  int get hashCode => Object.hash(
        super.hashCode,
        url,
        name,
        size,
        type,
        thumbnails,
        requireAuth,
      );
}

/// An object represents thumbnail
@JsonSerializable()
class Thumbnail {
  @JsonKey(includeFromJson: false, includeToJson: false)
  Chat? _chat;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? _requireAuth;

  String url;
  String? plainUrl; // This property is always null. This will be removed.
  double? height;
  double? width;
  double? realHeight;
  double? realWidth;

  Thumbnail(
    this.url,
    this.plainUrl,
    this.height,
    this.width,
    this.realHeight,
    this.realWidth,
  );

  void set({required Chat chat, required bool requireAuth}) {
    _chat = chat;
    _requireAuth = requireAuth;
  }

  /// The secure thumbnail URL.
  /// @since 4.2.5
  String? get secureUrl {
    if (_chat != null && _requireAuth != null) {
      final eKey = _chat!.chatContext.eKey;
      if (_requireAuth! && eKey != null) {
        return '$url?auth=$eKey';
      }
    }
    return url;
  }

  factory Thumbnail.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;

    return other is Thumbnail &&
        other.url == url &&
        other.plainUrl == plainUrl &&
        other.height == height &&
        other.width == width &&
        other.realWidth == realWidth &&
        other.realHeight == realHeight;
  }

  @override
  int get hashCode => Object.hash(
        url,
        plainUrl,
        height,
        width,
        realHeight,
        realWidth,
      );
}
