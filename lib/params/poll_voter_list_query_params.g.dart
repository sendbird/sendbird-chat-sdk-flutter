// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_voter_list_query_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollVoterListQueryParams _$PollVoterListQueryParamsFromJson(
        Map<String, dynamic> json) =>
    PollVoterListQueryParams(
      pollId: json['poll_id'] as int,
      pollOptionId: json['poll_option_id'] as int,
      channelType: $enumDecode(_$ChannelTypeEnumMap, json['channel_type']),
      channelUrl: json['channel_url'] as String,
      limit: json['limit'] as int? ?? 20,
    );

Map<String, dynamic> _$PollVoterListQueryParamsToJson(
        PollVoterListQueryParams instance) =>
    <String, dynamic>{
      'poll_id': instance.pollId,
      'poll_option_id': instance.pollOptionId,
      'channel_type': _$ChannelTypeEnumMap[instance.channelType]!,
      'channel_url': instance.channelUrl,
      'limit': instance.limit,
    };

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
};
