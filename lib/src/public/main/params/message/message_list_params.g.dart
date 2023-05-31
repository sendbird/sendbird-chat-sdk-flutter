// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_list_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageListParams _$MessageListParamsFromJson(Map<String, dynamic> json) =>
    MessageListParams()
      ..includeMetaArray = json['with_sorted_meta_array'] as bool
      ..includeReactions = json['include_reactions'] as bool
      ..includeThreadInfo = json['include_thread_info'] as bool
      ..includeParentMessageInfo = json['include_parent_message_info'] as bool
      ..replyType =
          $enumDecodeNullable(_$ReplyTypeEnumMap, json['include_reply_type'])
      ..previousResultSize = json['prev_limit'] as int
      ..nextResultSize = json['next_limit'] as int
      ..inclusive = json['include'] as bool
      ..reverse = json['reverse'] as bool
      ..messageType =
          $enumDecode(_$MessageTypeFilterEnumMap, json['message_type'])
      ..customTypes = (json['custom_types'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..senderIds = (json['sender_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..showSubChannelMessagesOnly =
          json['show_subchannel_messages_only'] as bool;

Map<String, dynamic> _$MessageListParamsToJson(MessageListParams instance) =>
    <String, dynamic>{
      'with_sorted_meta_array': instance.includeMetaArray,
      'include_reactions': instance.includeReactions,
      'include_thread_info': instance.includeThreadInfo,
      'include_parent_message_info': instance.includeParentMessageInfo,
      'include_reply_type': _$ReplyTypeEnumMap[instance.replyType],
      'prev_limit': instance.previousResultSize,
      'next_limit': instance.nextResultSize,
      'include': instance.inclusive,
      'reverse': instance.reverse,
      'message_type': _$MessageTypeFilterEnumMap[instance.messageType],
      'custom_types': instance.customTypes,
      'sender_ids': instance.senderIds,
      'show_subchannel_messages_only': instance.showSubChannelMessagesOnly,
    };

const _$ReplyTypeEnumMap = {
  ReplyType.none: 'none',
  ReplyType.all: 'all',
  ReplyType.onlyReplyToChannel: 'only_reply_to_channel',
};

const _$MessageTypeFilterEnumMap = {
  MessageTypeFilter.all: null,
  MessageTypeFilter.user: 'MESG',
  MessageTypeFilter.file: 'FILE',
  MessageTypeFilter.admin: 'ADMN',
};
