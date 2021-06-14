// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadStatus _$ReadStatusFromJson(Map<String, dynamic> json) {
  return ReadStatus(
    userId: userToUserId(json['user'] as Map<String, dynamic>),
    timestamp: json['ts'] as int? ?? 0,
    channelUrl: json['channel_url'] as String,
    channelType: _$enumDecode(_$ChannelTypeEnumMap, json['channel_type']),
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
