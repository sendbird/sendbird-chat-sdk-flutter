// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListQuery _$UserListQueryFromJson(Map<String, dynamic> json) =>
    UserListQuery(
      queryType: $enumDecode(_$UserListQueryTypeEnumMap, json['query_type']),
      channelType:
          $enumDecodeNullable(_$ChannelTypeEnumMap, json['channel_type']),
      channelUrl: json['channel_url'] as String?,
      userIds: (json['user_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    )
      ..loading = json['loading'] as bool
      ..hasNext = json['has_next'] as bool
      ..token = json['token'] as String?
      ..limit = json['limit'] as int;

Map<String, dynamic> _$UserListQueryToJson(UserListQuery instance) =>
    <String, dynamic>{
      'loading': instance.loading,
      'has_next': instance.hasNext,
      'token': instance.token,
      'limit': instance.limit,
      'channel_type': _$ChannelTypeEnumMap[instance.channelType],
      'channel_url': instance.channelUrl,
      'query_type': _$UserListQueryTypeEnumMap[instance.queryType]!,
      'user_ids': instance.userIds,
    };

const _$UserListQueryTypeEnumMap = {
  UserListQueryType.blocked: 'blocked',
  UserListQueryType.participants: 'participants',
  UserListQueryType.muted: 'muted',
  UserListQueryType.banned: 'banned',
  UserListQueryType.filtered: 'filtered',
};

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
};

ApplicationUserListQuery _$ApplicationUserListQueryFromJson(
        Map<String, dynamic> json) =>
    ApplicationUserListQuery(
      metaDataKey: json['meta_data_key'] as String?,
      metaDataValues: (json['meta_data_values'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      nicknameStartsWith: json['nickname_starts_with'] as String?,
    )
      ..loading = json['loading'] as bool
      ..hasNext = json['has_next'] as bool
      ..token = json['token'] as String?
      ..limit = json['limit'] as int
      ..channelType =
          $enumDecodeNullable(_$ChannelTypeEnumMap, json['channel_type'])
      ..channelUrl = json['channel_url'] as String?
      ..queryType = $enumDecode(_$UserListQueryTypeEnumMap, json['query_type'])
      ..userIds = (json['user_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList();

Map<String, dynamic> _$ApplicationUserListQueryToJson(
        ApplicationUserListQuery instance) =>
    <String, dynamic>{
      'loading': instance.loading,
      'has_next': instance.hasNext,
      'token': instance.token,
      'limit': instance.limit,
      'channel_type': _$ChannelTypeEnumMap[instance.channelType],
      'channel_url': instance.channelUrl,
      'query_type': _$UserListQueryTypeEnumMap[instance.queryType]!,
      'user_ids': instance.userIds,
      'meta_data_key': instance.metaDataKey,
      'meta_data_values': instance.metaDataValues,
      'nickname_starts_with': instance.nicknameStartsWith,
    };
