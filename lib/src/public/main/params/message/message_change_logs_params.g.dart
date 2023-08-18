// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_change_logs_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageChangeLogParams _$MessageChangeLogParamsFromJson(
        Map<String, dynamic> json) =>
    MessageChangeLogParams()
      ..includeMetaArray = json['with_sorted_meta_array'] as bool
      ..includeReactions = json['includeReactions'] as bool
      ..includeThreadInfo = json['includeThreadInfo'] as bool
      ..includeParentMessageInfo = json['includeParentMessageInfo'] as bool
      ..replyType =
          $enumDecodeNullable(_$ReplyTypeEnumMap, json['include_reply_type']);

Map<String, dynamic> _$MessageChangeLogParamsToJson(
        MessageChangeLogParams instance) =>
    <String, dynamic>{
      'with_sorted_meta_array': instance.includeMetaArray,
      'includeReactions': instance.includeReactions,
      'includeThreadInfo': instance.includeThreadInfo,
      'includeParentMessageInfo': instance.includeParentMessageInfo,
      'include_reply_type': _$ReplyTypeEnumMap[instance.replyType],
    };

const _$ReplyTypeEnumMap = {
  ReplyType.none: 'none',
  ReplyType.all: 'all',
  ReplyType.onlyReplyToChannel: 'only_reply_to_channel',
};
