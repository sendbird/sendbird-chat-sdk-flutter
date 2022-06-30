// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_voter_list_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollVoterListQuery _$PollVoterListQueryFromJson(Map<String, dynamic> json) =>
    PollVoterListQuery(
      channelUrl: json['channel_url'] as String,
      pollId: json['poll_id'] as int,
      optionId: json['option_id'] as int,
      channelType: $enumDecode(_$ChannelTypeEnumMap, json['channel_type']),
    )
      ..loading = json['loading'] as bool
      ..hasNext = json['has_next'] as bool
      ..token = json['token'] as String?
      ..limit = json['limit'] as int;

Map<String, dynamic> _$PollVoterListQueryToJson(PollVoterListQuery instance) =>
    <String, dynamic>{
      'loading': instance.loading,
      'has_next': instance.hasNext,
      'token': instance.token,
      'limit': instance.limit,
      'channel_url': instance.channelUrl,
      'poll_id': instance.pollId,
      'option_id': instance.optionId,
      'channel_type': _$ChannelTypeEnumMap[instance.channelType],
    };

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
};
