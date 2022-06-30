// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_file_message_update_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledFileMessageUpdateParams _$ScheduledFileMessageUpdateParamsFromJson(
        Map<String, dynamic> json) =>
    ScheduledFileMessageUpdateParams(
      url: json['url'] as String?,
      fileName: json['file_name'] as String?,
      fileSize: json['file_size'] as int?,
      fileType: json['file_type'] as String?,
      thumbnails: json['thumbnails'] as List<dynamic>?,
      scheduledAt: json['scheduled_at'] as int?,
      customType: json['custom_type'] as String?,
      data: json['data'] as String?,
      requireAuth: json['require_auth'] as bool?,
      sendPush: json['send_push'] as bool?,
      mentionType: json['mention_type'] as String?,
      mentionedUserIds: json['mentioned_user_ids'] as List<dynamic>?,
      isSilent: json['is_silent'] as bool?,
      markAsRead: json['mark_as_read'] as bool?,
      sortedMetaarray: json['sorted_metaarray'] as Map<String, dynamic>?,
      dedupId: json['dedup_id'] as String?,
      apnsBundleId: json['apns_bundle_id'] as String?,
      pushOption:
          $enumDecodeNullable(_$PushTriggerOptionEnumMap, json['push_option']),
      appleCriticalAlertOptions: json['apple_critical_alert_options'] == null
          ? null
          : AppleCriticalAlertOptions.fromJson(
              json['apple_critical_alert_options'] as Map<String, dynamic>),
      reqId: json['req_id'] as String?,
    );

Map<String, dynamic> _$ScheduledFileMessageUpdateParamsToJson(
        ScheduledFileMessageUpdateParams instance) =>
    <String, dynamic>{
      'url': instance.url,
      'file_name': instance.fileName,
      'file_size': instance.fileSize,
      'file_type': instance.fileType,
      'thumbnails': instance.thumbnails,
      'scheduled_at': instance.scheduledAt,
      'custom_type': instance.customType,
      'data': instance.data,
      'require_auth': instance.requireAuth,
      'send_push': instance.sendPush,
      'mention_type': instance.mentionType,
      'mentioned_user_ids': instance.mentionedUserIds,
      'is_silent': instance.isSilent,
      'mark_as_read': instance.markAsRead,
      'sorted_metaarray': instance.sortedMetaarray,
      'dedup_id': instance.dedupId,
      'apns_bundle_id': instance.apnsBundleId,
      'push_option': _$PushTriggerOptionEnumMap[instance.pushOption],
      'apple_critical_alert_options':
          instance.appleCriticalAlertOptions?.toJson(),
      'req_id': instance.reqId,
    };

const _$PushTriggerOptionEnumMap = {
  PushTriggerOption.all: 'all',
  PushTriggerOption.off: 'off',
  PushTriggerOption.mentionOnly: 'mention_only',
};
