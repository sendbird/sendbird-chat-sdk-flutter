// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muted_user_list_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MutedUserListQuery _$MutedUserListQueryFromJson(Map<String, dynamic> json) =>
    MutedUserListQuery(
      channelType: $enumDecode(_$ChannelTypeEnumMap, json['channel_type']),
      channelUrl: json['channel_url'] as String,
    )
      ..loading = json['loading'] as bool
      ..hasNext = json['has_next'] as bool
      ..token = json['token'] as String?
      ..limit = json['limit'] as int;

Map<String, dynamic> _$MutedUserListQueryToJson(MutedUserListQuery instance) =>
    <String, dynamic>{
      'loading': instance.loading,
      'has_next': instance.hasNext,
      'token': instance.token,
      'limit': instance.limit,
      'channel_type': _$ChannelTypeEnumMap[instance.channelType]!,
      'channel_url': instance.channelUrl,
    };

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
};
