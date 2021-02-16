import 'package:json_annotation/json_annotation.dart';

import 'base_message.dart';
import 'og_image/og_meta_data.dart';

import '../constant/enums.dart';
import '../features/reaction/reaction.dart';
import '../features/thread/thread_info.dart';
import '../models/error.dart';
import '../models/meta_array.dart';
import '../models/sender.dart';
import '../models/user.dart';

part 'scheduled_user_message.g.dart';

/// Represents scheduled user message
///
/// This class is same as [UserMessage] except for the future.
@JsonSerializable(createToJson: false)
class ScheduledUserMessage extends BaseMessage {
  /// Scheduled message ID
  final int scheduledId;

  /// Scheduled message date time. (format: "YYYY-MM-DD HH:mm")
  @JsonKey(name: "scheduled_dt")
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
  @JsonKey(name: "translation_target_langs")
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
        );

  factory ScheduledUserMessage.fromJson(Map<String, dynamic> json) =>
      _$ScheduledUserMessageFromJson(json);
}
