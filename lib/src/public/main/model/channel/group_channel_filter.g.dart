// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_channel_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupChannelFilter _$GroupChannelFilterFromJson(Map<String, dynamic> json) =>
    GroupChannelFilter()
      ..memberStateFilter =
          $enumDecode(_$MyMemberStateFilterEnumMap, json['memberStateFilter'])
      ..superMode = $enumDecode(_$SuperChannelFilterEnumMap, json['superMode'])
      ..publicMode =
          $enumDecode(_$PublicChannelFilterEnumMap, json['publicMode'])
      ..customTypeStartsWith = json['custom_type_startswith'] as String?
      ..customTypes = (json['customTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..membersNicknameContains = json['membersNicknameContains'] as String?
      ..membersExactlyIn = (json['membersExactlyIn'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..nameContains = json['nameContains'] as String?
      ..unreadFilter =
          $enumDecode(_$UnreadChannelFilterEnumMap, json['unreadFilter'])
      ..hiddenMode =
          $enumDecode(_$HiddenChannelFilterEnumMap, json['hiddenMode'])
      ..publicMembershipFilter =
          $enumDecode(_$MembershipFilterEnumMap, json['public_membership_mode'])
      ..metaDataKey = json['metadata_key'] as String?
      ..metaDataValues = (json['metadata_values'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..metaDataValueStartsWithFilter =
          json['metadata_value_startswith'] as String?;

Map<String, dynamic> _$GroupChannelFilterToJson(GroupChannelFilter instance) =>
    <String, dynamic>{
      'memberStateFilter':
          memberStateFilterEnumForQuery(instance.memberStateFilter),
      'superMode': groupChannelSuperFilterEnum(instance.superMode),
      'publicMode': _$PublicChannelFilterEnumMap[instance.publicMode]!,
      'custom_type_startswith': instance.customTypeStartsWith,
      'customTypes': instance.customTypes,
      'membersNicknameContains': instance.membersNicknameContains,
      'membersExactlyIn': instance.membersExactlyIn,
      'nameContains': instance.nameContains,
      'unreadFilter': _$UnreadChannelFilterEnumMap[instance.unreadFilter]!,
      'hiddenMode': _$HiddenChannelFilterEnumMap[instance.hiddenMode]!,
      'public_membership_mode':
          _$MembershipFilterEnumMap[instance.publicMembershipFilter]!,
      'metadata_key': instance.metaDataKey,
      'metadata_values': instance.metaDataValues,
      'metadata_value_startswith': instance.metaDataValueStartsWithFilter,
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
