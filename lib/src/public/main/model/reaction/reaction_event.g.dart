// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReactionEvent _$ReactionEventFromJson(Map<String, dynamic> json) =>
    ReactionEvent(
      channelType: $enumDecodeNullable(
              _$ChannelTypeEnumMap, json['channel_type'],
              unknownValue: ChannelType.group) ??
          ChannelType.group,
      channelUrl: json['channel_url'] as String? ?? '',
      messageId: json['msg_id'] as int? ?? 0,
      key: json['reaction'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      operation: $enumDecodeNullable(
              _$ReactionEventActionEnumMap, json['operation']) ??
          ReactionEventAction.delete,
      updatedAt: json['updated_at'] as int? ?? 0,
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
