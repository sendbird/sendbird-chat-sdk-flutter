// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operator_list_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperatorListQuery _$OperatorListQueryFromJson(Map<String, dynamic> json) {
  return OperatorListQuery(
    channelType:
        _$enumDecodeNullable(_$ChannelTypeEnumMap, json['channel_type']),
    channelUrl: json['channel_url'] as String,
  )
    ..loading = json['loading'] as bool
    ..hasNext = json['has_next'] as bool
    ..token = json['token'] as String
    ..limit = json['limit'] as int;
}

Map<String, dynamic> _$OperatorListQueryToJson(OperatorListQuery instance) =>
    <String, dynamic>{
      'loading': instance.loading,
      'has_next': instance.hasNext,
      'token': instance.token,
      'limit': instance.limit,
      'channel_type': _$ChannelTypeEnumMap[instance.channelType],
      'channel_url': instance.channelUrl,
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
