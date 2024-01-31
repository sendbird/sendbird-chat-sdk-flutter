// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileMessage _$FileMessageFromJson(Map<String, dynamic> json) => FileMessage(
      channelUrl: json['channel_url'] as String,
      channelType: $enumDecodeNullable(
              _$ChannelTypeEnumMap, json['channel_type'],
              unknownValue: ChannelType.group) ??
          ChannelType.group,
      messageId: json['message_id'] as int? ?? 0,
      url: json['url'] as String,
      name: json['name'] as String?,
      size: json['size'] as int? ?? 0,
      type: json['type'] as String?,
      thumbnails: (json['thumbnails'] as List<dynamic>?)
          ?.map((e) => Thumbnail.fromJson(e as Map<String, dynamic>))
          .toList(),
      requireAuth: json['require_auth'] as bool? ?? false,
      requestId: json['request_id'] as String?,
      message: json['message'] as String?,
      sendingStatus:
          $enumDecodeNullable(_$SendingStatusEnumMap, json['sending_status']),
      sender: json['user'] == null
          ? null
          : Sender.fromJson(json['user'] as Map<String, dynamic>),
      mentionedUsers: (json['mentioned_users'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      mentionType: $enumDecodeNullable(
              _$MentionTypeEnumMap, json['mention_type'],
              unknownValue: MentionType.users) ??
          MentionType.users,
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
    )
      ..allMetaArrays = (json['sorted_metaarray'] as List<dynamic>?)
          ?.map((e) => MessageMetaArray.fromJson(e as Map<String, dynamic>))
          .toList()
      ..extendedMessage =
          json['extended_message'] as Map<String, dynamic>? ?? {}
      ..isReplyToChannel = json['is_reply_to_channel'] as bool? ?? false
      ..errorCode = json['error_code'] as int?;

Map<String, dynamic> _$FileMessageToJson(FileMessage instance) =>
    <String, dynamic>{
      'channel_url': instance.channelUrl,
      'channel_type': _$ChannelTypeEnumMap[instance.channelType]!,
      'data': instance.data,
      'custom_type': instance.customType,
      'mention_type': _$MentionTypeEnumMap[instance.mentionType]!,
      'mentioned_users':
          instance.mentionedUsers.map((e) => e.toJson()).toList(),
      'sorted_metaarray':
          instance.allMetaArrays?.map((e) => e.toJson()).toList(),
      'extended_message': instance.extendedMessage,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'message_id': instance.messageId,
      'request_id': instance.requestId,
      'message': instance.message,
      'sending_status': _$SendingStatusEnumMap[instance.sendingStatus],
      'is_reply_to_channel': instance.isReplyToChannel,
      'parent_message_id': instance.parentMessageId,
      'parent_message_info': instance.parentMessage?.toJson(),
      'thread_info': instance.threadInfo?.toJson(),
      'message_survival_seconds': instance.messageSurvivalSeconds,
      'silent': instance.isSilent,
      'error_code': instance.errorCode,
      'is_op_msg': instance.isOperatorMessage,
      'og_tag': instance.ogMetaData?.toJson(),
      'reactions': instance.reactions?.map((e) => e.toJson()).toList(),
      'force_update_last_message': instance.forceUpdateLastMessage,
      'user': instance.sender?.toJson(),
      'url': instance.url,
      'name': instance.name,
      'size': instance.size,
      'type': instance.type,
      'thumbnails': instance.thumbnails?.map((e) => e.toJson()).toList(),
      'require_auth': instance.requireAuth,
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

Thumbnail _$ThumbnailFromJson(Map<String, dynamic> json) => Thumbnail(
      json['url'] as String,
      json['plain_url'] as String?,
      (json['height'] as num?)?.toDouble(),
      (json['width'] as num?)?.toDouble(),
      (json['real_height'] as num?)?.toDouble(),
      (json['real_width'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ThumbnailToJson(Thumbnail instance) => <String, dynamic>{
      'url': instance.url,
      'plain_url': instance.plainUrl,
      'height': instance.height,
      'width': instance.width,
      'real_height': instance.realHeight,
      'real_width': instance.realWidth,
    };
