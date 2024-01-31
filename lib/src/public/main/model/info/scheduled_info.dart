// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

part 'scheduled_info.g.dart';

/// Class holding an information about the scheduled messages.
@JsonSerializable(createToJson: false)
class ScheduledInfo {
  /// The ID of the scheduled message.
  int scheduledMessageId;

  /// The scheduled time of this message.
  int scheduledAt;

  /// The scheduled message sending status.
  ScheduledStatus scheduledStatus;

  ScheduledInfo({
    required this.scheduledMessageId,
    required this.scheduledAt,
    required this.scheduledStatus,
  });

  factory ScheduledInfo.fromJson(Map<String, dynamic> json) =>
      _$ScheduledInfoFromJson(json);
}
