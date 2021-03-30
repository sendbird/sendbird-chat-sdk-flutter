// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_user_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledUserMessage _$ScheduledUserMessageFromJson(Map<String, dynamic> json) {
  return ScheduledUserMessage(
    scheduledId: json['scheduled_id'] as int,
    scheduledDateTimeString: json['scheduled_dt'] as String,
    scheduledTimezone: json['scheduled_timezone'] as String,
    status: _$enumDecodeNullable(
        _$ScheduledUserMessageStatusEnumMap, json['status']),
    pushOption: _$enumDecodeNullable(
        _$PushNotificationDeliveryOptionEnumMap, json['push_option'],
        unknownValue: PushNotificationDeliveryOption.normal),
    error: json['error'] == null
        ? null
        : SBError.fromJson(json['error'] as Map<String, dynamic>),
    targetLanguages: (json['translation_target_langs'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    requestId: json['request_id'] as String,
    messageId: json['message_id'] as int,
    message: json['message'] as String,
    sendingStatus: _$enumDecodeNullable(
        _$MessageSendingStatusEnumMap, json['sending_status']),
    sender: json['user'] == null
        ? null
        : Sender.fromJson(json['user'] as Map<String, dynamic>),
    channelUrl: json['channel_url'] as String,
    channelType:
        _$enumDecodeNullable(_$ChannelTypeEnumMap, json['channel_type']),
    mentionedUsers: (json['mentioned_users'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    mentionType:
        _$enumDecodeNullable(_$MentionTypeEnumMap, json['mention_type']),
    requestedMentionUserIds: (json['requested_mention_user_ids'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    createdAt: json['created_at'] as int,
    updatedAt: json['updated_at'] as int ?? 0,
    parentMessageId: json['parent_message_id'] as int,
    parentMessageText: json['parent_message_text'] as String,
    threadInfo: json['thread_info'] == null
        ? null
        : ThreadInfo.fromJson(json['thread_info'] as Map<String, dynamic>),
    metaArrays: (json['sorted_metaarray'] as List)
        ?.map((e) => e == null
            ? null
            : MessageMetaArray.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    customType: json['custom_type'] as String,
    messageSurvivalSeconds: json['message_survival_seconds'] as int ?? -1,
    forceUpdateLastMessage: json['force_update_last_message'] as bool ?? false,
    isSilent: json['silent'] as bool ?? false,
    errorCode: json['error_code'] as int,
    isOperatorMessage: json['is_op_msg'] as bool ?? false,
    data: json['data'] as String,
    ogMetaData: json['og_tag'] == null
        ? null
        : OGMetaData.fromJson(json['og_tag'] as Map<String, dynamic>),
  )..reactions = (json['reactions'] as List)
          ?.map((e) =>
              e == null ? null : Reaction.fromJson(e as Map<String, dynamic>))
          ?.toList() ??
      [];
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

const _$ScheduledUserMessageStatusEnumMap = {
  ScheduledUserMessageStatus.scheduled: 'scheduled',
  ScheduledUserMessageStatus.sent: 'sent',
  ScheduledUserMessageStatus.canceled: 'canceled',
  ScheduledUserMessageStatus.failed: 'failed',
};

const _$PushNotificationDeliveryOptionEnumMap = {
  PushNotificationDeliveryOption.normal: 'normal',
  PushNotificationDeliveryOption.suppress: 'suppress',
};

const _$MessageSendingStatusEnumMap = {
  MessageSendingStatus.none: 'none',
  MessageSendingStatus.pending: 'pending',
  MessageSendingStatus.failed: 'failed',
  MessageSendingStatus.succeeded: 'succeeded',
  MessageSendingStatus.canceled: 'canceled',
};

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
};

const _$MentionTypeEnumMap = {
  MentionType.users: 'users',
  MentionType.channel: 'channel',
};
