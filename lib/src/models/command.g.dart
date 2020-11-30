// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Command _$CommandFromJson(Map<String, dynamic> json) {
  return Command(
    cmd: json['cmd'] as String,
    requestId: json['req_id'] as String,
    messageId: json['msg_id'] as int,
    timestamp: json['ts'] as int,
    forceUpdateLastMessage: json['force_update_last_message'] as bool,
    silent: json['silent'] as bool,
    loginTimestamp: json['login_ts'] as int,
    pingInterval: json['ping_interval'] as int,
    watchdogInterval: json['pong_timeout'] as int,
    channelUrl: json['channel_url'] as String,
    channelType: _$enumDecodeNullable(
        _$ChannelTypeEnumMap, json['channel_type'],
        unknownValue: ChannelType.group),
    thumbnails: (json['thumbnails'] as List)
        ?.map((e) =>
            e == null ? null : Thumbnail.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    key: json['key'] as String,
    newKey: json['new_key'] as String,
    ekey: json['ekey'] as String,
    expiresIn: json['expires_in'] as int,
    sender: json['user'] == null
        ? null
        : Sender.fromJson(json['user'] as Map<String, dynamic>),
    unreadCountInfo: json['unread_cnt'] == null
        ? null
        : UnreadCountInfo.fromJson(json['unread_cnt'] as Map<String, dynamic>),
    maxUnreadCountOnSuperGroup: json['max_unread_count_on_super_group'] as int,
    requireAuth: json['require_auth'] as bool,
    errorCode: json['code'] as int,
    errorMessage: json['message'] as String,
    reconnectConfiguration: json['reconnect'] == null
        ? null
        : ReconnectConfiguration.fromJson(
            json['reconnect'] as Map<String, dynamic>),
    mentionType: _$enumDecodeNullable(
        _$MentionTypeEnumMap, json['mention_type'],
        unknownValue: MentionType.users),
    mentionedUsers: (json['mentioned_users'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    oldValues: json['old_values'] as Map<String, dynamic>,
    messageOffset: json['ts_message_offset'] as int,
    participantCount: json['participant_count'] as int,
  );
}

Map<String, dynamic> _$CommandToJson(Command instance) => <String, dynamic>{
      'cmd': instance.cmd,
      'req_id': instance.requestId,
      'msg_id': instance.messageId,
      'ts': instance.timestamp,
      'force_update_last_message': instance.forceUpdateLastMessage,
      'silent': instance.silent,
      'channel_url': instance.channelUrl,
      'channel_type': _$ChannelTypeEnumMap[instance.channelType],
      'mention_type': _$MentionTypeEnumMap[instance.mentionType],
      'mentioned_users': instance.mentionedUsers,
      'thumbnails': instance.thumbnails,
      'login_ts': instance.loginTimestamp,
      'new_key': instance.newKey,
      'key': instance.key,
      'ekey': instance.ekey,
      'expires_in': instance.expiresIn,
      'user': instance.sender,
      'unread_cnt': instance.unreadCountInfo,
      'max_unread_count_on_super_group': instance.maxUnreadCountOnSuperGroup,
      'require_auth': instance.requireAuth,
      'code': instance.errorCode,
      'message': instance.errorMessage,
      'reconnect': instance.reconnectConfiguration,
      'ping_interval': instance.pingInterval,
      'pong_timeout': instance.watchdogInterval,
      'old_values': instance.oldValues,
      'ts_message_offset': instance.messageOffset,
      'participant_count': instance.participantCount,
    };

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
