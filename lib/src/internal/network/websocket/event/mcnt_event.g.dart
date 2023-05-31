// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcnt_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MCNTEvent _$MCNTEventFromJson(Map<String, dynamic> json) => MCNTEvent(
      groupChannels: (json['group_channels'] as List<dynamic>?)
              ?.map((e) => GroupChannel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      openChannels: (json['open_channels'] as List<dynamic>?)
              ?.map((e) => OpenChannel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      systemTimestamp: json['sts'] as int?,
      timestamp: json['ts'] as int?,
    );
