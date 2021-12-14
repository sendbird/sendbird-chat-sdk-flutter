// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_list_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageListParams _$MessageListParamsFromJson(Map<String, dynamic> json) {
  return MessageListParams()
    ..previousResultSize = json['prev_limit'] as int
    ..nextResultSize = json['next_limit'] as int
    ..isInclusive = json['include'] as bool
    ..reverse = json['reverse'] as bool
    ..messageType =
        _$enumDecode(_$MessageTypeFilterEnumMap, json['message_type'])
    ..customType = json['custom_type'] as String?
    ..customTypes = (json['custom_types'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList()
    ..senderIds =
        (json['sender_ids'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..includeMetaArray = json['with_sorted_meta_array'] as bool
    ..includeReactions = json['include_reactions'] as bool
    ..includeParentMessageText = json['include_parent_message_text'] as bool
    ..includeReplies = json['include_replies'] as bool
    ..includeThreadInfo = json['include_thread_info'] as bool
    ..showSubChannelMessagesOnly =
        json['show_sub_channel_messages_only'] as bool
    ..includeParentMessageInfo = json['include_parent_message_info'] as bool
    ..replyType = _$enumDecode(_$ReplyTypeEnumMap, json['include_reply_type']);
}

Map<String, dynamic> _$MessageListParamsToJson(MessageListParams instance) =>
    <String, dynamic>{
      'prev_limit': instance.previousResultSize,
      'next_limit': instance.nextResultSize,
      'include': instance.isInclusive,
      'reverse': instance.reverse,
      'message_type': _$MessageTypeFilterEnumMap[instance.messageType],
      'custom_type': instance.customType,
      'custom_types': instance.customTypes,
      'sender_ids': instance.senderIds,
      'with_sorted_meta_array': instance.includeMetaArray,
      'include_reactions': instance.includeReactions,
      'include_parent_message_text': instance.includeParentMessageText,
      'include_replies': instance.includeReplies,
      'include_thread_info': instance.includeThreadInfo,
      'show_sub_channel_messages_only': instance.showSubChannelMessagesOnly,
      'include_parent_message_info': instance.includeParentMessageInfo,
      'include_reply_type': _$ReplyTypeEnumMap[instance.replyType],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$MessageTypeFilterEnumMap = {
  MessageTypeFilter.all: null,
  MessageTypeFilter.user: 'MESG',
  MessageTypeFilter.file: 'FILE',
  MessageTypeFilter.admin: 'ADMN',
};

const _$ReplyTypeEnumMap = {
  ReplyType.none: 'NONE',
  ReplyType.all: 'ALL',
  ReplyType.only_reply_to_channel: 'ONLY_REPLY_TO_CHANNEL',
};
