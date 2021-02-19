// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionEvent _$SessionEventFromJson(Map<String, dynamic> json) {
  return SessionEvent(
    expiresIn: json['expires_in'] as int,
    newKey: json['new_key'] as String,
    ekey: json['ekey'] as String,
    key: json['key'] as String,
  );
}

Map<String, dynamic> _$SessionEventToJson(SessionEvent instance) =>
    <String, dynamic>{
      'expires_in': instance.expiresIn,
      'new_key': instance.newKey,
      'ekey': instance.ekey,
      'key': instance.key,
    };
