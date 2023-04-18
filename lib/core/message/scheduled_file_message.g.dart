// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_file_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledFileMessage _$ScheduledFileMessageFromJson(
        Map<String, dynamic> json) =>
    ScheduledFileMessage(
      apnsBundleId: json['apns_bundle_id'] as String?,
      dedupId: json['dedup_id'] as String?,
      appleCriticalAlertOptions: json['apple_critical_alert_options'] == null
          ? null
          : AppleCriticalAlertOptions.fromJson(
              json['apple_critical_alert_options'] as Map<String, dynamic>),
      thumbnails: (json['thumbnails'] as List<dynamic>?)
          ?.map((e) => Thumbnail.fromJson(e as Map<String, dynamic>))
          .toList(),
      file: FileInfo.fromJson(json['file'] as Map<String, dynamic>),
      scheduledMessageId: json['scheduled_message_id'] as int,
      scheduledStatus: $enumDecode(
          _$ScheduledUserMessageStatusEnumMap, json['scheduled_status']),
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']),
      scheduledAt: json['scheduled_at'] as int,
      markAsRead: json['mark_as_read'] as bool?,
      channelType: $enumDecodeNullable(
              _$ChannelTypeEnumMap, json['channel_type'],
              unknownValue: ChannelType.group) ??
          ChannelType.group,
      sendPush: json['send_push'] as bool? ?? true,
      scheduledInfo: json['scheduled_info'] == null
          ? null
          : ScheduledInfo.fromJson(
              json['scheduled_info'] as Map<String, dynamic>),
      message: json['message'] as String?,
      senderId: json['sender_id'] as String?,
      channelUrl: json['channel_url'] as String,
      mentionedUsers: (json['mentioned_users'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      mentionType:
          $enumDecodeNullable(_$MentionTypeEnumMap, json['mention_type']),
      createdAt: json['created_at'] as int? ?? 0,
      sentAt: json['sent_at'] as int? ?? 0,
      metaArrays: (json['sorted_metaarray'] as List<dynamic>?)
          ?.map((e) => MessageMetaArray.fromJson(e as Map<String, dynamic>))
          .toList(),
      customType: json['custom_type'] as String?,
      isSilent: json['silent'] as bool? ?? false,
      data: BaseMessage.fromJsonToStringData(json['data']),
      sendingStatus: $enumDecodeNullable(
          _$MessageSendingStatusEnumMap, json['sending_status']),
      isPinnedMessage: json['is_pinned_message'] as bool? ?? false,
    )
      ..sender = json['user'] == null
          ? null
          : Sender.fromJson(json['user'] as Map<String, dynamic>)
      ..replyToChannel = json['is_reply_to_channel'] as bool? ?? false
      ..parentMessage = json['parent_message_info'] == null
          ? null
          : BaseMessage.fromJson(
              json['parent_message_info'] as Map<String, dynamic>)
      ..threadInfo = json['thread_info'] == null
          ? null
          : ThreadInfo.fromJson(json['thread_info'] as Map<String, dynamic>)
      ..errorCode = json['error_code'] as int?
      ..reactions = (json['reactions'] as List<dynamic>?)
              ?.map((e) => Reaction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          []
      ..extendedMessage =
          json['extended_message'] as Map<String, dynamic>? ?? {}
      ..requireAuth = json['require_auth'] as bool?;

Map<String, dynamic> _$ScheduledFileMessageToJson(
        ScheduledFileMessage instance) =>
    <String, dynamic>{
      'is_pinned_message': instance.isPinnedMessage,
      'message': instance.message,
      'sending_status': _$MessageSendingStatusEnumMap[instance.sendingStatus],
      'user': instance.sender?.toJson(),
      'channel_url': instance.channelUrl,
      'channel_type': _$ChannelTypeEnumMap[instance.channelType]!,
      'mentioned_users':
          instance.mentionedUsers.map((e) => e.toJson()).toList(),
      'mention_type': _$MentionTypeEnumMap[instance.mentionType],
      'created_at': instance.createdAt,
      'is_reply_to_channel': instance.replyToChannel,
      'parent_message_info': instance.parentMessage?.toJson(),
      'thread_info': instance.threadInfo?.toJson(),
      'sorted_metaarray': instance.metaArrays?.map((e) => e.toJson()).toList(),
      'custom_type': instance.customType,
      'silent': instance.isSilent,
      'error_code': instance.errorCode,
      'data': instance.data,
      'reactions': instance.reactions?.map((e) => e.toJson()).toList(),
      'scheduled_info': instance.scheduledInfo?.toJson(),
      'extended_message': instance.extendedMessage,
      'scheduled_message_id': instance.scheduledMessageId,
      'type': _$MessageTypeEnumMap[instance.type],
      'file': instance.file.toJson(),
      'sender_id': instance.senderId,
      'scheduled_status':
          _$ScheduledUserMessageStatusEnumMap[instance.scheduledStatus]!,
      'scheduled_at': instance.scheduledAt,
      'sent_at': instance.sentAt,
      'thumbnails': instance.thumbnails?.map((e) => e.toJson()).toList(),
      'require_auth': instance.requireAuth,
      'send_push': instance.sendPush,
      'mark_as_read': instance.markAsRead,
      'dedup_id': instance.dedupId,
      'apns_bundle_id': instance.apnsBundleId,
      'apple_critical_alert_options':
          instance.appleCriticalAlertOptions?.toJson(),
    };

const _$ScheduledUserMessageStatusEnumMap = {
  ScheduledUserMessageStatus.scheduled: 'scheduled',
  ScheduledUserMessageStatus.sent: 'sent',
  ScheduledUserMessageStatus.canceled: 'canceled',
  ScheduledUserMessageStatus.failed: 'failed',
  ScheduledUserMessageStatus.pending: 'pending',
};

const _$MessageTypeEnumMap = {
  MessageType.all: null,
  MessageType.user: 'MESG',
  MessageType.file: 'FILE',
  MessageType.admin: 'ADMN',
};

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
};

const _$MentionTypeEnumMap = {
  MentionType.users: 'users',
  MentionType.channel: 'channel',
};

const _$MessageSendingStatusEnumMap = {
  MessageSendingStatus.none: 'none',
  MessageSendingStatus.pending: 'pending',
  MessageSendingStatus.failed: 'failed',
  MessageSendingStatus.succeeded: 'succeeded',
  MessageSendingStatus.canceled: 'canceled',
};
