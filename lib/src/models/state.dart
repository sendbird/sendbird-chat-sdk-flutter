import '../models/app_info.dart';
import '../constant/enums.dart';
import '../models/reconnect_configuration.dart';
import '../models/reconnect_task.dart';
import '../models/unread_count_info.dart';
import '../models/user.dart';

class SendbirdState {
  String appId;
  String userId;
  User currentUser;
  String sessionKey;

  bool connected = false;
  bool connecting = false;
  bool reconnecting = false;
  int lastConnectedAt;

  String apiHost;
  String wsHost;

  String pushToken;
  PushTokenType pushTokenType;
  AppInfo appInfo;
  int maxUnreadCountOnSuperGroup;

  ReconnectTask reconnectTask;
  ReconnectConfiguration reconnectConfig;

  UnreadCountInfo unreadCountInfo =
      UnreadCountInfo(all: 0, customTypes: {}, ts: 0);

  SendbirdState();
  bool get hasActiveUser => currentUser != null;

  void resetReconnectTask() {
    reconnectTask = ReconnectTask(reconnectConfig);
  }
}
