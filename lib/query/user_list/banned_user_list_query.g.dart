// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banned_user_list_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannedUserListQuery _$BannedUserListQueryFromJson(Map<String, dynamic> json) =>
    BannedUserListQuery(
      channelType: $enumDecode(_$ChannelTypeEnumMap, json['channel_type']),
      channelUrl: json['channel_url'] as String,
    )
      ..loading = json['loading'] as bool
      ..hasNext = json['has_next'] as bool
      ..token = json['token'] as String?
      ..limit = json['limit'] as int;

Map<String, dynamic> _$BannedUserListQueryToJson(
        BannedUserListQuery instance) =>
    <String, dynamic>{
      'loading': instance.loading,
      'has_next': instance.hasNext,
      'token': instance.token,
      'limit': instance.limit,
      'channel_type': _$ChannelTypeEnumMap[instance.channelType],
      'channel_url': instance.channelUrl,
    };

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
};
