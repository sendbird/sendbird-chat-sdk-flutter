// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledInfo _$ScheduledInfoFromJson(Map<String, dynamic> json) =>
    ScheduledInfo(
      scheduledMessageId: json['scheduledMessageId'] as int,
      scheduledAt: json['scheduledAt'] as int,
      scheduledStatus:
          $enumDecode(_$ScheduledStatusEnumMap, json['scheduledStatus']),
    );

const _$ScheduledStatusEnumMap = {
  ScheduledStatus.pending: 'pending',
  ScheduledStatus.inQueue: 'in_queue',
  ScheduledStatus.sent: 'sent',
  ScheduledStatus.failed: 'failed',
  ScheduledStatus.canceled: 'canceled',
  ScheduledStatus.removed: 'removed',
};
