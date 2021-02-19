// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_info_update_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThreadInfoUpdateEvent _$ThreadInfoUpdateEventFromJson(
    Map<String, dynamic> json) {
  return ThreadInfoUpdateEvent(
    threadInfo: json['thread_info'] == null
        ? null
        : ThreadInfo.fromJson(json['thread_info'] as Map<String, dynamic>),
    rootMessageId: json['root_message_id'] as int,
    channelType:
        _$enumDecodeNullable(_$ChannelTypeEnumMap, json['channel_type']),
    channelUrl: json['channel_url'] as String,
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
