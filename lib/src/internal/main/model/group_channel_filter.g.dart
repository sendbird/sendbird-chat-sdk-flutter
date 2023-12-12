// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_channel_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupChannelFilter _$GroupChannelFilterFromJson(Map<String, dynamic> json) =>
    GroupChannelFilter()
      ..memberStateFilter =
          $enumDecode(_$MyMemberStateFilterEnumMap, json['member_state_filter'])
      ..superMode = $enumDecode(_$SuperChannelFilterEnumMap, json['super_mode'])
      ..publicMode =
          $enumDecode(_$PublicChannelFilterEnumMap, json['public_mode'])
      ..customTypeStartsWith = json['custom_type_startswith'] as String?
      ..customTypes = (json['custom_types'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..membersNicknameContains = json['members_nickname_contains'] as String?
      ..membersExactlyIn = (json['members_exactly_in'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..nameContains = json['name_contains'] as String?
      ..unreadFilter =
          $enumDecode(_$UnreadChannelFilterEnumMap, json['unread_filter'])
      ..hiddenMode =
          $enumDecode(_$HiddenChannelFilterEnumMap, json['hidden_mode'])
      ..publicMembershipFilter =
          $enumDecode(_$MembershipFilterEnumMap, json['public_membership_mode'])
      ..metaDataKey = json['metadata_key'] as String?
      ..metaDataValues = (json['metadata_values'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..metaDataValueStartsWithFilter =
          json['metadata_value_startswith'] as String?
      ..createdBefore = json['created_before'] as int?
      ..createdAfter = json['created_after'] as int?;

Map<String, dynamic> _$GroupChannelFilterToJson(GroupChannelFilter instance) =>
    <String, dynamic>{
      'member_state_filter':
          memberStateFilterEnumForQuery(instance.memberStateFilter),
      'super_mode': groupChannelSuperFilterEnum(instance.superMode),
      'public_mode': _$PublicChannelFilterEnumMap[instance.publicMode]!,
      'custom_type_startswith': instance.customTypeStartsWith,
      'custom_types': instance.customTypes,
      'members_nickname_contains': instance.membersNicknameContains,
      'members_exactly_in': instance.membersExactlyIn,
      'name_contains': instance.nameContains,
      'unread_filter': _$UnreadChannelFilterEnumMap[instance.unreadFilter]!,
      'hidden_mode': _$HiddenChannelFilterEnumMap[instance.hiddenMode]!,
      'public_membership_mode':
          _$MembershipFilterEnumMap[instance.publicMembershipFilter]!,
      'metadata_key': instance.metaDataKey,
      'metadata_values': instance.metaDataValues,
      'metadata_value_startswith': instance.metaDataValueStartsWithFilter,
      'created_before': instance.createdBefore,
      'created_after': instance.createdAfter,
    };

const _$MyMemberStateFilterEnumMap = {
  MyMemberStateFilter.all: 'all',
  MyMemberStateFilter.invited: 'invited',
  MyMemberStateFilter.joined: 'joined',
  MyMemberStateFilter.invitedByFriend: 'invited_by_friend',
  MyMemberStateFilter.invitedByNonFriend: 'invited_by_non_friend',
};

const _$SuperChannelFilterEnumMap = {
  SuperChannelFilter.all: 'all',
  SuperChannelFilter.exclusiveChannelOnly: 'exclusive_only',
  SuperChannelFilter.superChannelOnly: 'super',
  SuperChannelFilter.nonsuperChannelOnly: 'nonsuper',
  SuperChannelFilter.broadcastChannelOnly: 'broadcast_only',
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

const _$HiddenChannelFilterEnumMap = {
  HiddenChannelFilter.all: 'all',
  HiddenChannelFilter.unhidden: 'unhidden_only',
  HiddenChannelFilter.hidden: 'hidden_only',
  HiddenChannelFilter.hiddenAllowAutoUnhide: 'hidden_allow_auto_hide',
  HiddenChannelFilter.hiddenPreventAutoUnhide: 'hidden_prevent_auto_unhide',
};

const _$MembershipFilterEnumMap = {
  MembershipFilter.all: 'all',
  MembershipFilter.joined: 'joined',
};
