// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_info_updated_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThreadInfoUpdateEvent _$ThreadInfoUpdateEventFromJson(
        Map<String, dynamic> json) =>
    ThreadInfoUpdateEvent(
      threadInfo:
          ThreadInfo.fromJson(json['threadInfo'] as Map<String, dynamic>),
      targetMessageId: json['parent_message_id'] as int,
      channelType: $enumDecode(_$ChannelTypeEnumMap, json['channelType']),
      channelUrl: json['channelUrl'] as String,
    );

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
  ChannelType.feed: 'feed',
};
