// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/apple_critical_alert_options.dart';

part 'scheduled_user_message_update_params.g.dart';

/// Represents a scheduled user message update params.
@JsonSerializable()
class ScheduledUserMessageUpdateParams {
  /// he message text of the message.
  String? message;

  /// The schedule time to send the message, in Unix milliseconds format.
  /// The messages are scheduled in minutes, and values less than minutes are discarded.
  /// The term between current time and scheduledAt should be between 5 minutes (depending on the app attribute `minimum_interval_for_scheduling`) and 30 days
  int? scheduledAt;

  /// The custom type of the message.
  String? customType;

  /// The data of the message.
  String? data;

  /// The mention type of the message. Defaults to [MentionType.users].
  MentionType? mentionType = MentionType.users;

  /// The mentioned user ids of the message. Defaults to null.
  List<String>? mentionedUserIds;

  /// The apple critical alert options of the message. Defaults to null.
  AppleCriticalAlertOptions? appleCriticalAlertOptions;

  /// The push notification delivery option of the message. Defaults to null.
  PushTriggerOption? pushNotificationDeliveryOption;

  ScheduledUserMessageUpdateParams({
    this.message,
    this.scheduledAt,
    this.customType,
    this.data,
    this.mentionType,
    this.mentionedUserIds,
    this.appleCriticalAlertOptions,
    this.pushNotificationDeliveryOption,
  });

  static ScheduledUserMessageUpdateParams fromJson(Map<String, dynamic> json) {
    return _$ScheduledUserMessageUpdateParamsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    var json = _$ScheduledUserMessageUpdateParamsToJson(this);
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
