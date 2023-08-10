import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/models/apple_critical_alert_options.dart';
import 'package:sendbird_sdk/core/models/meta_array.dart';
import 'package:sendbird_sdk/core/models/sender.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/features/reaction/reaction.dart';
import 'package:sendbird_sdk/features/scheduled_message/scheduled_info.dart';
import 'package:sendbird_sdk/features/threading/thread_info.dart';

part 'scheduled_user_message.g.dart';

/// Represents scheduled user message
@JsonSerializable()
class ScheduledUserMessage extends BaseMessage {
  /// Scheduled message ID
  final int scheduledMessageId;

  /// The type of the message.
  final MessageType? type;

  /// The time to send the message, in Unix milliseconds format.
  /// The messages are scheduled in minutes
  /// The term between current time and scheduledAt should be between 5 minutes
  /// (depending on the app attribute `minimum_interval_for_scheduling`) and 30 days
  final int scheduledAt;

  /// Scheduled message status.
  final ScheduledUserMessageStatus scheduledStatus;

  /// Push notification delivery option that determines how to deliver the
  /// push notification when sending a user or a file message. The default
  /// value is `normal`
  @JsonKey(
    defaultValue: PushNotificationDeliveryOption.normal,
    unknownEnumValue: PushNotificationDeliveryOption.normal,
  )

  // ignore: unused_field
  final PushNotificationDeliveryOption _pushOption;

  // Determines whether to send a push notification for the message
  // to the members of the channel (applicable to group channels only).
  // (Default: true)
  final bool sendPush;

  /// Target languages that the message will be translated into
  @JsonKey(name: 'target_langs')
  // ignore: unused_field
  final List<String> _translationTargetLanguages;

  /// Determines whether to mark the message as read for the sender.
  bool? markAsRead;

  /// Sender’s ID.
  String? senderId;

  /// The unique message ID created by other system.
  String? dedupId;

  /// The bundle ID of the client app in order to send a push notification to iOS devices.
  String? apnsBundleId;

  /// Options that support Apple critical alerts and checks whether the message is a critical alert.
  AppleCriticalAlertOptions? appleCriticalAlertOptions;

  /// Additional ID which is sent from the SDK.
  // ignore: unused_field
  String? _reqId;

  /// The sent time of the scheduled message, in Unix milliseconds format. If it is not sent yet, the value is 0.
  int sentAt;

  ScheduledUserMessage({
    this.apnsBundleId,
    this.dedupId,
    this.appleCriticalAlertOptions,
    required this.scheduledMessageId,
    required this.scheduledStatus,
    required this.type,
    required this.scheduledAt,
    this.markAsRead,
    required ChannelType channelType,
    this.sendPush = true,
    PushNotificationDeliveryOption pushOption =
        PushNotificationDeliveryOption.normal,
    List<String> translationTargetLanguages = const [],
    String? reqId,
    ScheduledInfo? scheduledInfo,
    required String message,
    required this.senderId,
    required String channelUrl,
    List<User> mentionedUsers = const [],
    MentionType? mentionType,
    int createdAt = 0,
    this.sentAt = 0,
    List<MessageMetaArray>? metaArrays,
    String? customType,
    bool isSilent = false,
    String? data,
    MessageSendingStatus? sendingStatus,
    bool isPinnedMessage = false,
  })  : _translationTargetLanguages = translationTargetLanguages,
        _pushOption = pushOption,
        _reqId = reqId,
        super(
          isPinnedMessage: isPinnedMessage,
          messageId: scheduledMessageId,
          message: message,
          sendingStatus: sendingStatus,
          channelUrl: channelUrl,
          channelType: channelType,
          mentionedUsers: mentionedUsers,
          mentionType: mentionType,
          createdAt: createdAt,
          customType: customType,
          isSilent: isSilent,
          data: data,
          scheduledInfo: scheduledInfo,
          metaArrays: metaArrays,
        );

  factory ScheduledUserMessage.fromJson(Map<String, dynamic> json) {
    var sortedMetaarrayList = [];
    if (json['sorted_metaarray'].isNotEmpty) {
      sortedMetaarrayList.add(json['sorted_metaarray']);
    }
    json['sorted_metaarray'] = sortedMetaarrayList;

    return _$ScheduledUserMessageFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$ScheduledUserMessageToJson(this);
}
