// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_channel_update_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenChannelUpdateParams _$OpenChannelUpdateParamsFromJson(
        Map<String, dynamic> json) =>
    OpenChannelUpdateParams()
      ..name = json['name'] as String?
      ..customType = json['customType'] as String?
      ..data = json['data'] as String?
      ..operatorUserIds = (json['operator_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList();

Map<String, dynamic> _$OpenChannelUpdateParamsToJson(
        OpenChannelUpdateParams instance) =>
    <String, dynamic>{
      'name': instance.name,
      'customType': instance.customType,
      'data': instance.data,
      'operator_ids': instance.operatorUserIds,
    };
