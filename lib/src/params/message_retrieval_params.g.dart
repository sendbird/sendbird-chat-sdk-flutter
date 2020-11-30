// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_retrieval_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageRetrievalParams _$MessageRetrievalParamsFromJson(
    Map<String, dynamic> json) {
  return MessageRetrievalParams()
    ..channelUrl = json['channel_url'] as String
    ..channelType =
        _$enumDecodeNullable(_$ChannelTypeEnumMap, json['channel_type'])
    ..messageId = json['message_id'] as int
    ..includeMetaArray = json['with_sorted_meta_array'] as bool
    ..includeParentMessageText = json['include_parent_message_text'] as bool
    ..includeThreadInfo = json['include_thread_info'] as bool;
}

Map<String, dynamic> _$MessageRetrievalParamsToJson(
        MessageRetrievalParams instance) =>
    <String, dynamic>{
      'channel_url': instance.channelUrl,
      'channel_type': _$ChannelTypeEnumMap[instance.channelType],
      'message_id': instance.messageId,
      'with_sorted_meta_array': instance.includeMetaArray,
      'include_parent_message_text': instance.includeParentMessageText,
      'include_thread_info': instance.includeThreadInfo,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ChannelTypeEnumMap = {
  ChannelType.group: 'group',
  ChannelType.open: 'open',
};
