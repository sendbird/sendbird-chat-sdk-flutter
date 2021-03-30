// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReactionEvent _$ReactionEventFromJson(Map<String, dynamic> json) {
  return ReactionEvent(
    channelType: _$enumDecodeNullable(
        _$ChannelTypeEnumMap, json['channel_type'],
        unknownValue: ChannelType.group),
    channelUrl: json['channel_url'] as String,
    messageId: json['msg_id'] as int,
    key: json['reaction'] as String,
    userId: json['user_id'] as String,
    operation:
        _$enumDecodeNullable(_$ReactionEventActionEnumMap, json['operation']),
    updatedAt: json['updated_at'] as int,
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

const _$ReactionEventActionEnumMap = {
  ReactionEventAction.add: 'ADD',
  ReactionEventAction.delete: 'DELETE',
};
