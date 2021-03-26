import 'app_info.dart';
import 'reconnect_configuration.dart';
import 'reconnect_task.dart';
import 'unread_count_info.dart';
import 'user.dart';
import '../../constant/enums.dart';

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
