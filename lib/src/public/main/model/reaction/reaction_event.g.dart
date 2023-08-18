// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReactionEvent _$ReactionEventFromJson(Map<String, dynamic> json) =>
    ReactionEvent(
      channelType: $enumDecodeNullable(
              _$ChannelTypeEnumMap, json['channelType'],
              unknownValue: ChannelType.group) ??
          ChannelType.group,
      channelUrl: json['channelUrl'] as String? ?? '',
      messageId: json['msg_id'] as int,
      key: json['reaction'] as String,
      userId: json['userId'] as String,
      operation: $enumDecode(_$ReactionEventActionEnumMap, json['operation']),
      updatedAt: json['updatedAt'] as int?,
    );

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
  ChannelType.feed: 'feed',
};

const _$ReactionEventActionEnumMap = {
  ReactionEventAction.add: 'ADD',
  ReactionEventAction.delete: 'DELETE',
};
