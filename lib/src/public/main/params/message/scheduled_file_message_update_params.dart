// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/apple_critical_alert_options.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/message_meta_array.dart';

part 'scheduled_file_message_update_params.g.dart';

/// ScheduledFileMessageUpdateParams
@JsonSerializable()
class ScheduledFileMessageUpdateParams {
  /// The schedule time to send the message, in Unix milliseconds format.
  /// The messages are scheduled in minutes, and values less than minutes are discarded.
  /// The term between current time and scheduledAt should be between 5 minutes (depending on the app attribute `minimum_interval_for_scheduling`) and 30 days
  int? scheduledAt;

  /// The file url of the message.
  String? url;

  /// The file name of the file of the message. Defaults to null.
  String? fileName;

  /// The file size of the file of the message. Defaults to null.
  int? fileSize;

  /// The thumbnail sizes the file's thumbnail of the message. Defaults to null.
  String? mimeType;

  /// The custom type of the message.
  String? customType;

  /// The data of the message.
  String? data;

  /// The mention type of the message. Defaults to [MentionType.users].
  String? mentionType;

  /// The mentioned user ids of the message. Defaults to null.
  List? mentionedUserIds;

  /// Meta arrays of the message. Defaults to null.
  List<MessageMetaArray>? metaArrays;

  /// The apple critical alert options of the message. Defaults to null.
  AppleCriticalAlertOptions? appleCriticalAlertOptions;

  /// The push notification delivery option of the message. Defaults to null.
  final PushNotificationDeliveryOption pushNotificationDeliveryOption;

  ScheduledFileMessageUpdateParams({
    this.url,
    this.fileName,
    this.fileSize,
    this.mimeType,
    this.scheduledAt,
    this.customType,
    this.data,
    this.mentionType,
    this.mentionedUserIds,
    this.appleCriticalAlertOptions,
    this.pushNotificationDeliveryOption = PushNotificationDeliveryOption.normal,
  });

  static ScheduledFileMessageUpdateParams fromJson(Map<String, dynamic> json) {
    return _$ScheduledFileMessageUpdateParamsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    var json = _$ScheduledFileMessageUpdateParamsToJson(this);
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
