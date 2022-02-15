// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_channel_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupChannelParams _$GroupChannelParamsFromJson(Map<String, dynamic> json) {
  return GroupChannelParams()
    ..isSuper = json['is_super'] as bool?
    ..isBroadcast = json['is_broadcast'] as bool?
    ..isPublic = json['is_public'] as bool?
    ..isDistinct = json['is_distinct'] as bool?
    ..isEphemeral = json['is_ephemeral'] as bool?
    ..isDiscoverable = json['is_discoverable'] as bool?
    ..isStrict = json['is_strict'] as bool?
    ..accessCode = json['access_code'] as String?
    ..channelUrl = json['channel_url'] as String?
    ..customType = json['custom_type'] as String?
    ..data = json['data'] as String?
    ..name = json['name'] as String?
    ..userIds =
        (json['user_ids'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..operatorUserIds = (json['operator_ids'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList();
}

Map<String, dynamic> _$GroupChannelParamsToJson(GroupChannelParams instance) =>
    <String, dynamic>{
      'is_super': instance.isSuper,
      'is_broadcast': instance.isBroadcast,
      'is_public': instance.isPublic,
      'is_distinct': instance.isDistinct,
      'is_ephemeral': instance.isEphemeral,
      'is_discoverable': instance.isDiscoverable,
      'is_strict': instance.isStrict,
      'access_code': instance.accessCode,
      'channel_url': instance.channelUrl,
      'custom_type': instance.customType,
      'data': instance.data,
      'name': instance.name,
      'user_ids': instance.userIds,
      'operator_ids': instance.operatorUserIds,
    };
