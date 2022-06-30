import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';

part 'scheduled_info.g.dart';

@JsonSerializable()

/// Represents an scheduled information on BaseMessage
class ScheduledInfo {
  /// Scheduled Message Unique ID
  final int scheduledMessageId;

  /// Scheduled Message sending status
  /// [pending, in_queue, sent, failed, canceled, removed]
  final ScheduledStatus scheduledStatus;

  /// The time to send the message, in Unix milliseconds format.
  /// The messages are scheduled in minutes
  /// The term between current time and scheduledAt should be between 5 minutes
  /// (depending on the app attribute `minimum_interval_for_scheduling`) and 30 days
  final int scheduledAt;

  ScheduledInfo({
    required this.scheduledAt,
    required this.scheduledMessageId,
    required this.scheduledStatus,
  });

  factory ScheduledInfo.fromJson(Map<String, dynamic> json) =>
      _$ScheduledInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduledInfoToJson(this);
}
