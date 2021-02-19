// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcnt_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MCNTEvent _$MCNTEventFromJson(Map<String, dynamic> json) {
  return MCNTEvent(
    groupChannels: (json['group_channels'] as List)
        ?.map((e) =>
            e == null ? null : GroupChannel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    openChannels: (json['open_channels'] as List)
        ?.map((e) =>
            e == null ? null : OpenChannel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    systemTimestamp: json['sts'] as int,
    timestamp: json['ts'] as int,
  );
}

Map<String, dynamic> _$MCNTEventToJson(MCNTEvent instance) => <String, dynamic>{
      'group_channels': instance.groupChannels,
      'open_channels': instance.openChannels,
      'sts': instance.systemTimestamp,
      'ts': instance.timestamp,
    };
