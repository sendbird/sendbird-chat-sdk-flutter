// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_info_updated_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThreadInfoUpdateEvent _$ThreadInfoUpdateEventFromJson(
        Map<String, dynamic> json) =>
    ThreadInfoUpdateEvent(
      threadInfo:
          ThreadInfo.fromJson(json['thread_info'] as Map<String, dynamic>),
      targetMessageId: (json['parent_message_id'] as num).toInt(),
      channelType: $enumDecode(_$ChannelTypeEnumMap, json['channel_type']),
      channelUrl: json['channel_url'] as String,
    );

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
  ChannelType.feed: 'feed',
};
