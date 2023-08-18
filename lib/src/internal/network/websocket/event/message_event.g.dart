// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageEvent _$MessageEventFromJson(Map<String, dynamic> json) => MessageEvent(
      messageId: json['msg_id'] as int,
      channelType: $enumDecode(_$ChannelTypeEnumMap, json['channelType'],
          unknownValue: ChannelType.group),
      channelUrl: json['channelUrl'] as String,
      forceUpdateLastMessage: json['forceUpdateLastMessage'] as bool? ?? false,
      silent: json['silent'] as bool? ?? false,
      sender: json['user'] == null
          ? null
          : Sender.fromJson(json['user'] as Map<String, dynamic>),
      requestId: json['req_id'] as String?,
      mentionType: $enumDecodeNullable(
          _$MentionTypeEnumMap, json['mentionType'],
          unknownValue: MentionType.users),
      mentionedUsers: (json['mentionedUsers'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      thumbnails: (json['thumbnails'] as List<dynamic>?)
          ?.map((e) => Thumbnail.fromJson(e as Map<String, dynamic>))
          .toList(),
      oldValues: json['oldValues'] as Map<String, dynamic>?,
    );

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
  ChannelType.feed: 'feed',
};

const _$MentionTypeEnumMap = {
  MentionType.users: 'users',
  MentionType.channel: 'channel',
};
