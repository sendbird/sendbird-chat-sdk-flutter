// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';

/// The connection handler.
/// This handler provides callbacks for automatically managed reconnection events.
/// SendbirdChat tries reconnection when the connection is lost.
/// This handler can be used to track the reconnection state.
/// To add or remove this handler, refer to [SendbirdChat.addConnectionHandler] and [SendbirdChat.removeConnectionHandler].
abstract class ConnectionHandler {
  /// A callback for when SendbirdChat is connected.
  void onConnected(String userId);

  /// A callback for when SendbirdChat is disconnected.
  void onDisconnected(String userId);

  /// A callback for when SendbirdChat tries to reconnect.
  void onReconnectStarted();

  /// A callback for when connection is reestablished.
  void onReconnectSucceeded();

  /// A callback for when reconnection is failed.
  void onReconnectFailed();
}
