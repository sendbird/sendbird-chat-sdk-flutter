// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_channel_list_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupChannelListQuery _$GroupChannelListQueryFromJson(
        Map<String, dynamic> json) =>
    GroupChannelListQuery()
      ..loading = json['loading'] as bool
      ..hasNext = json['has_next'] as bool
      ..token = json['token'] as String?
      ..limit = json['limit'] as int
      ..order = $enumDecode(_$GroupChannelListOrderEnumMap, json['order'])
      ..queryType =
          $enumDecode(_$GroupChannelListQueryTypeEnumMap, json['query_type'])
      ..channelUrls = (json['channel_urls'] as List<dynamic>)
          .map((e) => e as String)
          .toList()
      ..memberStateFilter =
          $enumDecode(_$MemberStateFilterEnumMap, json['member_state_filter'])
      ..superChannelFilter =
          $enumDecode(_$SuperChannelFilterEnumMap, json['super_channel_filter'])
      ..publicChannelFilter = $enumDecode(
          _$PublicChannelFilterEnumMap, json['public_channel_filter'])
      ..unreadChannelFilter = $enumDecode(
          _$UnreadChannelFilterEnumMap, json['unread_channel_filter'])
      ..channelHiddenStateFilter = $enumDecode(
          _$ChannelHiddenStateFilterEnumMap,
          json['channel_hidden_state_filter'])
      ..customTypeStartWith = json['custom_type_start_with'] as String?
      ..customTypes = (json['custom_types'] as List<dynamic>)
          .map((e) => e as String)
          .toList()
      ..nicknameContains = json['nickname_contains'] as String?
      ..userIdsIncludeIn = (json['user_ids_include_in'] as List<dynamic>)
          .map((e) => e as String)
          .toList()
      ..userIdsExactlyIn = (json['user_ids_exactly_in'] as List<dynamic>)
          .map((e) => e as String)
          .toList()
      ..channelNameContains = json['channel_name_contains'] as String?
      ..metaDataOrderKeyFilter = json['meta_data_order_key_filter'] as String?
      ..metaDataKeyFilter = json['meta_data_key_filter'] as String?
      ..metaDataValuesFilter =
          (json['meta_data_values_filter'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList()
      ..metaDataValueStartWithFilter =
          json['meta_data_value_start_with_filter'] as String?
      ..searchQuery = json['search_query'] as String?
      ..searchFields = (json['search_fields'] as List<dynamic>)
          .map((e) => $enumDecode(_$GroupChannelListQuerySearchFieldEnumMap, e))
          .toList()
      ..includeEmptyChannel = json['include_empty_channel'] as bool
      ..includeFrozenChannel = json['include_frozen_channel'] as bool
      ..includeMemberList = json['include_member_list'] as bool
      ..includeMetaData = json['include_meta_data'] as bool;

Map<String, dynamic> _$GroupChannelListQueryToJson(
        GroupChannelListQuery instance) =>
    <String, dynamic>{
      'loading': instance.loading,
      'has_next': instance.hasNext,
      'token': instance.token,
      'limit': instance.limit,
      'order': _$GroupChannelListOrderEnumMap[instance.order]!,
      'query_type': _$GroupChannelListQueryTypeEnumMap[instance.queryType]!,
      'channel_urls': instance.channelUrls,
      'member_state_filter':
          memberStateFilterEnumForQuery(instance.memberStateFilter),
      'super_channel_filter':
          groupChannelSuperFilterEnum(instance.superChannelFilter),
      'public_channel_filter':
          _$PublicChannelFilterEnumMap[instance.publicChannelFilter]!,
      'unread_channel_filter':
          _$UnreadChannelFilterEnumMap[instance.unreadChannelFilter]!,
      'channel_hidden_state_filter':
          _$ChannelHiddenStateFilterEnumMap[instance.channelHiddenStateFilter]!,
      'custom_type_start_with': instance.customTypeStartWith,
      'custom_types': instance.customTypes,
      'nickname_contains': instance.nicknameContains,
      'user_ids_include_in': instance.userIdsIncludeIn,
      'user_ids_exactly_in': instance.userIdsExactlyIn,
      'channel_name_contains': instance.channelNameContains,
      'meta_data_order_key_filter': instance.metaDataOrderKeyFilter,
      'meta_data_key_filter': instance.metaDataKeyFilter,
      'meta_data_values_filter': instance.metaDataValuesFilter,
      'meta_data_value_start_with_filter':
          instance.metaDataValueStartWithFilter,
      'search_query': instance.searchQuery,
      'search_fields': instance.searchFields
          .map((e) => _$GroupChannelListQuerySearchFieldEnumMap[e]!)
          .toList(),
      'include_empty_channel': instance.includeEmptyChannel,
      'include_frozen_channel': instance.includeFrozenChannel,
      'include_member_list': instance.includeMemberList,
      'include_meta_data': instance.includeMetaData,
    };

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
  SuperChannelFilter.exclusiveOnly: 'exclusive_only',
  SuperChannelFilter.superChannel: 'super',
  SuperChannelFilter.nonsuperChannel: 'nonsuper',
  SuperChannelFilter.broadcastOnly: 'broadcast_only',
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
  ChannelHiddenStateFilter.all: 'all',
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
