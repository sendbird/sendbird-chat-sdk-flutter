// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminMessage _$AdminMessageFromJson(Map<String, dynamic> json) => AdminMessage(
      messageId: json['message_id'] as int? ?? 0,
      message: json['message'] as String,
      channelUrl: json['channel_url'] as String,
      channelType: $enumDecodeNullable(
              _$ChannelTypeEnumMap, json['channel_type'],
              unknownValue: ChannelType.group) ??
          ChannelType.group,
      sendingStatus: $enumDecodeNullable(
          _$MessageSendingStatusEnumMap, json['sending_status']),
      requestId: json['request_id'] as String?,
      mentionedUsers: (json['mentioned_users'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      mentionedUserIds: (json['mentioned_user_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      mentionType:
          $enumDecodeNullable(_$MentionTypeEnumMap, json['mention_type']),
      requestedMentionUserIds:
          (json['requested_mention_user_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      createdAt: json['created_at'] as int? ?? 0,
      updatedAt: json['updated_at'] as int? ?? 0,
      parentMessageId: json['parent_message_id'] as int?,
      parentMessageText: json['parent_message_text'] as String?,
      parentMessage: json['parent_message_info'] as Map<String, dynamic>?,
      threadInfo: json['thread_info'] == null
          ? null
          : ThreadInfo.fromJson(json['thread_info'] as Map<String, dynamic>),
      metaArrays: (json['sorted_metaarray'] as List<dynamic>?)
          ?.map((e) => MessageMetaArray.fromJson(e as Map<String, dynamic>))
          .toList(),
      customType: json['custom_type'] as String?,
      messageSurvivalSeconds: json['message_survival_seconds'] as int? ?? -1,
      forceUpdateLastMessage:
          json['force_update_last_message'] as bool? ?? false,
      isSilent: json['silent'] as bool? ?? false,
      errorCode: json['error_code'] as int?,
      isOperatorMessage: json['is_op_msg'] as bool? ?? false,
      data: BaseMessage.fromJsonToStringData(json['data']),
      ogMetaData: json['og_tag'] == null
          ? null
          : OGMetaData.fromJson(json['og_tag'] as Map<String, dynamic>),
      reactions: (json['reactions'] as List<dynamic>?)
              ?.map((e) => Reaction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      replyToChannel: json['is_reply_to_channel'] as bool? ?? false,
      extendedMessage: json['extended_message'] as Map<String, dynamic>? ?? {},
      isPinnedMessage: json['is_pinned_message'] as bool? ?? false,
    )
      ..sender = json['user'] == null
          ? null
          : Sender.fromJson(json['user'] as Map<String, dynamic>)
      ..scheduledInfo = json['scheduled_info'] == null
          ? null
          : ScheduledInfo.fromJson(
              json['scheduled_info'] as Map<String, dynamic>);

Map<String, dynamic> _$AdminMessageToJson(AdminMessage instance) =>
    <String, dynamic>{
      'is_pinned_message': instance.isPinnedMessage,
      'request_id': instance.requestId,
      'message_id': instance.messageId,
      'message': instance.message,
      'sending_status': _$MessageSendingStatusEnumMap[instance.sendingStatus],
      'user': instance.sender?.toJson(),
      'channel_url': instance.channelUrl,
      'channel_type': _$ChannelTypeEnumMap[instance.channelType]!,
      'mentioned_users':
          instance.mentionedUsers.map((e) => e.toJson()).toList(),
      'mention_type': _$MentionTypeEnumMap[instance.mentionType],
      'mentioned_user_ids': instance.mentionedUserIds,
      'requested_mention_user_ids': instance.requestedMentionUserIds,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'is_reply_to_channel': instance.replyToChannel,
      'parent_message_id': instance.parentMessageId,
      'parent_message_text': instance.parentMessageText,
      'parent_message_info': instance.parentMessage?.toJson(),
      'thread_info': instance.threadInfo?.toJson(),
      'sorted_metaarray': instance.metaArrays?.map((e) => e.toJson()).toList(),
      'custom_type': instance.customType,
      'message_survival_seconds': instance.messageSurvivalSeconds,
      'force_update_last_message': instance.forceUpdateLastMessage,
      'silent': instance.isSilent,
      'error_code': instance.errorCode,
      'is_op_msg': instance.isOperatorMessage,
      'data': instance.data,
      'og_tag': instance.ogMetaData?.toJson(),
      'reactions': instance.reactions?.map((e) => e.toJson()).toList(),
      'scheduled_info': instance.scheduledInfo?.toJson(),
      'extended_message': instance.extendedMessage,
    };

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
};

const _$MessageSendingStatusEnumMap = {
  MessageSendingStatus.none: 'none',
  MessageSendingStatus.pending: 'pending',
  MessageSendingStatus.failed: 'failed',
  MessageSendingStatus.succeeded: 'succeeded',
  MessageSendingStatus.canceled: 'canceled',
};

const _$MentionTypeEnumMap = {
  MentionType.users: 'users',
  MentionType.channel: 'channel',
};
