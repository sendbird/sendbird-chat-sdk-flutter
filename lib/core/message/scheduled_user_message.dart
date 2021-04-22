import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/channel/group/features/thread_info.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/meta_array.dart';
import 'package:sendbird_sdk/core/models/og_meta_data.dart';
import 'package:sendbird_sdk/core/models/reaction.dart';
import 'package:sendbird_sdk/core/models/sender.dart';
import 'package:sendbird_sdk/core/models/user.dart';

part 'scheduled_user_message.g.dart';

/// Represents scheduled user message
@JsonSerializable()
class ScheduledUserMessage extends BaseMessage {
  /// Scheduled message ID
  final int scheduledId;

  /// Scheduled message date time. (format: "YYYY-MM-DD HH:mm")
  @JsonKey(name: 'scheduled_dt')
  final String scheduledDateTimeString;

  /// Scheduled message timezone. (e.g. UTC, America/Los_Angeles, etc)
  final String scheduledTimezone;

  /// Scheduled message status.
  final ScheduledUserMessageStatus status;

  /// Push notification delivery option that determines how to deliver the
  /// push notification when sending a user or a file message. The default
  /// value is `normal`
  @JsonKey(unknownEnumValue: PushNotificationDeliveryOption.normal)
  final PushNotificationDeliveryOption pushOption;

  /// Error
  //@JsonKey(name: "error")
  final SBError error;

  /// Target languages that the message will be translated into
  @JsonKey(name: 'translation_target_langs')
  final List<String> targetLanguages;

  ScheduledUserMessage({
    this.scheduledId,
    this.scheduledDateTimeString,
    this.scheduledTimezone,
    this.status,
    this.pushOption,
    this.error,
    this.targetLanguages,
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
    List<Reaction> reactions,
  }) : super(
          requestId: requestId,
          messageId: messageId,
          message: message,
          sendingStatus: sendingStatus,
          sender: sender,
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
          reactions: reactions,
        );

  factory ScheduledUserMessage.fromJson(Map<String, dynamic> json) =>
      _$ScheduledUserMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ScheduledUserMessageToJson(this);

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;
    if (!(super == (other))) return false;

    final eq = ListEquality().equals;
    return other is ScheduledUserMessage &&
        other.scheduledId == scheduledId &&
        other.scheduledDateTimeString == scheduledDateTimeString &&
        other.status == status &&
        other.pushOption == pushOption &&
        eq(other.targetLanguages, targetLanguages);
  }

  @override
  int get hashCode => hashValues(
        super.hashCode,
        scheduledId,
        scheduledDateTimeString,
        status,
        pushOption,
        targetLanguages,
      );
}
