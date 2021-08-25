import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/meta_array.dart';
import 'package:sendbird_sdk/core/models/sender.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/features/og_meta_data/og_meta_data.dart';
import 'package:sendbird_sdk/features/reaction/reaction.dart';
import 'package:sendbird_sdk/features/threading/thread_info.dart';

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
  @JsonKey(
    defaultValue: PushNotificationDeliveryOption.normal,
    unknownEnumValue: PushNotificationDeliveryOption.normal,
  )
  final PushNotificationDeliveryOption pushOption;

  /// Error
  //@JsonKey(name: "error")
  final SBError? error;

  /// Target languages that the message will be translated into
  @JsonKey(name: 'translation_target_langs')
  final List<String> targetLanguages;

  ScheduledUserMessage({
    required this.scheduledId,
    required this.scheduledDateTimeString,
    required this.scheduledTimezone,
    required this.status,
    this.pushOption = PushNotificationDeliveryOption.normal,
    this.error,
    this.targetLanguages = const [],
    String? requestId,
    required int messageId,
    required String message,
    MessageSendingStatus? sendingStatus,
    required Sender sender,
    required String channelUrl,
    required ChannelType channelType,
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
