// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_channel_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenChannelParams _$OpenChannelParamsFromJson(Map<String, dynamic> json) =>
    OpenChannelParams()
      ..channelUrl = json['channel_url'] as String?
      ..customType = json['custom_type'] as String?
      ..data = json['data'] as String?
      ..name = json['name'] as String?
      ..operatorUserIds = (json['operator_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList();

Map<String, dynamic> _$OpenChannelParamsToJson(OpenChannelParams instance) =>
    <String, dynamic>{
      'channel_url': instance.channelUrl,
      'custom_type': instance.customType,
      'data': instance.data,
      'name': instance.name,
      'operator_ids': instance.operatorUserIds,
    };
