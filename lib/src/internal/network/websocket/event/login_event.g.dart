// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginEvent _$LoginEventFromJson(Map<String, dynamic> json) => LoginEvent(
      eKey: json['ekey'] as String?,
      newKey: json['new_key'] as String?,
      key: json['key'] as String?,
      loginTimestamp: (json['login_ts'] as num).toInt(),
      reconnectConfiguration: ReconnectConfiguration.fromJson(
          json['reconnect'] as Map<String, dynamic>),
      pingInterval: (json['ping_interval'] as num?)?.toInt() ?? 15,
      watchdogInterval: (json['pong_timeout'] as num).toInt(),
      maxUnreadCountOnSuperGroup:
          (json['max_unread_count_on_super_group'] as num?)?.toInt(),
      applicationAttributes: (json['application_attributes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      deviceTokenLastDeletedAt:
          (json['device_token_last_deleted_at'] as num?)?.toInt() ?? 0,
      configSyncNeeded: json['config_sync_needed'] as bool?,
      logPublishConfig: json['log_publish_config'] == null
          ? null
          : LogPublishConfig.fromJson(
              json['log_publish_config'] as Map<String, dynamic>),
    );
