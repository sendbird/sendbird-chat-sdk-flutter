// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/log_publish_config.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/reconnect_configuration.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/event/session_event.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/info/app_info.dart';

part 'login_event.g.dart';

@JsonSerializable(createToJson: false)
class LoginEvent extends SessionEvent {
  @JsonKey(name: 'login_ts')
  final int loginTimestamp;

  @JsonKey(name: 'reconnect')
  final ReconnectConfiguration reconnectConfiguration;

  @JsonKey(defaultValue: 15)
  final int pingInterval;

  @JsonKey(name: 'pong_timeout')
  final int watchdogInterval;

  final int? maxUnreadCountOnSuperGroup;

  final List<String> applicationAttributes;

  final int deviceTokenLastDeletedAt;

  @JsonKey(name: 'config_sync_needed')
  final bool? configSyncNeeded;

  @JsonKey(name: 'log_publish_config')
  final LogPublishConfig? logPublishConfig;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late AppInfo appInfo;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late User user;

  LoginEvent({
    String? eKey,
    String? newKey,
    String? key,
    required this.loginTimestamp,
    required this.reconnectConfiguration,
    required this.pingInterval,
    required this.watchdogInterval,
    this.maxUnreadCountOnSuperGroup,
    this.applicationAttributes = const [],
    this.deviceTokenLastDeletedAt = 0,
    this.configSyncNeeded,
    this.logPublishConfig,
  }) : super(eKey: eKey, newKey: newKey, key: key);

  factory LoginEvent.fromJson(Map<String, dynamic> json) {
    final event = _$LoginEventFromJson(json);
    event.appInfo = AppInfo.fromJson(json);
    event.user = User.fromJson(json);
    return event;
  }
}
