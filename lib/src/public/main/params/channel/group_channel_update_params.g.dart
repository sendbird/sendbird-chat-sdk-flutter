// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_channel_update_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupChannelUpdateParams _$GroupChannelUpdateParamsFromJson(
        Map<String, dynamic> json) =>
    GroupChannelUpdateParams()
      ..isPublic = json['is_public'] as bool?
      ..isDistinct = json['is_distinct'] as bool?
      ..isDiscoverable = json['is_discoverable'] as bool?
      ..accessCode = json['access_code'] as String?
      ..customType = json['custom_type'] as String?
      ..data = json['data'] as String?
      ..name = json['name'] as String?
      ..operatorUserIds = (json['operator_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList();

Map<String, dynamic> _$GroupChannelUpdateParamsToJson(
        GroupChannelUpdateParams instance) =>
    <String, dynamic>{
      'is_public': instance.isPublic,
      'is_distinct': instance.isDistinct,
      'is_discoverable': instance.isDiscoverable,
      'access_code': instance.accessCode,
      'custom_type': instance.customType,
      'data': instance.data,
      'name': instance.name,
      'operator_ids': instance.operatorUserIds,
    };
