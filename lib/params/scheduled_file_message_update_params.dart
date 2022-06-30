import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/apple_critical_alert_options.dart';

part 'scheduled_file_message_update_params.g.dart';

@JsonSerializable()
class ScheduledFileMessageUpdateParams {
  /// Specifies the URL of the file which is hosted
  /// on the server of your own or other external third party companies.
  String? url;

  /// Name of file which is specified by the url property.
  String? fileName;

  /// Size of file which is specified by the url property.
  int? fileSize;

  /// If the file property is used for file upload,
  /// this property is automatically specified by Sendbird server.
  String? fileType;

  /// Specifies an array of one or more URLs of the external
  /// thumbnail images which are generated from the image
  /// which is specified by the url property.
  List? thumbnails;

  /// The time to send the message, in Unix milliseconds format.
  /// The messages are scheduled in minutes
  /// The term between current time and scheduledAt should be between 5 minutes
  /// (depending on the app attribute `minimum_interval_for_scheduling`) and 30 days
  int? scheduledAt;

  /// Specifies a custom message type which is used for message grouping.
  /// The length is limited to 128 characters.
  String? customType;

  /// Specifies additional message information such as custom font size,
  /// font type or JSON formatted string.
  String? data;

  /// Determines whether or not the file in the message and generated
  /// thumbnail images can be only accessed by the users within the
  /// application who are participating in the same open channel,
  /// or who are the members of the same group channel.
  bool? requireAuth = true;

  /// Determines whether to send a push notification for
  /// the message to the members of the channel
  bool? sendPush = true;

  /// Specifies the mentioning method which indicates the user
  /// scope who will get a notification for the message.
  String? mentionType;

  /// Specifies an array of one or more IDs of
  /// the users who will get a notification for the message.
  List? mentionedUserIds;

  /// Determines whether to send a message
  /// without updating some of the channel properties.
  bool? isSilent = false;

  /// Determines whether to mark the message as read for the sender.
  bool? markAsRead = true;

  /// Specifies a JSON object of one or more key-values
  /// items which store additional message information.
  Map? sortedMetaarray;

  /// Specifies the unique message ID created by other system.
  String? dedupId;

  /// Specifies the bundle ID of the client app
  /// in order to send a push notification to iOS devices.
  String? apnsBundleId;

  /// default, suppress, force
  PushTriggerOption? pushOption;

  /// Options that support Apple critical alerts and checks whether the message is a critical alert.
  AppleCriticalAlertOptions? appleCriticalAlertOptions;

  /// Additional ID which is sent from the SDK.
  String? reqId;

  ScheduledFileMessageUpdateParams({
    this.url,
    this.fileName,
    this.fileSize,
    this.fileType,
    this.thumbnails,
    this.scheduledAt,
    this.customType,
    this.data,
    this.requireAuth,
    this.sendPush,
    this.mentionType,
    this.mentionedUserIds,
    this.isSilent,
    this.markAsRead,
    this.sortedMetaarray,
    this.dedupId,
    this.apnsBundleId,
    this.pushOption,
    this.appleCriticalAlertOptions,
    this.reqId,
  });

  Map<String, dynamic> toJson() {
    var json = _$ScheduledFileMessageUpdateParamsToJson(this);
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
