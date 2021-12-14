// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_change_logs_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageChangeLogParams _$MessageChangeLogParamsFromJson(
    Map<String, dynamic> json) {
  return MessageChangeLogParams()
    ..includeMetaArray = json['with_sorted_meta_array'] as bool
    ..includeReactions = json['include_reactions'] as bool
    ..includeParentMessageText = json['include_parent_message_text'] as bool
    ..includeReplies = json['include_replies'] as bool
    ..includeThreadInfo = json['include_thread_info'] as bool
    ..includeParentMessageInfo = json['include_parent_message_info'] as bool
    ..replyType = _$enumDecode(_$ReplyTypeEnumMap, json['include_reply_type']);
}

Map<String, dynamic> _$MessageChangeLogParamsToJson(
        MessageChangeLogParams instance) =>
    <String, dynamic>{
      'with_sorted_meta_array': instance.includeMetaArray,
      'include_reactions': instance.includeReactions,
      'include_parent_message_text': instance.includeParentMessageText,
      'include_replies': instance.includeReplies,
      'include_thread_info': instance.includeThreadInfo,
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

const _$ReplyTypeEnumMap = {
  ReplyType.none: 'NONE',
  ReplyType.all: 'ALL',
  ReplyType.only_reply_to_channel: 'ONLY_REPLY_TO_CHANNEL',
};
