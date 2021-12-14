// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_retrieval_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageRetrievalParams _$MessageRetrievalParamsFromJson(
    Map<String, dynamic> json) {
  return MessageRetrievalParams(
    channelType: _$enumDecode(_$ChannelTypeEnumMap, json['channel_type']),
    channelUrl: json['channel_url'] as String,
    messageId: json['message_id'] as int,
  )
    ..includeReactions = json['include_reactions'] as bool
    ..includeMetaArray = json['with_sorted_meta_array'] as bool
    ..includeParentMessageText = json['include_parent_message_text'] as bool
    ..includeThreadInfo = json['include_thread_info'] as bool
    ..includeReplies = json['include_replies'] as bool
    ..includeParentMessageInfo = json['include_parent_message_info'] as bool
    ..replyToChannel = json['reply_to_channel'] as bool;
}

Map<String, dynamic> _$MessageRetrievalParamsToJson(
        MessageRetrievalParams instance) =>
    <String, dynamic>{
      'channel_url': instance.channelUrl,
      'channel_type': _$ChannelTypeEnumMap[instance.channelType],
      'message_id': instance.messageId,
      'include_reactions': instance.includeReactions,
      'with_sorted_meta_array': instance.includeMetaArray,
      'include_parent_message_text': instance.includeParentMessageText,
      'include_thread_info': instance.includeThreadInfo,
      'include_replies': instance.includeReplies,
      'include_parent_message_info': instance.includeParentMessageInfo,
      'reply_to_channel': instance.replyToChannel,
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

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
};
