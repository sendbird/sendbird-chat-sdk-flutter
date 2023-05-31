// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelEvent _$ChannelEventFromJson(Map<String, dynamic> json) => ChannelEvent(
      channelType: $enumDecode(_$ChannelTypeEnumMap, json['channel_type']),
      channelUrl: json['channel_url'] as String,
      category: channelEventValueOf(json['cat'] as int),
      data: json['data'] as Map<String, dynamic>? ?? {},
      ts: json['ts'] as int?,
      messageOffset: json['ts_message_offset'] as int?,
    );

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
};
