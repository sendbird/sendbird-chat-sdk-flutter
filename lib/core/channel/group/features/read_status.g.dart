// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadStatus _$ReadStatusFromJson(Map<String, dynamic> json) {
  return ReadStatus(
    userId: userToUserId(json['user'] as Map<String, dynamic>),
    timestamp: json['ts'] as int,
    channelUrl: json['channel_url'] as String,
    channelType:
        _$enumDecodeNullable(_$ChannelTypeEnumMap, json['channel_type']),
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
