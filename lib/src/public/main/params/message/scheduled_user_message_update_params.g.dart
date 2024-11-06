// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_user_message_update_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledUserMessageUpdateParams _$ScheduledUserMessageUpdateParamsFromJson(
        Map<String, dynamic> json) =>
    ScheduledUserMessageUpdateParams(
      message: json['message'] as String?,
      scheduledAt: (json['scheduled_at'] as num?)?.toInt(),
      customType: json['custom_type'] as String?,
      data: json['data'] as String?,
      mentionType:
          $enumDecodeNullable(_$MentionTypeEnumMap, json['mention_type']),
      mentionedUserIds: (json['mentioned_user_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      appleCriticalAlertOptions: json['apple_critical_alert_options'] == null
          ? null
          : AppleCriticalAlertOptions.fromJson(
              json['apple_critical_alert_options'] as Map<String, dynamic>),
      pushNotificationDeliveryOption: $enumDecodeNullable(
          _$PushTriggerOptionEnumMap,
          json['push_notification_delivery_option']),
    );

Map<String, dynamic> _$ScheduledUserMessageUpdateParamsToJson(
        ScheduledUserMessageUpdateParams instance) =>
    <String, dynamic>{
      'message': instance.message,
      'scheduled_at': instance.scheduledAt,
      'custom_type': instance.customType,
      'data': instance.data,
      'mention_type': _$MentionTypeEnumMap[instance.mentionType],
      'mentioned_user_ids': instance.mentionedUserIds,
      'apple_critical_alert_options':
          instance.appleCriticalAlertOptions?.toJson(),
      'push_notification_delivery_option':
          _$PushTriggerOptionEnumMap[instance.pushNotificationDeliveryOption],
    };

const _$MentionTypeEnumMap = {
  MentionType.users: 'users',
  MentionType.channel: 'channel',
};

const _$PushTriggerOptionEnumMap = {
  PushTriggerOption.all: 'all',
  PushTriggerOption.off: 'off',
  PushTriggerOption.mentionOnly: 'mention_only',
};
