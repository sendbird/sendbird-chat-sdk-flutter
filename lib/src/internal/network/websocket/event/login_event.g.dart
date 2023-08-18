// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginEvent _$LoginEventFromJson(Map<String, dynamic> json) => LoginEvent(
      eKey: json['ekey'] as String?,
      newKey: json['newKey'] as String?,
      key: json['key'] as String?,
      loginTimestamp: json['login_ts'] as int,
      reconnectConfiguration: ReconnectConfiguration.fromJson(
          json['reconnect'] as Map<String, dynamic>),
      pingInterval: json['pingInterval'] as int? ?? 15,
      watchdogInterval: json['pong_timeout'] as int,
      maxUnreadCountOnSuperGroup: json['maxUnreadCountOnSuperGroup'] as int?,
    );
