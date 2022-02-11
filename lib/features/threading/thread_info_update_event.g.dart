// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_info_update_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThreadInfoUpdateEvent _$ThreadInfoUpdateEventFromJson(
    Map<String, dynamic> json) {
  return ThreadInfoUpdateEvent(
    threadInfo:
        ThreadInfo.fromJson(json['thread_info'] as Map<String, dynamic>),
    parentMessageId: json['parent_message_id'] as int,
    channelType: _$enumDecode(_$ChannelTypeEnumMap, json['channel_type']),
    channelUrl: json['channel_url'] as String,
  );
}

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
