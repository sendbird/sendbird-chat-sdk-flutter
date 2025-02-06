// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationMessage _$NotificationMessageFromJson(Map<String, dynamic> json) =>
    NotificationMessage(
      channelUrl: json['channelUrl'] as String,
      channelType: $enumDecodeNullable(
              _$ChannelTypeEnumMap, json['channelType'],
              unknownValue: ChannelType.group) ??
          ChannelType.group,
      notificationId: json['notification_message_id'] as String,
      messageStatus: json['message_status'] == null
          ? NotificationMessageStatus.sent
          : NotificationMessage._messageStatusValueOf(
              json['message_status'] as String),
      data: TypeChecker.fromJsonToNullableString(json['data']),
      customType: json['customType'] as String?,
      mentionType: $enumDecodeNullable(
              _$MentionTypeEnumMap, json['mentionType'],
              unknownValue: MentionType.users) ??
          MentionType.users,
      mentionedUsers: (json['mentionedUsers'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <User>[],
      allMetaArrays: (json['sorted_metaarray'] as List<dynamic>?)
          ?.map((e) => MessageMetaArray.fromJson(e as Map<String, dynamic>))
          .toList(),
      extendedMessage: json['extended_message'] as Map<String, dynamic>? ?? {},
      createdAt: json['createdAt'] as int? ?? 0,
      updatedAt: json['updatedAt'] as int? ?? 0,
    )..mentionedMessageTemplate = json['mentioned_message_template'] as String?;

Map<String, dynamic> _$NotificationMessageToJson(
        NotificationMessage instance) =>
    <String, dynamic>{
      'channelUrl': instance.channelUrl,
      'channelType': _$ChannelTypeEnumMap[instance.channelType]!,
      'data': instance.data,
      'customType': instance.customType,
      'mentionType': _$MentionTypeEnumMap[instance.mentionType]!,
      'mentionedUsers': instance.mentionedUsers,
      'sorted_metaarray': instance.allMetaArrays,
      'extended_message': instance.extendedMessage,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'mentioned_message_template': instance.mentionedMessageTemplate,
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
