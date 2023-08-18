// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_channel_update_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupChannelUpdateParams _$GroupChannelUpdateParamsFromJson(
        Map<String, dynamic> json) =>
    GroupChannelUpdateParams()
      ..isPublic = json['isPublic'] as bool?
      ..isDistinct = json['isDistinct'] as bool?
      ..isDiscoverable = json['isDiscoverable'] as bool?
      ..accessCode = json['accessCode'] as String?
      ..customType = json['customType'] as String?
      ..data = json['data'] as String?
      ..name = json['name'] as String?
      ..operatorUserIds = (json['operator_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList();

Map<String, dynamic> _$GroupChannelUpdateParamsToJson(
        GroupChannelUpdateParams instance) =>
    <String, dynamic>{
      'isPublic': instance.isPublic,
      'isDistinct': instance.isDistinct,
      'isDiscoverable': instance.isDiscoverable,
      'accessCode': instance.accessCode,
      'customType': instance.customType,
      'data': instance.data,
      'name': instance.name,
      'operator_ids': instance.operatorUserIds,
    };
