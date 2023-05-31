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
      ..includeMetaArray = json['with_sorted_meta_array'] as bool
      ..includeReactions = json['include_reactions'] as bool
      ..includeThreadInfo = json['include_thread_info'] as bool
      ..includeParentMessageInfo = json['include_parent_message_info'] as bool
      ..replyType =
          $enumDecodeNullable(_$ReplyTypeEnumMap, json['include_reply_type']);

Map<String, dynamic> _$MessageRetrievalParamsToJson(
        MessageRetrievalParams instance) =>
    <String, dynamic>{
      'with_sorted_meta_array': instance.includeMetaArray,
      'include_reactions': instance.includeReactions,
      'include_thread_info': instance.includeThreadInfo,
      'include_parent_message_info': instance.includeParentMessageInfo,
      'include_reply_type': _$ReplyTypeEnumMap[instance.replyType],
      'channel_type': _$ChannelTypeEnumMap[instance.channelType]!,
      'channel_url': instance.channelUrl,
      'message_id': instance.messageId,
    };

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
};

const _$ReplyTypeEnumMap = {
  ReplyType.none: 'none',
  ReplyType.all: 'all',
  ReplyType.onlyReplyToChannel: 'only_reply_to_channel',
};
