// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListQuery _$UserListQueryFromJson(Map<String, dynamic> json) {
  return UserListQuery(
    queryType: _$enumDecode(_$UserListQueryTypeEnumMap, json['query_type']),
    channelType:
        _$enumDecodeNullable(_$ChannelTypeEnumMap, json['channel_type']),
    channelUrl: json['channel_url'] as String?,
    userIds:
        (json['user_ids'] as List<dynamic>?)?.map((e) => e as String).toList(),
  )
    ..loading = json['loading'] as bool
    ..hasNext = json['has_next'] as bool
    ..token = json['token'] as String?
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

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$UserListQueryTypeEnumMap = {
  UserListQueryType.blocked: 'blocked',
  UserListQueryType.participants: 'participants',
  UserListQueryType.muted: 'muted',
  UserListQueryType.banned: 'banned',
  UserListQueryType.filtered: 'filtered',
};

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
};

ApplicationUserListQuery _$ApplicationUserListQueryFromJson(
    Map<String, dynamic> json) {
  return ApplicationUserListQuery(
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
        _$enumDecodeNullable(_$ChannelTypeEnumMap, json['channel_type'])
    ..channelUrl = json['channel_url'] as String?
    ..queryType = _$enumDecode(_$UserListQueryTypeEnumMap, json['query_type'])
    ..userIds =
        (json['user_ids'] as List<dynamic>?)?.map((e) => e as String).toList();
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
      'nickname_starts_with': instance.nicknameStartsWith,
    };
