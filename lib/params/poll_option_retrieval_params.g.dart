// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_option_retrieval_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollOptionRetrievalParams _$PollOptionRetrievalParamsFromJson(
        Map<String, dynamic> json) =>
    PollOptionRetrievalParams(
      channelUrl: json['channel_url'] as String,
      pollOptionId: json['poll_option_id'] as int,
      pollId: json['poll_id'] as int,
      channelType: $enumDecode(_$ChannelTypeEnumMap, json['channel_type']),
    );

Map<String, dynamic> _$PollOptionRetrievalParamsToJson(
        PollOptionRetrievalParams instance) =>
    <String, dynamic>{
      'channel_url': instance.channelUrl,
      'poll_option_id': instance.pollOptionId,
      'poll_id': instance.pollId,
      'channel_type': _$ChannelTypeEnumMap[instance.channelType]!,
    };

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
};
