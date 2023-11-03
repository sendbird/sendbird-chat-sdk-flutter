// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationMessage _$NotificationMessageFromJson(Map<String, dynamic> json) =>
    NotificationMessage(
      channelUrl: json['channel_url'] as String,
      channelType: $enumDecodeNullable(
              _$ChannelTypeEnumMap, json['channel_type'],
              unknownValue: ChannelType.group) ??
          ChannelType.group,
      notificationId: json['notification_message_id'] as String,
      messageStatus: json['message_status'] == null
          ? NotificationMessageStatus.sent
          : NotificationMessage._messageStatusValueOf(
              json['message_status'] as String),
      data: TypeChecker.fromJsonToNullableString(json['data']),
      customType: json['custom_type'] as String?,
      mentionType:
          $enumDecodeNullable(_$MentionTypeEnumMap, json['mention_type']),
      mentionedUsers: (json['mentioned_users'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <User>[],
      allMetaArrays: (json['sorted_metaarray'] as List<dynamic>?)
          ?.map((e) => MessageMetaArray.fromJson(e as Map<String, dynamic>))
          .toList(),
      extendedMessage: json['extended_message'] as Map<String, dynamic>? ?? {},
      createdAt: json['created_at'] as int? ?? 0,
      updatedAt: json['updated_at'] as int? ?? 0,
    );

Map<String, dynamic> _$NotificationMessageToJson(
        NotificationMessage instance) =>
    <String, dynamic>{
      'channel_url': instance.channelUrl,
      'channel_type': _$ChannelTypeEnumMap[instance.channelType]!,
      'data': instance.data,
      'custom_type': instance.customType,
      'mention_type': _$MentionTypeEnumMap[instance.mentionType],
      'mentioned_users':
          instance.mentionedUsers.map((e) => e.toJson()).toList(),
      'sorted_metaarray':
          instance.allMetaArrays?.map((e) => e.toJson()).toList(),
      'extended_message': instance.extendedMessage,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'notification_message_id': instance.notificationId,
      'message_status':
          _$NotificationMessageStatusEnumMap[instance.messageStatus]!,
    };

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
  ChannelType.feed: 'feed',
};

const _$MentionTypeEnumMap = {
  MentionType.users: 'users',
  MentionType.channel: 'channel',
};

const _$NotificationMessageStatusEnumMap = {
  NotificationMessageStatus.sent: 'sent',
  NotificationMessageStatus.read: 'read',
};
