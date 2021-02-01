// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_channel_filters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupChannelFilter _$GroupChannelFilterFromJson(Map<String, dynamic> json) {
  return GroupChannelFilter()
    ..memberStateFilter = _$enumDecodeNullable(
        _$MemberStateFilterEnumMap, json['member_state_filter'])
    ..superMode = _$enumDecodeNullable(
        _$GroupChannelSuperChannelFilterEnumMap, json['super_mode'])
    ..publicMode = _$enumDecodeNullable(
        _$GroupChannelPublicChannelFilterEnumMap, json['public_mode'])
    ..customTypeStartswith = json['custom_type_startswith'] as String
    ..customTypes =
        (json['custom_types'] as List)?.map((e) => e as String)?.toList()
    ..membersNicknameContains = json['members_nickname_contains'] as String
    ..membersExactlyIn =
        (json['members_exactly_in'] as List)?.map((e) => e as String)?.toList()
    ..nameContains = json['name_contains'] as String
    ..unreadFilter = _$enumDecodeNullable(
        _$UnreadChannelFilterEnumMap, json['unread_filter'])
    ..hiddenMode = _$enumDecodeNullable(
        _$ChannelHiddenStateFilterEnumMap, json['hidden_mode'])
    ..publicMembershipFilter = _$enumDecodeNullable(
        _$PublicGroupChannelMembershipFilterEnumMap,
        json['public_membership_filter']);
}

Map<String, dynamic> _$GroupChannelFilterToJson(GroupChannelFilter instance) =>
    <String, dynamic>{
      'member_state_filter':
          _$MemberStateFilterEnumMap[instance.memberStateFilter],
      'super_mode': _$GroupChannelSuperChannelFilterEnumMap[instance.superMode],
      'public_mode':
          _$GroupChannelPublicChannelFilterEnumMap[instance.publicMode],
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

const _$PublicGroupChannelMembershipFilterEnumMap = {
  PublicGroupChannelMembershipFilter.all: 'all',
  PublicGroupChannelMembershipFilter.joined: 'joined',
};
