// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_channel_filters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupChannelFilter _$GroupChannelFilterFromJson(Map<String, dynamic> json) {
  return GroupChannelFilter()
    ..memberStateFilter =
        _$enumDecode(_$MemberStateFilterEnumMap, json['member_state_filter'])
    ..superMode = _$enumDecode(_$SuperChannelFilterEnumMap, json['super_mode'])
    ..publicMode =
        _$enumDecode(_$PublicChannelFilterEnumMap, json['public_mode'])
    ..customTypeStartswith = json['custom_type_startswith'] as String?
    ..customTypes = (json['custom_types'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList()
    ..membersNicknameContains = json['members_nickname_contains'] as String?
    ..membersExactlyIn = (json['members_exactly_in'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList()
    ..nameContains = json['name_contains'] as String?
    ..unreadFilter =
        _$enumDecode(_$UnreadChannelFilterEnumMap, json['unread_filter'])
    ..hiddenMode =
        _$enumDecode(_$ChannelHiddenStateFilterEnumMap, json['hidden_mode'])
    ..publicMembershipFilter = _$enumDecode(
        _$PublicGroupChannelMembershipFilterEnumMap,
        json['public_membership_filter']);
}

Map<String, dynamic> _$GroupChannelFilterToJson(GroupChannelFilter instance) =>
    <String, dynamic>{
      'member_state_filter':
          memberStateFilterEnumForQuery(instance.memberStateFilter),
      'super_mode': groupChannelSuperFilterEnum(instance.superMode),
      'public_mode': _$PublicChannelFilterEnumMap[instance.publicMode],
      'custom_type_startswith': instance.customTypeStartswith,
      'custom_types': instance.customTypes,
      'members_nickname_contains': instance.membersNicknameContains,
      'members_exactly_in': instance.membersExactlyIn,
      'name_contains': instance.nameContains,
      'unread_filter': _$UnreadChannelFilterEnumMap[instance.unreadFilter],
      'hidden_mode': _$ChannelHiddenStateFilterEnumMap[instance.hiddenMode],
      'public_membership_filter': _$PublicGroupChannelMembershipFilterEnumMap[
          instance.publicMembershipFilter],
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
  ChannelHiddenStateFilter.unhiddenOnly: 'unhidden_only',
  ChannelHiddenStateFilter.hiddenOnly: 'hidden_only',
  ChannelHiddenStateFilter.hiddenAllowAutoUnhide: 'hidden_allow_auto_hide',
  ChannelHiddenStateFilter.hiddenPreventAutoUnhide:
      'hidden_prevent_auto_unhide',
};

const _$PublicGroupChannelMembershipFilterEnumMap = {
  PublicGroupChannelMembershipFilter.all: 'all',
  PublicGroupChannelMembershipFilter.joined: 'joined',
};
