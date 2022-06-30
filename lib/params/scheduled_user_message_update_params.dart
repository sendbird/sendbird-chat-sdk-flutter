import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/apple_critical_alert_options.dart';

part 'scheduled_user_message_update_params.g.dart';

@JsonSerializable()
class ScheduledUserMessageUpdateParams {
  /// Specifies the content of the message.
  String? message;

  /// The time to send the message, in Unix milliseconds format.
  /// The messages are scheduled in minutes
  /// The term between current time and scheduledAt should be between 5 minutes
  /// (depending on the app attribute `minimum_interval_for_scheduling`) and 30 days
  int? scheduledAt;

  /// Specifies a custom message type which is used for message grouping
  /// Limited to 128 characters.
  String? customType;

  /// Specifies additional message information
  String? data;

  /// Determines whether to send a push notification
  /// for the message to the members of the channel
  bool? sendPush = true;

  /// Specifies the mentioning method which indicates
  /// the user scope who will get a notification for the message
  MentionType? mentionType = MentionType.users;

  /// Specifies an array of one or more IDs
  /// of the users who will get a notification for the message.
  List? mentionedUserIds;

  /// Determines whether to send a message
  /// without updating some of the channel properties
  bool? isSilent = false;

  /// Determines whether to mark the message as read for the sender
  bool? markAsRead = true;

  /// Specifies a JSON object of one or more key-values
  /// items which store additional message information
  Map? sortedMetaarray;

  /// Specifies the unique message ID created by other system
  String? dedupId;

  /// Specifies the bundle ID of the client app in
  /// order to send a push notification to iOS devices
  String? apnsBundleId;

  /// Languages which the message will be translated to.
  List<String>? translationTargetLanguages;

  /// default, suppress, force
  PushTriggerOption? pushOption;

  /// Options that support Apple critical alerts and checks whether the message is a critical alert.
  AppleCriticalAlertOptions? appleCriticalAlertOptions;

  ScheduledUserMessageUpdateParams({
    this.message,
    this.scheduledAt,
    this.customType,
    this.data,
    this.sendPush,
    this.mentionType,
    this.mentionedUserIds,
    this.isSilent,
    this.markAsRead,
    this.sortedMetaarray,
    this.dedupId,
    this.apnsBundleId,
    this.translationTargetLanguages,
    this.pushOption,
    this.appleCriticalAlertOptions,
  });

  Map<String, dynamic> toJson() {
    var json = _$ScheduledUserMessageUpdateParamsToJson(this);
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
