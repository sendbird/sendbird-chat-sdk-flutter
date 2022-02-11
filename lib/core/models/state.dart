import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/app_info.dart';
import 'package:sendbird_sdk/core/models/reconnect_configuration.dart';
import 'package:sendbird_sdk/core/models/reconnect_task.dart';
import 'package:sendbird_sdk/core/models/unread_count_info.dart';
import 'package:sendbird_sdk/core/models/user.dart';

class SendbirdState {
  String? appId;
  String? appVersion;
  String? userId;
  User? currentUser;
  String? sessionKey;
  String? token;

  bool connected = false;
  bool connecting = false;
  bool reconnecting = false;
  int? lastConnectedAt;

  String? apiHost;
  String? wsHost;

  String? pushToken;
  PushTokenType? pushTokenType;
  AppInfo? appInfo;
  int? maxUnreadCountOnSuperGroup;
  int uploadSizeLimit = 0;

  ReconnectTask? reconnectTask;
  ReconnectConfiguration? reconnectConfig;

  UnreadCountInfo unreadCountInfo =
      UnreadCountInfo(all: 0, customTypes: {}, ts: 0);

  SendbirdState();
  bool get hasActiveUser => currentUser != null;

  void resetReconnectTask() {
    final config = reconnectConfig;
    if (config != null) {
      reconnectTask = ReconnectTask(config);
    }
  }

  void cleanUp() {
    userId = null;
    currentUser = null;
    sessionKey = null;
    token = null;

    connected = false;
    connecting = false;
    reconnecting = false;
    lastConnectedAt = null;

    apiHost = null;
    wsHost = null;

    pushToken = null;
    pushTokenType = null;
    appInfo = null;
  }
}
