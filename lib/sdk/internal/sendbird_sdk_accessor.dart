import 'sendbird_sdk_internal.dart';

import '../sendbird_sdk_api.dart';
import '../../core/models/state.dart';
import '../../handlers/event_manager.dart';
import '../../services/network/websocket_client.dart';

abstract class SdkAccessor {
  SendbirdSdkInternal get sdk => SendbirdSdk().getInternal();
  WebSocketClient get webSocket => sdk?.webSocket;
  SendbirdState get appState => sdk?.state;
  EventManager get eventManager => sdk?.eventManager;
}
