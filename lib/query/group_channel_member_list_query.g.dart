// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_channel_member_list_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupChannelMemberListQuery _$GroupChannelMemberListQueryFromJson(
    Map<String, dynamic> json) {
  return GroupChannelMemberListQuery()
    ..loading = json['loading'] as bool
    ..hasNext = json['has_next'] as bool
    ..token = json['token'] as String
    ..limit = json['limit'] as int
    ..channelUrl = json['channel_url'] as String
    ..nicknameStartsWith = json['nickname_starts_with'] as String
    ..operatorFilter =
        _$enumDecodeNullable(_$OperatorFilterEnumMap, json['operator_filter'])
    ..mutedMemberFilter = _$enumDecodeNullable(
        _$MutedMemberFilterEnumMap, json['muted_member_filter'])
    ..memberStateFilter = _$enumDecodeNullable(
        _$MemberStateFilterEnumMap, json['member_state_filter'])
    ..order = _$enumDecodeNullable(_$MemberListOrderEnumMap, json['order']);
}

Map<String, dynamic> _$GroupChannelMemberListQueryToJson(
        GroupChannelMemberListQuery instance) =>
    <String, dynamic>{
      'loading': instance.loading,
      'has_next': instance.hasNext,
      'token': instance.token,
      'limit': instance.limit,
      'channel_url': instance.channelUrl,
      'nickname_starts_with': instance.nicknameStartsWith,
      'operator_filter': _$OperatorFilterEnumMap[instance.operatorFilter],
      'muted_member_filter':
          _$MutedMemberFilterEnumMap[instance.mutedMemberFilter],
      'member_state_filter':
          _$MemberStateFilterEnumMap[instance.memberStateFilter],
      'order': _$MemberListOrderEnumMap[instance.order],
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

const _$OperatorFilterEnumMap = {
  OperatorFilter.all: 'all',
  OperatorFilter.operator: 'operator',
  OperatorFilter.nonOperator: 'nonOperator',
};

const _$MutedMemberFilterEnumMap = {
  MutedMemberFilter.all: 'all',
  MutedMemberFilter.muted: 'muted',
  MutedMemberFilter.unmuted: 'unmuted',
};

const _$MemberStateFilterEnumMap = {
  MemberStateFilter.all: 'all',
  MemberStateFilter.invited: 'invited',
  MemberStateFilter.joined: 'joined',
  MemberStateFilter.invitedByFriend: 'invited_by_friend',
  MemberStateFilter.invitedByNonFriend: 'invited_by_non_friend',
};

const _$MemberListOrderEnumMap = {
  MemberListOrder.nicknameAlphabetical: 'nicknameAlphabetical',
  MemberListOrder.operatorThenMemberNicknameAlphabetical:
      'operatorThenMemberNicknameAlphabetical',
};
