// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_user_message_update_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledUserMessageUpdateParams _$ScheduledUserMessageUpdateParamsFromJson(
        Map<String, dynamic> json) =>
    ScheduledUserMessageUpdateParams(
      message: json['message'] as String?,
      scheduledAt: json['scheduled_at'] as int?,
      customType: json['custom_type'] as String?,
      data: json['data'] as String?,
      sendPush: json['send_push'] as bool?,
      mentionType:
          $enumDecodeNullable(_$MentionTypeEnumMap, json['mention_type']),
      mentionedUserIds: json['mentioned_user_ids'] as List<dynamic>?,
      isSilent: json['is_silent'] as bool?,
      markAsRead: json['mark_as_read'] as bool?,
      sortedMetaarray: json['sorted_metaarray'] as Map<String, dynamic>?,
      dedupId: json['dedup_id'] as String?,
      apnsBundleId: json['apns_bundle_id'] as String?,
      translationTargetLanguages:
          (json['translation_target_languages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      pushOption:
          $enumDecodeNullable(_$PushTriggerOptionEnumMap, json['push_option']),
      appleCriticalAlertOptions: json['apple_critical_alert_options'] == null
          ? null
          : AppleCriticalAlertOptions.fromJson(
              json['apple_critical_alert_options'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScheduledUserMessageUpdateParamsToJson(
        ScheduledUserMessageUpdateParams instance) =>
    <String, dynamic>{
      'message': instance.message,
      'scheduled_at': instance.scheduledAt,
      'custom_type': instance.customType,
      'data': instance.data,
      'send_push': instance.sendPush,
      'mention_type': _$MentionTypeEnumMap[instance.mentionType],
      'mentioned_user_ids': instance.mentionedUserIds,
      'is_silent': instance.isSilent,
      'mark_as_read': instance.markAsRead,
      'sorted_metaarray': instance.sortedMetaarray,
      'dedup_id': instance.dedupId,
      'apns_bundle_id': instance.apnsBundleId,
      'translation_target_languages': instance.translationTargetLanguages,
      'push_option': _$PushTriggerOptionEnumMap[instance.pushOption],
      'apple_critical_alert_options':
          instance.appleCriticalAlertOptions?.toJson(),
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
