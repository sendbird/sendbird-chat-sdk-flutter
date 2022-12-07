// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_list_query_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollListQueryParams _$PollListQueryParamsFromJson(Map<String, dynamic> json) =>
    PollListQueryParams(
      channelType: $enumDecode(_$ChannelTypeEnumMap, json['channel_type']),
      channelUrl: json['channel_url'] as String,
      limit: json['limit'] as int? ?? 20,
    );

Map<String, dynamic> _$PollListQueryParamsToJson(
        PollListQueryParams instance) =>
    <String, dynamic>{
      'channel_type': _$ChannelTypeEnumMap[instance.channelType]!,
      'channel_url': instance.channelUrl,
      'limit': instance.limit,
    };

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
};
