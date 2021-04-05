import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/core/models/app_info.dart';
import 'package:sendbird_sdk/core/models/reconnect_configuration.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/events/session_event.dart';

part 'login_event.g.dart';

/// Represents login event
@JsonSerializable(createToJson: false)
class LoginEvent extends SessionEvent {
  @JsonKey(name: 'login_ts')
  final int loginTimestamp;

  final int maxUnreadCountOnSuperGroup;

  @JsonKey(name: 'reconnect')
  final ReconnectConfiguration reconnectConfiguration;

  final int pingInterval;

  @JsonKey(name: 'pong_timeout')
  final int watchdogInterval;

  @JsonKey(ignore: true)
  AppInfo appInfo;

  @JsonKey(ignore: true)
  User user;

  LoginEvent({
    String ekey,
    int expiresIn,
    String newKey,
    String key,
    this.loginTimestamp,
    this.maxUnreadCountOnSuperGroup,
    this.reconnectConfiguration,
    this.pingInterval,
    this.watchdogInterval,
  }) : super(
          ekey: ekey,
          newKey: newKey,
          key: key,
          expiresIn: expiresIn,
        );

  factory LoginEvent.fromJson(Map<String, dynamic> json) {
    final event = _$LoginEventFromJson(json);
    event.appInfo = AppInfo.fromJson(json);
    event.user = User.fromJson(json);
    return event;
  }
}
