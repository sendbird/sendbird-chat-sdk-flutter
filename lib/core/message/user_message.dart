import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/channel/group/features/thread_info.dart';
import 'package:sendbird_sdk/core/models/meta_array.dart';
import 'package:sendbird_sdk/core/models/og_meta_data.dart';
import 'package:sendbird_sdk/core/models/reaction.dart';
import 'package:sendbird_sdk/core/models/sender.dart';
import 'package:sendbird_sdk/core/models/user.dart';

import 'base_message.dart';

part 'user_message.g.dart';

/// Represents a basic text message
@JsonSerializable()
class UserMessage extends BaseMessage {
  /// translation map for this user message. Key is language code and value is
  /// translated text
  @JsonKey(defaultValue: {})
  final Map<String, String> translations;

  UserMessage({
    required this.translations,
    required int messageId,
    required String message,
    required String channelUrl,
    required ChannelType channelType,
    Sender? sender,
    MessageSendingStatus? sendingStatus,
    String? requestId,
    List<User> mentionedUsers = const [],
    MentionType? mentionType,
    List<String>? requestedMentionUserIds,
    int createdAt = 0,
    int updatedAt = 0,
    int? parentMessageId,
    String? parentMessageText,
    ThreadInfo? threadInfo,
    List<MessageMetaArray>? metaArrays,
    String? customType,
    int? messageSurvivalSeconds,
    bool forceUpdateLastMessage = false,
    bool isSilent = false,
    int? errorCode,
    bool isOperatorMessage = false,
    String? data,
    OGMetaData? ogMetaData,
    List<Reaction>? reactions,
  }) : super(
          requestId: requestId,
          messageId: messageId,
          message: message,
          sendingStatus: sendingStatus,
          sender: sender,
          channelType: channelType,
          channelUrl: channelUrl,
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
          reactions: reactions,
        );

  factory UserMessage.fromJson(Map<String, dynamic> json) =>
      _$UserMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserMessageToJson(this);

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;
    if (!(super == (other))) return false;

    final eq = MapEquality().equals;
    return other is UserMessage && eq(translations, other.translations);
  }

  @override
  int get hashCode => hashValues(super.hashCode, translations);
}
