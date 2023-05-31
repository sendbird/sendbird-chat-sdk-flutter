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
      mimeType: json['mime_type'] as String?,
      scheduledAt: json['scheduled_at'] as int?,
      customType: json['custom_type'] as String?,
      data: json['data'] as String?,
      mentionType: json['mention_type'] as String?,
      mentionedUserIds: json['mentioned_user_ids'] as List<dynamic>?,
      appleCriticalAlertOptions: json['apple_critical_alert_options'] == null
          ? null
          : AppleCriticalAlertOptions.fromJson(
              json['apple_critical_alert_options'] as Map<String, dynamic>),
      pushNotificationDeliveryOption: $enumDecodeNullable(
              _$PushNotificationDeliveryOptionEnumMap,
              json['push_notification_delivery_option']) ??
          PushNotificationDeliveryOption.normal,
    )..metaArrays = (json['meta_arrays'] as List<dynamic>?)
        ?.map((e) => MessageMetaArray.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$ScheduledFileMessageUpdateParamsToJson(
        ScheduledFileMessageUpdateParams instance) =>
    <String, dynamic>{
      'scheduled_at': instance.scheduledAt,
      'url': instance.url,
      'file_name': instance.fileName,
      'file_size': instance.fileSize,
      'mime_type': instance.mimeType,
      'custom_type': instance.customType,
      'data': instance.data,
      'mention_type': instance.mentionType,
      'mentioned_user_ids': instance.mentionedUserIds,
      'meta_arrays': instance.metaArrays?.map((e) => e.toJson()).toList(),
      'apple_critical_alert_options':
          instance.appleCriticalAlertOptions?.toJson(),
      'push_notification_delivery_option':
          _$PushNotificationDeliveryOptionEnumMap[
              instance.pushNotificationDeliveryOption]!,
    };

const _$PushNotificationDeliveryOptionEnumMap = {
  PushNotificationDeliveryOption.normal: 'normal',
  PushNotificationDeliveryOption.suppress: 'suppress',
  PushNotificationDeliveryOption.force: 'force',
};
