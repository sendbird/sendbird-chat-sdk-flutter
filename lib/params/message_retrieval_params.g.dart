// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_retrieval_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageRetrievalParams _$MessageRetrievalParamsFromJson(
        Map<String, dynamic> json) =>
    MessageRetrievalParams(
      channelType: $enumDecode(_$ChannelTypeEnumMap, json['channel_type']),
      channelUrl: json['channel_url'] as String,
      messageId: json['message_id'] as int,
    )
      ..replyType =
          $enumDecodeNullable(_$ReplyTypeEnumMap, json['include_reply_type'])
      ..includeReactions = json['include_reactions'] as bool
      ..includeMetaArray = json['with_sorted_meta_array'] as bool
      ..includeParentMessageText = json['include_parent_message_text'] as bool?
      ..includeThreadInfo = json['include_thread_info'] as bool
      ..includeReplies = json['include_replies'] as bool?
      ..includeParentMessageInfo = json['include_parent_message_info'] as bool
      ..replyToChannel = json['reply_to_channel'] as bool;

Map<String, dynamic> _$MessageRetrievalParamsToJson(
        MessageRetrievalParams instance) =>
    <String, dynamic>{
      'include_reply_type': _$ReplyTypeEnumMap[instance.replyType],
      'channel_url': instance.channelUrl,
      'channel_type': _$ChannelTypeEnumMap[instance.channelType]!,
      'message_id': instance.messageId,
      'include_reactions': instance.includeReactions,
      'with_sorted_meta_array': instance.includeMetaArray,
      'include_parent_message_text': instance.includeParentMessageText,
      'include_thread_info': instance.includeThreadInfo,
      'include_replies': instance.includeReplies,
      'include_parent_message_info': instance.includeParentMessageInfo,
      'reply_to_channel': instance.replyToChannel,
    };

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
};

const _$ReplyTypeEnumMap = {
  ReplyType.none: 'NONE',
  ReplyType.all: 'ALL',
  ReplyType.only_reply_to_channel: 'ONLY_REPLY_TO_CHANNEL',
};
