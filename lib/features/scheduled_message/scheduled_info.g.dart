// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledInfo _$ScheduledInfoFromJson(Map<String, dynamic> json) =>
    ScheduledInfo(
      scheduledAt: json['scheduled_at'] as int,
      scheduledMessageId: json['scheduled_message_id'] as int,
      scheduledStatus:
          $enumDecode(_$ScheduledStatusEnumMap, json['scheduled_status']),
    );

Map<String, dynamic> _$ScheduledInfoToJson(ScheduledInfo instance) =>
    <String, dynamic>{
      'scheduled_message_id': instance.scheduledMessageId,
      'scheduled_status': _$ScheduledStatusEnumMap[instance.scheduledStatus]!,
      'scheduled_at': instance.scheduledAt,
    };

const _$ScheduledStatusEnumMap = {
  ScheduledStatus.pending: 'pending',
  ScheduledStatus.inQueue: 'in_queue',
  ScheduledStatus.sent: 'sent',
  ScheduledStatus.failed: 'failed',
  ScheduledStatus.canceled: 'canceled',
  ScheduledStatus.removed: 'removed',
};
