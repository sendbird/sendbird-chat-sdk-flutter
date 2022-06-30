import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/apple_critical_alert_options.dart';
import 'package:sendbird_sdk/core/models/meta_array.dart';

/// An object consists a set of parameters to create scheduled user message.
class ScheduledUserMessageParams {
  /// Message Information
  final String message;

  /// The time to send the message, in Unix milliseconds format.
  /// Since messages are scheduled in minutes,
  /// values less than seconds are discarded.
  /// The term between current time and scheduled_at
  /// should be between 5 minutes and 30 days.
  final int scheduledAt;

  /// Determines whether to send a push notification for the message
  /// to the members of the channel (applicable to group channels only).
  /// (Default: true)
  final bool sendPush;

  /// Determines whether to send a message without updating some
  /// of the channel properties. If set to true, the
  /// channel's last_message is updated only for the sender while its
  /// unread_message_count remains unchanged for all channel members.
  /// Also, a push notification isn't sent to the users who receive the message.
  /// If the message is sent to a hidden channel, the channel still remains hidden.
  /// (Default: false)
  final bool isSilent;

  /// Determines whether to mark the message as read for the sender.
  /// If set to false, then the sender's unread_count and read_receipt
  /// remain unchanged after the message is sent. (Default: true)
  final bool markAsRead;

  /// Specifies the unique message ID created by other system.
  /// In general, this property is used to prevent the same message data
  /// from getting inserted when migrating the messages of the other system
  /// to Sendbird server. If specified, the server performs a
  /// duplicate check using the property value.
  String? dedupId;

  /// Specifies the bundle ID of the client app in order to send
  /// a push notification to iOS devices.
  String? apnsBundleId;

  /// Specifies options that support Apple critical alerts
  /// and checks whether the message is a critical alert.
  AppleCriticalAlertOptions? appleCriticalAlertOptions;

  /// Languages which the message will be translated to.
  List<String>? translationTargetLanguages;

  /// Specifies an array of one or more IDs of the users
  /// who will get a notification for the message.
  List<String>? mentionedUserIds;

  /// Specifies additional message information such as custom font size,
  /// font type or JSON formatted string.
  String? data;

  /// Specifies a custom message type which is used for message grouping.
  /// The length is limited to 128 characters.
  String? customType;

  /// 3 types: default, suppress, force
  final PushNotificationDeliveryOption pushOption;

  /// Specifies the mentioning method which indicates the user scope who will get a notification for the message.
  /// If set to channel, all users in the channel will get notified.
  /// (Default: users)
  final MentionType mentionType;

  /// Specifies a JSON object of one or more key-values items
  /// which store additional message information.
  List<MessageMetaArray>? metaArrays;

  /// Additional ID which is sent from the SDK. SDK uses this ID to identify each message.
  String? reqId;

  /// Initializes this params instance with a text message and
  /// the date to send the message.
  ScheduledUserMessageParams({
    required this.scheduledAt,
    required this.message,
    this.sendPush = true,
    this.isSilent = false,
    this.markAsRead = true,
    this.dedupId,
    this.apnsBundleId,
    this.appleCriticalAlertOptions,
    this.translationTargetLanguages,
    this.data,
    this.customType,
    this.pushOption = PushNotificationDeliveryOption.normal,
    this.mentionType = MentionType.users,
    this.mentionedUserIds,
    this.metaArrays,
    this.reqId,
  });

  Map<String, dynamic> toJson() {
    final ret = <String, dynamic>{
      'message': message,
      'scheduled_at': scheduledAt,
      'send_push': sendPush,
      'is_silent': isSilent,
      'mark_as_read': markAsRead,
      'dedup_id': dedupId,
      'apns_bundle_id': apnsBundleId,
      'sound': appleCriticalAlertOptions?.sound,
      'volume': appleCriticalAlertOptions?.volume,
      'target_langs': translationTargetLanguages,
      'req_id': reqId,
      'data': data,
      'custom_type': customType,
      'push_option': pushOption.toString().split('.').last,
      'mention_type': mentionType.toString().split('.').last,
      'mentionedUserIds': mentionedUserIds,
      'meta_arrays': metaArrays,
    };
    ret.removeWhere((key, value) => value == null);
    return ret;
  }
}
