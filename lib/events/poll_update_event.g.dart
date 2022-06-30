// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_update_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollUpdateEvent _$PollUpdateEventFromJson(Map<String, dynamic> json) =>
    PollUpdateEvent(
      poll: Poll.fromJson(json['poll'] as Map<String, dynamic>),
      status: json['status'] as String,
      ts: json['ts'] as int,
    );

Map<String, dynamic> _$PollUpdateEventToJson(PollUpdateEvent instance) =>
    <String, dynamic>{
      'poll': instance.poll.toJson(),
      'status': instance.status,
      'ts': instance.ts,
    };
