// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListQuery _$UserListQueryFromJson(Map<String, dynamic> json) {
  return UserListQuery(
    queryType:
        _$enumDecodeNullable(_$UserListQueryTypeEnumMap, json['query_type']),
    channelType:
        _$enumDecodeNullable(_$ChannelTypeEnumMap, json['channel_type']),
    channelUrl: json['channel_url'] as String,
    userIds: (json['user_ids'] as List)?.map((e) => e as String)?.toList(),
  )
    ..loading = json['loading'] as bool
    ..hasNext = json['has_next'] as bool
    ..token = json['token'] as String
    ..limit = json['limit'] as int;
}

Map<String, dynamic> _$UserListQueryToJson(UserListQuery instance) =>
    <String, dynamic>{
      'loading': instance.loading,
      'has_next': instance.hasNext,
      'token': instance.token,
      'limit': instance.limit,
      'channel_type': _$ChannelTypeEnumMap[instance.channelType],
      'channel_url': instance.channelUrl,
      'query_type': _$UserListQueryTypeEnumMap[instance.queryType],
      'user_ids': instance.userIds,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

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
    Map<String, dynamic> json) {
  return ApplicationUserListQuery(
    metaDataKey: json['meta_data_key'] as String,
    metaDataValues:
        (json['meta_data_values'] as List)?.map((e) => e as String)?.toList(),
  )
    ..loading = json['loading'] as bool
    ..hasNext = json['has_next'] as bool
    ..token = json['token'] as String
    ..limit = json['limit'] as int
    ..channelType =
        _$enumDecodeNullable(_$ChannelTypeEnumMap, json['channel_type'])
    ..channelUrl = json['channel_url'] as String
    ..queryType =
        _$enumDecodeNullable(_$UserListQueryTypeEnumMap, json['query_type'])
    ..userIds = (json['user_ids'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$ApplicationUserListQueryToJson(
        ApplicationUserListQuery instance) =>
    <String, dynamic>{
      'loading': instance.loading,
      'has_next': instance.hasNext,
      'token': instance.token,
      'limit': instance.limit,
      'channel_type': _$ChannelTypeEnumMap[instance.channelType],
      'channel_url': instance.channelUrl,
      'query_type': _$UserListQueryTypeEnumMap[instance.queryType],
      'user_ids': instance.userIds,
      'meta_data_key': instance.metaDataKey,
      'meta_data_values': instance.metaDataValues,
    };
