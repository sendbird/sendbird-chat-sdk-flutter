import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'base_message.dart';

import '../channel/base/base_channel.dart';
import '../channel/group/features/thread_info.dart';
import '../models/meta_array.dart';
import '../models/og_meta_data.dart';
import '../models/reaction.dart';
import '../models/sender.dart';
import '../models/user.dart';
import '../../constant/enums.dart';
import '../../params/file_message_params.dart';
import '../../sdk/sendbird_sdk_api.dart';

part 'file_message.g.dart';

/// Represents media type message.
@JsonSerializable()
class FileMessage extends BaseMessage {
  /// Url address for media that this file message has
  final String url;

  /// Secure url address for media that this file message has
  String get secureUrl {
    final sdk = SendbirdSdk().getInternal();
    if (requireAuth && sdk.sessionManager.getEKey() != null && url != null) {
      //https://github.com/flutter/flutter/issues/25107
      //final urlString = url.replaceAll('https://', 'http://');
      return '$url?auth=${sdk.sessionManager.getEKey()}';
    }
    return null;
  }

  /// Name of this file message
  final String name;

  /// Size of this file message
  final int size;

  /// Type of this file message
  final String type;

  /// Thumbnails list of this message
  final List<Thumbnail> thumbnails;

  /// True if this requires auth to access this media, otherwise false.
  final bool requireAuth;

  @JsonKey(ignore: true)
  File localFile;

  FileMessage({
    this.url,
    this.name,
    this.size,
    this.type,
    this.thumbnails,
    this.requireAuth,
    this.localFile,
    String requestId,
    int messageId,
    String message,
    MessageSendingStatus sendingStatus,
    Sender sender,
    String channelUrl,
    ChannelType channelType,
    List<User> mentionedUsers,
    MentionType mentionType,
    List<String> requestedMentionUserIds,
    int createdAt,
    int updatedAt,
    int parentMessageId,
    String parentMessageText,
    ThreadInfo threadInfo,
    List<MessageMetaArray> metaArrays,
    String customType,
    int messageSurvivalSeconds,
    bool forceUpdateLastMessage,
    bool isSilent,
    int errorCode,
    bool isOperatorMessage,
    String data,
    OGMetaData ogMetaData,
  }) : super(
          requestId: requestId,
          messageId: messageId,
          message: message,
          sendingStatus: sendingStatus,
          sender: sender,
          channelUrl: channelUrl,
          channelType: channelType,
          mentionedUsers: mentionedUsers,
          mentionType: mentionType,
          requestedMentionUserIds: requestedMentionUserIds,
          createdAt: createdAt,
          updatedAt: updatedAt,
          parentMessageId: parentMessageId,
          parentMessageText: parentMessageText,
          threadInfo: threadInfo,
          metaArrays: metaArrays,
          customType: customType,
          messageSurvivalSeconds: messageSurvivalSeconds,
          forceUpdateLastMessage: forceUpdateLastMessage,
          isSilent: isSilent,
          errorCode: errorCode,
          isOperatorMessage: isOperatorMessage,
          data: data,
          ogMetaData: ogMetaData,
        );

  factory FileMessage.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> file = json['file'];
    if (file != null) {
      json['url'] = file['url'];
      json['type'] = file['type'];
      json['size'] = file['size'];
      json['name'] = file['name'];
      json['data'] = file['data'];
    }
    return _$FileMessageFromJson(json);
  }

  factory FileMessage.fromParams(
      {FileMessageParams params, BaseChannel channel}) {
    final msg = FileMessage(
      requestId: Uuid().v1(),
      url: params.uploadFile.url,
      name: params.uploadFile.name,
      localFile: params.uploadFile.file,
      size: params.uploadFile.fileSize,
      channelType: channel.channelType,
      channelUrl: channel.channelUrl,
      mentionType: params.mentionType,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      requireAuth: false,
    );
    return msg;
  }

  Map<String, dynamic> toJson() => _$FileMessageToJson(this);
}

/// An object represents thumbnail
@JsonSerializable()
class Thumbnail {
  String url;
  String plainUrl;
  double height;
  double width;
  double realHeight;
  double realWidth;

  Thumbnail(
    this.url,
    this.plainUrl,
    this.height,
    this.width,
    this.realHeight,
    this.realWidth,
  );

  factory Thumbnail.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailFromJson(json);
  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
}
