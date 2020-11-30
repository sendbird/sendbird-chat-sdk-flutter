import 'package:json_annotation/json_annotation.dart';

import '../constant/enums.dart';
import '../features/thread/thread_info.dart';
import '../models/meta_array.dart';
import '../models/sender.dart';
import '../message/base_message.dart';
import '../models/user.dart';
import '../features/reaction/reaction.dart';
import '../sdk/sendbird_sdk_api.dart';

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

  FileMessage({
    this.url,
    this.name,
    this.size,
    this.type,
    this.thumbnails,
    this.requireAuth,
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
        );

  factory FileMessage.fromJson(Map<String, dynamic> json) =>
      _$FileMessageFromJson(json);
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
