// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_channel_member_list_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupChannelMemberListQuery _$GroupChannelMemberListQueryFromJson(
        Map<String, dynamic> json) =>
    GroupChannelMemberListQuery(
      channelUrl: json['channel_url'] as String,
    )
      ..loading = json['loading'] as bool
      ..hasNext = json['has_next'] as bool
      ..token = json['token'] as String?
      ..limit = json['limit'] as int
      ..nicknameStartsWith = json['nickname_starts_with'] as String?
      ..operatorFilter =
          $enumDecode(_$OperatorFilterEnumMap, json['operator_filter'])
      ..mutedMemberFilter =
          $enumDecode(_$MutedMemberFilterEnumMap, json['muted_member_filter'])
      ..memberStateFilter =
          $enumDecode(_$MemberStateFilterEnumMap, json['member_state_filter'])
      ..order = $enumDecode(_$MemberListOrderEnumMap, json['order']);

Map<String, dynamic> _$GroupChannelMemberListQueryToJson(
        GroupChannelMemberListQuery instance) =>
    <String, dynamic>{
      'loading': instance.loading,
      'has_next': instance.hasNext,
      'token': instance.token,
      'limit': instance.limit,
      'channel_url': instance.channelUrl,
      'nickname_starts_with': instance.nicknameStartsWith,
      'operator_filter': _$OperatorFilterEnumMap[instance.operatorFilter]!,
      'muted_member_filter':
          _$MutedMemberFilterEnumMap[instance.mutedMemberFilter]!,
      'member_state_filter':
          memberStateFilterEnumForQuery(instance.memberStateFilter),
      'order': _$MemberListOrderEnumMap[instance.order]!,
    };

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
