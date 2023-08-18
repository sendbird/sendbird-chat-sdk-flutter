// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileMessage _$FileMessageFromJson(Map<String, dynamic> json) => FileMessage(
      url: json['url'] as String,
      name: json['name'] as String?,
      size: json['size'] as int? ?? 0,
      type: json['type'] as String?,
      thumbnails: (json['thumbnails'] as List<dynamic>?)
          ?.map((e) => Thumbnail.fromJson(e as Map<String, dynamic>))
          .toList(),
      requireAuth: json['requireAuth'] as bool? ?? false,
      requestId: json['requestId'] as String?,
      message: json['message'] as String?,
      messageId: json['messageId'] as int? ?? 0,
      sendingStatus:
          $enumDecodeNullable(_$SendingStatusEnumMap, json['sendingStatus']),
      sender: json['user'] == null
          ? null
          : Sender.fromJson(json['user'] as Map<String, dynamic>),
      channelUrl: json['channelUrl'] as String,
      channelType: $enumDecodeNullable(
              _$ChannelTypeEnumMap, json['channelType'],
              unknownValue: ChannelType.group) ??
          ChannelType.group,
      mentionedUsers: (json['mentionedUsers'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      mentionType:
          $enumDecodeNullable(_$MentionTypeEnumMap, json['mentionType']),
      createdAt: json['createdAt'] as int? ?? 0,
      updatedAt: json['updatedAt'] as int? ?? 0,
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
    )
      ..isReplyToChannel = json['is_reply_to_channel'] as bool? ?? false
      ..allMetaArrays = (json['sorted_metaarray'] as List<dynamic>?)
          ?.map((e) => MessageMetaArray.fromJson(e as Map<String, dynamic>))
          .toList()
      ..errorCode = json['errorCode'] as int?
      ..extendedMessage =
          json['extended_message'] as Map<String, dynamic>? ?? {};

const _$SendingStatusEnumMap = {
  SendingStatus.none: 'none',
  SendingStatus.pending: 'pending',
  SendingStatus.failed: 'failed',
  SendingStatus.succeeded: 'succeeded',
  SendingStatus.canceled: 'canceled',
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

Thumbnail _$ThumbnailFromJson(Map<String, dynamic> json) => Thumbnail(
      json['url'] as String,
      json['plainUrl'] as String?,
      (json['height'] as num?)?.toDouble(),
      (json['width'] as num?)?.toDouble(),
      (json['realHeight'] as num?)?.toDouble(),
      (json['realWidth'] as num?)?.toDouble(),
    );
