// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionEvent _$SessionEventFromJson(Map<String, dynamic> json) {
  return SessionEvent(
    expiresAt: json['expires_at'] as int? ?? 0,
    newKey: json['new_key'] as String?,
    ekey: json['ekey'] as String?,
    key: json['key'] as String?,
  );
}
