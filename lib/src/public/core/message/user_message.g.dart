// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMessage _$UserMessageFromJson(Map<String, dynamic> json) => UserMessage(
      channelUrl: json['channelUrl'] as String,
      channelType: $enumDecodeNullable(
              _$ChannelTypeEnumMap, json['channelType'],
              unknownValue: ChannelType.group) ??
          ChannelType.group,
      messageId: json['messageId'] as int? ?? 0,
      message: json['message'] as String,
      translations: (json['translations'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          {},
      sender: json['user'] == null
          ? null
          : Sender.fromJson(json['user'] as Map<String, dynamic>),
      sendingStatus:
          $enumDecodeNullable(_$SendingStatusEnumMap, json['sendingStatus']),
      requestId: json['requestId'] as String?,
      mentionedUsers: (json['mentionedUsers'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      mentionType: $enumDecodeNullable(
              _$MentionTypeEnumMap, json['mentionType'],
              unknownValue: MentionType.users) ??
          MentionType.users,
      createdAt: json['createdAt'] as int? ?? 0,
      updatedAt: json['updatedAt'] as int? ?? 0,
      mentionedMessageTemplate: json['mentioned_message_template'] as String?,
      parentMessageId: json['parentMessageId'] as int?,
      threadInfo: json['threadInfo'] == null
          ? null
          : ThreadInfo.fromJson(json['threadInfo'] as Map<String, dynamic>),
      customType: json['customType'] as String?,
      messageSurvivalSeconds: json['messageSurvivalSeconds'] as int? ?? -1,
      forceUpdateLastMessage: json['forceUpdateLastMessage'] as bool? ?? false,
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
          (json['translationTargetLanguages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    )
      ..allMetaArrays = (json['sorted_metaarray'] as List<dynamic>?)
          ?.map((e) => MessageMetaArray.fromJson(e as Map<String, dynamic>))
          .toList()
      ..extendedMessage =
          json['extended_message'] as Map<String, dynamic>? ?? {}
      ..isReplyToChannel = json['is_reply_to_channel'] as bool? ?? false
      ..errorCode = json['errorCode'] as int?;

Map<String, dynamic> _$UserMessageToJson(UserMessage instance) =>
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
      'messageId': instance.messageId,
      'requestId': instance.requestId,
      'message': instance.message,
      'sendingStatus': _$SendingStatusEnumMap[instance.sendingStatus],
      'is_reply_to_channel': instance.isReplyToChannel,
      'parentMessageId': instance.parentMessageId,
      'parent_message_info': instance.parentMessage,
      'threadInfo': instance.threadInfo,
      'messageSurvivalSeconds': instance.messageSurvivalSeconds,
      'silent': instance.isSilent,
      'errorCode': instance.errorCode,
      'is_op_msg': instance.isOperatorMessage,
      'og_tag': instance.ogMetaData,
      'reactions': instance.reactions,
      'forceUpdateLastMessage': instance.forceUpdateLastMessage,
      'user': instance.sender,
      'translations': instance.translations,
      'translationTargetLanguages': instance.translationTargetLanguages,
      'poll': instance.poll,
    };

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
  ChannelType.feed: 'feed',
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
