// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginEvent _$LoginEventFromJson(Map<String, dynamic> json) {
  return LoginEvent(
    ekey: json['ekey'] as String,
    expiresIn: json['expires_in'] as int,
    newKey: json['new_key'] as String,
    key: json['key'] as String,
    loginTimestamp: json['login_ts'] as int,
    maxUnreadCountOnSuperGroup: json['max_unread_count_on_super_group'] as int,
    reconnectConfiguration: json['reconnect'] == null
        ? null
        : ReconnectConfiguration.fromJson(
            json['reconnect'] as Map<String, dynamic>),
    pingInterval: json['ping_interval'] as int,
    watchdogInterval: json['pong_timeout'] as int,
  );
}

Map<String, dynamic> _$LoginEventToJson(LoginEvent instance) =>
    <String, dynamic>{
      'expires_in': instance.expiresIn,
      'new_key': instance.newKey,
      'ekey': instance.ekey,
      'key': instance.key,
      'login_ts': instance.loginTimestamp,
      'max_unread_count_on_super_group': instance.maxUnreadCountOnSuperGroup,
      'reconnect': instance.reconnectConfiguration,
      'ping_interval': instance.pingInterval,
      'pong_timeout': instance.watchdogInterval,
    };
