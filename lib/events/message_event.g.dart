// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageEvent _$MessageEventFromJson(Map<String, dynamic> json) {
  return MessageEvent(
    requestId: json['req_id'] as String,
    messageId: json['msg_id'] as int,
    forceUpdateLastMessage: json['force_update_last_message'] as bool,
    silent: json['silent'] as bool,
    channelType: _$enumDecodeNullable(
        _$ChannelTypeEnumMap, json['channel_type'],
        unknownValue: ChannelType.group),
    channelUrl: json['channel_url'] as String,
    sender: json['user'] == null
        ? null
        : Sender.fromJson(json['user'] as Map<String, dynamic>),
    mentionType: _$enumDecodeNullable(
        _$MentionTypeEnumMap, json['mention_type'],
        unknownValue: MentionType.users),
    mentionedUsers: (json['mentioned_users'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    thumbnails: (json['thumbnails'] as List)
        ?.map((e) =>
            e == null ? null : Thumbnail.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    oldValues: json['old_values'] as Map<String, dynamic>,
  );
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
};

const _$MentionTypeEnumMap = {
  MentionType.users: 'users',
  MentionType.channel: 'channel',
};
