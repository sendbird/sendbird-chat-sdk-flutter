// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_file_message_update_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledFileMessageUpdateParams _$ScheduledFileMessageUpdateParamsFromJson(
        Map<String, dynamic> json) =>
    ScheduledFileMessageUpdateParams(
      url: json['url'] as String?,
      fileName: json['fileName'] as String?,
      fileSize: json['fileSize'] as int?,
      mimeType: json['mimeType'] as String?,
      scheduledAt: json['scheduledAt'] as int?,
      customType: json['customType'] as String?,
      data: json['data'] as String?,
      mentionType: json['mentionType'] as String?,
      mentionedUserIds: json['mentionedUserIds'] as List<dynamic>?,
      appleCriticalAlertOptions: json['appleCriticalAlertOptions'] == null
          ? null
          : AppleCriticalAlertOptions.fromJson(
              json['appleCriticalAlertOptions'] as Map<String, dynamic>),
      pushNotificationDeliveryOption: $enumDecodeNullable(
              _$PushNotificationDeliveryOptionEnumMap,
              json['pushNotificationDeliveryOption']) ??
          PushNotificationDeliveryOption.normal,
    )..metaArrays = (json['metaArrays'] as List<dynamic>?)
        ?.map((e) => MessageMetaArray.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$ScheduledFileMessageUpdateParamsToJson(
        ScheduledFileMessageUpdateParams instance) =>
    <String, dynamic>{
      'scheduledAt': instance.scheduledAt,
      'url': instance.url,
      'fileName': instance.fileName,
      'fileSize': instance.fileSize,
      'mimeType': instance.mimeType,
      'customType': instance.customType,
      'data': instance.data,
      'mentionType': instance.mentionType,
      'mentionedUserIds': instance.mentionedUserIds,
      'metaArrays': instance.metaArrays,
      'appleCriticalAlertOptions': instance.appleCriticalAlertOptions,
      'pushNotificationDeliveryOption': _$PushNotificationDeliveryOptionEnumMap[
          instance.pushNotificationDeliveryOption]!,
    };

const _$PushNotificationDeliveryOptionEnumMap = {
  PushNotificationDeliveryOption.normal: 'normal',
  PushNotificationDeliveryOption.suppress: 'suppress',
  PushNotificationDeliveryOption.force: 'force',
};
