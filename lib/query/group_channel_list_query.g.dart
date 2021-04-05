// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_channel_list_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupChannelListQuery _$GroupChannelListQueryFromJson(
    Map<String, dynamic> json) {
  return GroupChannelListQuery()
    ..loading = json['loading'] as bool
    ..hasNext = json['has_next'] as bool
    ..token = json['token'] as String
    ..limit = json['limit'] as int
    ..order =
        _$enumDecodeNullable(_$GroupChannelListOrderEnumMap, json['order'])
    ..queryType = _$enumDecodeNullable(
        _$GroupChannelListQueryTypeEnumMap, json['query_type'])
    ..channelUrls =
        (json['channel_urls'] as List)?.map((e) => e as String)?.toList()
    ..memberStateFilter = _$enumDecodeNullable(
        _$MemberStateFilterEnumMap, json['member_state_filter'])
    ..superChannelFilter = _$enumDecodeNullable(
        _$GroupChannelSuperChannelFilterEnumMap, json['super_channel_filter'])
    ..publicChannelFilter = _$enumDecodeNullable(
        _$GroupChannelPublicChannelFilterEnumMap, json['public_channel_filter'])
    ..customTypeStartWithFilter =
        json['custom_type_start_with_filter'] as String
    ..customTypesFilter =
        (json['custom_types_filter'] as List)?.map((e) => e as String)?.toList()
    ..nicknameContainsFilter = json['nickname_contains_filter'] as String
    ..userIdsIncludeFilter = (json['user_ids_include_filter'] as List)
        ?.map((e) => e as String)
        ?.toList()
    ..userIdsExactFilter = (json['user_ids_exact_filter'] as List)
        ?.map((e) => e as String)
        ?.toList()
    ..channelNameContainsFilter = json['channel_name_contains_filter'] as String
    ..unreadChannelFilter = _$enumDecodeNullable(
        _$UnreadChannelFilterEnumMap, json['unread_channel_filter'])
    ..metaDataOrderKeyFilter = json['meta_data_order_key_filter'] as String
    ..channelHiddenStateFilter = _$enumDecodeNullable(
        _$ChannelHiddenStateFilterEnumMap, json['channel_hidden_state_filter'])
    ..searchQuery = json['search_query'] as String
    ..searchFields = (json['search_fields'] as List)
        ?.map((e) =>
            _$enumDecodeNullable(_$GroupChannelListQuerySearchFieldEnumMap, e))
        ?.toList()
    ..includeEmptyChannel = json['include_empty_channel'] as bool
    ..includeFrozenChannel = json['include_frozen_channel'] as bool
    ..includeMemberList = json['include_member_list'] as bool
    ..includeMetaData = json['include_meta_data'] as bool;
}

Map<String, dynamic> _$GroupChannelListQueryToJson(
        GroupChannelListQuery instance) =>
    <String, dynamic>{
      'loading': instance.loading,
      'has_next': instance.hasNext,
      'token': instance.token,
      'limit': instance.limit,
      'order': _$GroupChannelListOrderEnumMap[instance.order],
      'query_type': _$GroupChannelListQueryTypeEnumMap[instance.queryType],
      'channel_urls': instance.channelUrls,
      'member_state_filter':
          _$MemberStateFilterEnumMap[instance.memberStateFilter],
      'super_channel_filter':
          _$GroupChannelSuperChannelFilterEnumMap[instance.superChannelFilter],
      'public_channel_filter': _$GroupChannelPublicChannelFilterEnumMap[
          instance.publicChannelFilter],
      'custom_type_start_with_filter': instance.customTypeStartWithFilter,
      'custom_types_filter': instance.customTypesFilter,
      'nickname_contains_filter': instance.nicknameContainsFilter,
      'user_ids_include_filter': instance.userIdsIncludeFilter,
      'user_ids_exact_filter': instance.userIdsExactFilter,
      'channel_name_contains_filter': instance.channelNameContainsFilter,
      'unread_channel_filter':
          _$UnreadChannelFilterEnumMap[instance.unreadChannelFilter],
      'meta_data_order_key_filter': instance.metaDataOrderKeyFilter,
      'channel_hidden_state_filter':
          _$ChannelHiddenStateFilterEnumMap[instance.channelHiddenStateFilter],
      'search_query': instance.searchQuery,
      'search_fields': instance.searchFields
          ?.map((e) => _$GroupChannelListQuerySearchFieldEnumMap[e])
          ?.toList(),
      'include_empty_channel': instance.includeEmptyChannel,
      'include_frozen_channel': instance.includeFrozenChannel,
      'include_member_list': instance.includeMemberList,
      'include_meta_data': instance.includeMetaData,
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

const _$GroupChannelListOrderEnumMap = {
  GroupChannelListOrder.chronological: 'chronological',
  GroupChannelListOrder.latestLastMessage: 'latest_last_message',
  GroupChannelListOrder.channelNameAlphabetical: 'channel_name_alphabetical',
  GroupChannelListOrder.channelMetaDataValueAlphabetical:
      'metadata_value_alphabetical',
};

const _$GroupChannelListQueryTypeEnumMap = {
  GroupChannelListQueryType.and: 'and',
  GroupChannelListQueryType.or: 'or',
};

const _$MemberStateFilterEnumMap = {
  MemberStateFilter.all: 'all',
  MemberStateFilter.invited: 'invited',
  MemberStateFilter.joined: 'joined',
  MemberStateFilter.invitedByFriend: 'invited_by_friend',
  MemberStateFilter.invitedByNonFriend: 'invited_by_non_friend',
};

const _$GroupChannelSuperChannelFilterEnumMap = {
  GroupChannelSuperChannelFilter.all: 'all',
  GroupChannelSuperChannelFilter.superChannel: 'super',
  GroupChannelSuperChannelFilter.nonsuperChannel: 'nonsuper',
};

const _$GroupChannelPublicChannelFilterEnumMap = {
  GroupChannelPublicChannelFilter.all: 'all',
  GroupChannelPublicChannelFilter.public: 'public',
  GroupChannelPublicChannelFilter.private: 'private',
};

const _$UnreadChannelFilterEnumMap = {
  UnreadChannelFilter.all: 'all',
  UnreadChannelFilter.unreadMessage: 'unread_message',
};

const _$ChannelHiddenStateFilterEnumMap = {
  ChannelHiddenStateFilter.unhiddenOnly: 'unhidden_only',
  ChannelHiddenStateFilter.hiddenOnly: 'hidden_only',
  ChannelHiddenStateFilter.hiddenAllowAutoUnhide: 'hidden_allow_auto_hide',
  ChannelHiddenStateFilter.hiddenPreventAutoUnhide:
      'hidden_prevent_auto_unhide',
};

const _$GroupChannelListQuerySearchFieldEnumMap = {
  GroupChannelListQuerySearchField.memberNickname: 'member_nick_name',
  GroupChannelListQuerySearchField.channelName: 'channel_name',
};
