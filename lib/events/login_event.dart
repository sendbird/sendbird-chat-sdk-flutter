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

  final int? maxUnreadCountOnSuperGroup;

  @JsonKey(name: 'reconnect')
  final ReconnectConfiguration reconnectConfiguration;

  @JsonKey(defaultValue: 15)
  final int pingInterval;

  @JsonKey(name: 'pong_timeout')
  final int watchdogInterval;

  @JsonKey(ignore: true)
  late AppInfo appInfo;

  @JsonKey(ignore: true)
  late User user;

  LoginEvent({
    String? ekey,
    String? newKey,
    String? key,
    required this.loginTimestamp,
    required this.reconnectConfiguration,
    required this.pingInterval,
    required this.watchdogInterval,
    this.maxUnreadCountOnSuperGroup,
  }) : super(
          ekey: ekey,
          newKey: newKey,
          key: key,
        );

  factory LoginEvent.fromJson(Map<String, dynamic> json) {
    final event = _$LoginEventFromJson(json);
    event.appInfo = AppInfo.fromJson(json);
    event.user = User.fromJson(json);
    return event;
  }
}
