// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageEvent _$MessageEventFromJson(Map<String, dynamic> json) => MessageEvent(
      messageId: json['msg_id'] as int,
      channelType: $enumDecode(_$ChannelTypeEnumMap, json['channel_type'],
          unknownValue: ChannelType.group),
      channelUrl: json['channel_url'] as String,
      forceUpdateLastMessage:
          json['force_update_last_message'] as bool? ?? false,
      silent: json['silent'] as bool? ?? false,
      sender: json['user'] == null
          ? null
          : Sender.fromJson(json['user'] as Map<String, dynamic>),
      requestId: json['req_id'] as String?,
      mentionType: $enumDecodeNullable(
          _$MentionTypeEnumMap, json['mention_type'],
          unknownValue: MentionType.users),
      mentionedUsers: (json['mentioned_users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      thumbnails: (json['thumbnails'] as List<dynamic>?)
          ?.map((e) => Thumbnail.fromJson(e as Map<String, dynamic>))
          .toList(),
      oldValues: json['old_values'] as Map<String, dynamic>?,
    );

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
};

const _$MentionTypeEnumMap = {
  MentionType.users: 'users',
  MentionType.channel: 'channel',
};
