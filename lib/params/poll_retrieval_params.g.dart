// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_retrieval_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollRetrievalParams _$PollRetrievalParamsFromJson(Map<String, dynamic> json) =>
    PollRetrievalParams(
      channelUrl: json['channel_url'] as String,
      pollId: json['poll_id'] as int,
      showPartialVoterList: json['show_partial_voter_list'] as bool? ?? false,
      channelType: $enumDecode(_$ChannelTypeEnumMap, json['channel_type']),
    );

Map<String, dynamic> _$PollRetrievalParamsToJson(
        PollRetrievalParams instance) =>
    <String, dynamic>{
      'channel_url': instance.channelUrl,
      'poll_id': instance.pollId,
      'show_partial_voter_list': instance.showPartialVoterList,
      'channel_type': _$ChannelTypeEnumMap[instance.channelType],
    };

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
};
