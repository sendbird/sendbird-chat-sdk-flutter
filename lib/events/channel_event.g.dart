// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelEvent _$ChannelEventFromJson(Map<String, dynamic> json) {
  return ChannelEvent(
    channelType: _$enumDecode(_$ChannelTypeEnumMap, json['channel_type']),
    channelUrl: json['channel_url'] as String,
    category: channelEventValueOf(json['cat'] as int),
    data: json['data'] as Map<String, dynamic>? ?? {},
    ts: json['ts'] as int?,
    messageOffset: json['ts_message_offset'] as int?,
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
