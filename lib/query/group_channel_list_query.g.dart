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
        _$SuperChannelFilterEnumMap, json['super_channel_filter'])
    ..publicChannelFilter = _$enumDecodeNullable(
        _$PublicChannelFilterEnumMap, json['public_channel_filter'])
    ..unreadChannelFilter = _$enumDecodeNullable(
        _$UnreadChannelFilterEnumMap, json['unread_channel_filter'])
    ..channelHiddenStateFilter = _$enumDecodeNullable(
        _$ChannelHiddenStateFilterEnumMap, json['channel_hidden_state_filter'])
    ..customTypeStartWith = json['custom_type_start_with'] as String
    ..customTypes =
        (json['custom_types'] as List)?.map((e) => e as String)?.toList()
    ..nicknameContains = json['nickname_contains'] as String
    ..userIdsIncludeIn =
        (json['user_ids_include_in'] as List)?.map((e) => e as String)?.toList()
    ..userIdsExactlyIn =
        (json['user_ids_exactly_in'] as List)?.map((e) => e as String)?.toList()
    ..channelNameContains = json['channel_name_contains'] as String
    ..metaDataOrderKey = json['meta_data_order_key'] as String
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
          _$SuperChannelFilterEnumMap[instance.superChannelFilter],
      'public_channel_filter':
          _$PublicChannelFilterEnumMap[instance.publicChannelFilter],
      'unread_channel_filter':
          _$UnreadChannelFilterEnumMap[instance.unreadChannelFilter],
      'channel_hidden_state_filter':
          _$ChannelHiddenStateFilterEnumMap[instance.channelHiddenStateFilter],
      'custom_type_start_with': instance.customTypeStartWith,
      'custom_types': instance.customTypes,
      'nickname_contains': instance.nicknameContains,
      'user_ids_include_in': instance.userIdsIncludeIn,
      'user_ids_exactly_in': instance.userIdsExactlyIn,
      'channel_name_contains': instance.channelNameContains,
      'meta_data_order_key': instance.metaDataOrderKey,
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

const _$SuperChannelFilterEnumMap = {
  SuperChannelFilter.all: 'all',
  SuperChannelFilter.superChannel: 'super',
  SuperChannelFilter.nonsuperChannel: 'nonsuper',
};

const _$PublicChannelFilterEnumMap = {
  PublicChannelFilter.all: 'all',
  PublicChannelFilter.public: 'public',
  PublicChannelFilter.private: 'private',
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
