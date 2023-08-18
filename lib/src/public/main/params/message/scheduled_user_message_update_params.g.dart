// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_user_message_update_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledUserMessageUpdateParams _$ScheduledUserMessageUpdateParamsFromJson(
        Map<String, dynamic> json) =>
    ScheduledUserMessageUpdateParams(
      message: json['message'] as String?,
      scheduledAt: json['scheduledAt'] as int?,
      customType: json['customType'] as String?,
      data: json['data'] as String?,
      mentionType:
          $enumDecodeNullable(_$MentionTypeEnumMap, json['mentionType']),
      mentionedUserIds: (json['mentionedUserIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      appleCriticalAlertOptions: json['appleCriticalAlertOptions'] == null
          ? null
          : AppleCriticalAlertOptions.fromJson(
              json['appleCriticalAlertOptions'] as Map<String, dynamic>),
      pushNotificationDeliveryOption: $enumDecodeNullable(
          _$PushTriggerOptionEnumMap, json['pushNotificationDeliveryOption']),
    );

Map<String, dynamic> _$ScheduledUserMessageUpdateParamsToJson(
        ScheduledUserMessageUpdateParams instance) =>
    <String, dynamic>{
      'message': instance.message,
      'scheduledAt': instance.scheduledAt,
      'customType': instance.customType,
      'data': instance.data,
      'mentionType': _$MentionTypeEnumMap[instance.mentionType],
      'mentionedUserIds': instance.mentionedUserIds,
      'appleCriticalAlertOptions': instance.appleCriticalAlertOptions,
      'pushNotificationDeliveryOption':
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
