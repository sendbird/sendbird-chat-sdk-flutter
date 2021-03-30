// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelEvent _$ChannelEventFromJson(Map<String, dynamic> json) {
  return ChannelEvent(
    channelType:
        _$enumDecodeNullable(_$ChannelTypeEnumMap, json['channel_type']),
    channelUrl: json['channel_url'] as String,
    category: channelEventValueOf(json['cat'] as int),
    data: json['data'] as Map<String, dynamic>,
    ts: json['ts'] as int,
    messageOffset: json['ts_message_offset'] as int,
  );
}

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
