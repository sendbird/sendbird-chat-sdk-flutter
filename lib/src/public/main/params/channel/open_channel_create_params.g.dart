// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_channel_create_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenChannelCreateParams _$OpenChannelCreateParamsFromJson(
        Map<String, dynamic> json) =>
    OpenChannelCreateParams()
      ..channelUrl = json['channel_url'] as String?
      ..name = json['name'] as String?
      ..customType = json['custom_type'] as String?
      ..data = json['data'] as String?
      ..operatorUserIds = (json['operator_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList();

Map<String, dynamic> _$OpenChannelCreateParamsToJson(
        OpenChannelCreateParams instance) =>
    <String, dynamic>{
      'channel_url': instance.channelUrl,
      'name': instance.name,
      'custom_type': instance.customType,
      'data': instance.data,
      'operator_ids': instance.operatorUserIds,
    };
