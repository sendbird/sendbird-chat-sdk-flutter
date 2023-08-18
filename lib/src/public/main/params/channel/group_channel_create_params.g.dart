// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_channel_create_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupChannelCreateParams _$GroupChannelCreateParamsFromJson(
        Map<String, dynamic> json) =>
    GroupChannelCreateParams()
      ..isSuper = json['isSuper'] as bool?
      ..isBroadcast = json['isBroadcast'] as bool?
      ..isExclusive = json['isExclusive'] as bool?
      ..isPublic = json['isPublic'] as bool?
      ..isDistinct = json['isDistinct'] as bool?
      ..isEphemeral = json['isEphemeral'] as bool?
      ..isDiscoverable = json['isDiscoverable'] as bool?
      ..isStrict = json['isStrict'] as bool?
      ..accessCode = json['accessCode'] as String?
      ..channelUrl = json['channelUrl'] as String?
      ..customType = json['customType'] as String?
      ..data = json['data'] as String?
      ..name = json['name'] as String?
      ..userIds =
          (json['userIds'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..operatorUserIds = (json['operator_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList();

Map<String, dynamic> _$GroupChannelCreateParamsToJson(
        GroupChannelCreateParams instance) =>
    <String, dynamic>{
      'isSuper': instance.isSuper,
      'isBroadcast': instance.isBroadcast,
      'isExclusive': instance.isExclusive,
      'isPublic': instance.isPublic,
      'isDistinct': instance.isDistinct,
      'isEphemeral': instance.isEphemeral,
      'isDiscoverable': instance.isDiscoverable,
      'isStrict': instance.isStrict,
      'accessCode': instance.accessCode,
      'channelUrl': instance.channelUrl,
      'customType': instance.customType,
      'data': instance.data,
      'name': instance.name,
      'userIds': instance.userIds,
      'operator_ids': instance.operatorUserIds,
    };
