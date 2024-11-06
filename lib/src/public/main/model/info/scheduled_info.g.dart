// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledInfo _$ScheduledInfoFromJson(Map<String, dynamic> json) =>
    ScheduledInfo(
      scheduledMessageId: (json['scheduled_message_id'] as num).toInt(),
      scheduledAt: (json['scheduled_at'] as num).toInt(),
      scheduledStatus:
          $enumDecode(_$ScheduledStatusEnumMap, json['scheduled_status']),
    );

const _$ScheduledStatusEnumMap = {
  ScheduledStatus.pending: 'pending',
  ScheduledStatus.inQueue: 'in_queue',
  ScheduledStatus.sent: 'sent',
  ScheduledStatus.failed: 'failed',
  ScheduledStatus.canceled: 'canceled',
  ScheduledStatus.removed: 'removed',
};
