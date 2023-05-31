// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/public/main/define/enums.dart';
import 'package:sendbird_chat/src/public/main/model/message/apple_critical_alert_options.dart';
import 'package:sendbird_chat/src/public/main/model/message/message_meta_array.dart';

/// Represents a scheduled user message params.
class ScheduledUserMessageCreateParams {
  /// The message text of the message.
  final String message;

  /// The schedule time to send the message, in Unix milliseconds format.
  /// The messages are scheduled in minutes, and values less than minutes are discarded.
  /// The term between current time and scheduledAt should be between 5 minutes (depending on the app attribute `minimum_interval_for_scheduling`) and 30 days
  final int scheduledAt;

  /// The custom type of the message.
  String? customType;

  /// The data of the message.
  String? data;

  /// The mention type of the message. Defaults to [MentionType.users].
  final MentionType mentionType;

  /// The mentioned user ids of the message. Defaults to null.
  List<String>? mentionedUserIds;

  /// Meta arrays of the message. Defaults to null.
  List<MessageMetaArray>? metaArrays;

  /// The apple critical alert options of the message. Defaults to null.
  AppleCriticalAlertOptions? appleCriticalAlertOptions;

  /// The push notification delivery option of the message. Defaults to null.
  final PushNotificationDeliveryOption pushNotificationDeliveryOption;

  /// The translation target languages. Defaults to null.
  List<String>? translationTargetLanguages;

  ScheduledUserMessageCreateParams({
    required this.message,
    required this.scheduledAt,
    this.customType,
    this.data,
    this.mentionType = MentionType.users,
    this.mentionedUserIds,
    this.metaArrays,
    this.appleCriticalAlertOptions,
    this.pushNotificationDeliveryOption = PushNotificationDeliveryOption.normal,
    this.translationTargetLanguages,
  });

  Map<String, dynamic> toJson() {
    final ret = <String, dynamic>{
      'message': message,
      'scheduled_at': scheduledAt,
      'custom_type': customType,
      'data': data,
      'mention_type': mentionType.toString().split('.').last,
      'mentionedUserIds': mentionedUserIds,
      'sorted_metaarray': metaArrays,
      'name': appleCriticalAlertOptions?.name,
      'volume': appleCriticalAlertOptions?.volume,
      'push_option': pushNotificationDeliveryOption.toString().split('.').last,
      'target_langs': translationTargetLanguages,
    };
    ret.removeWhere((key, value) => value == null);
    return ret;
  }
}
