// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_retrieval_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageRetrievalParams _$MessageRetrievalParamsFromJson(
        Map<String, dynamic> json) =>
    MessageRetrievalParams(
      channelType: $enumDecode(_$ChannelTypeEnumMap, json['channelType']),
      channelUrl: json['channelUrl'] as String,
      messageId: json['messageId'] as int,
    )
      ..includeMetaArray = json['with_sorted_meta_array'] as bool
      ..includeReactions = json['includeReactions'] as bool
      ..includeThreadInfo = json['includeThreadInfo'] as bool
      ..includeParentMessageInfo = json['includeParentMessageInfo'] as bool
      ..replyType =
          $enumDecodeNullable(_$ReplyTypeEnumMap, json['include_reply_type']);

Map<String, dynamic> _$MessageRetrievalParamsToJson(
        MessageRetrievalParams instance) =>
    <String, dynamic>{
      'with_sorted_meta_array': instance.includeMetaArray,
      'includeReactions': instance.includeReactions,
      'includeThreadInfo': instance.includeThreadInfo,
      'includeParentMessageInfo': instance.includeParentMessageInfo,
      'include_reply_type': _$ReplyTypeEnumMap[instance.replyType],
      'channelType': _$ChannelTypeEnumMap[instance.channelType]!,
      'channelUrl': instance.channelUrl,
      'messageId': instance.messageId,
    };

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
  ChannelType.feed: 'feed',
};

const _$ReplyTypeEnumMap = {
  ReplyType.none: 'none',
  ReplyType.all: 'all',
  ReplyType.onlyReplyToChannel: 'only_reply_to_channel',
};
