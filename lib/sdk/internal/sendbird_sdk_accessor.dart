import 'package:sendbird_sdk/core/models/state.dart';
import 'package:sendbird_sdk/managers/command_manager.dart';
import 'package:sendbird_sdk/managers/event_manager.dart';
import 'package:sendbird_sdk/sdk/internal/sendbird_sdk_internal.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:sendbird_sdk/services/network/websocket_client.dart';

abstract class SdkAccessor {
  SendbirdSdkInternal get sdk => SendbirdSdk().getInternal();
  WebSocketClient? get webSocket => sdk.webSocket;
  SendbirdState get appState => sdk.state;
  EventManager get eventManager => sdk.eventManager;
  CommandManager get cmdManager => sdk.cmdManager;
}
