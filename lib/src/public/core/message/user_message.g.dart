// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMessage _$UserMessageFromJson(Map<String, dynamic> json) => UserMessage(
      translations: (json['translations'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          {},
      messageId: json['message_id'] as int? ?? 0,
      message: json['message'] as String,
      channelUrl: json['channel_url'] as String,
      channelType: $enumDecodeNullable(
              _$ChannelTypeEnumMap, json['channel_type'],
              unknownValue: ChannelType.group) ??
          ChannelType.group,
      sender: json['user'] == null
          ? null
          : Sender.fromJson(json['user'] as Map<String, dynamic>),
      sendingStatus:
          $enumDecodeNullable(_$SendingStatusEnumMap, json['sending_status']),
      requestId: json['request_id'] as String?,
      mentionedUsers: (json['mentioned_users'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      mentionType:
          $enumDecodeNullable(_$MentionTypeEnumMap, json['mention_type']),
      createdAt: json['created_at'] as int? ?? 0,
      updatedAt: json['updated_at'] as int? ?? 0,
      parentMessageId: json['parent_message_id'] as int?,
      threadInfo: json['thread_info'] == null
          ? null
          : ThreadInfo.fromJson(json['thread_info'] as Map<String, dynamic>),
      customType: json['custom_type'] as String?,
      messageSurvivalSeconds: json['message_survival_seconds'] as int? ?? -1,
      forceUpdateLastMessage:
          json['force_update_last_message'] as bool? ?? false,
      isSilent: json['silent'] as bool? ?? false,
      isOperatorMessage: json['is_op_msg'] as bool? ?? false,
      data: TypeChecker.fromJsonToNullableString(json['data']),
      ogMetaData: json['og_tag'] == null
          ? null
          : OGMetaData.fromJson(json['og_tag'] as Map<String, dynamic>),
      reactions: (json['reactions'] as List<dynamic>?)
              ?.map((e) => Reaction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      parentMessage: json['parent_message_info'] as Map<String, dynamic>?,
      poll: json['poll'] == null
          ? null
          : Poll.fromJson(json['poll'] as Map<String, dynamic>),
      translationTargetLanguages:
          (json['translation_target_languages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    )
      ..isReplyToChannel = json['is_reply_to_channel'] as bool? ?? false
      ..allMetaArrays = (json['sorted_metaarray'] as List<dynamic>?)
          ?.map((e) => MessageMetaArray.fromJson(e as Map<String, dynamic>))
          .toList()
      ..errorCode = json['error_code'] as int?
      ..extendedMessage =
          json['extended_message'] as Map<String, dynamic>? ?? {};

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
};

const _$SendingStatusEnumMap = {
  SendingStatus.none: 'none',
  SendingStatus.pending: 'pending',
  SendingStatus.failed: 'failed',
  SendingStatus.succeeded: 'succeeded',
  SendingStatus.canceled: 'canceled',
};

const _$MentionTypeEnumMap = {
  MentionType.users: 'users',
  MentionType.channel: 'channel',
};
