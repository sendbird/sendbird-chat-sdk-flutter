// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'chat.dart';

extension ChatConnection on Chat {
  Future<User> connect(
    String userId, {
    String? nickname,
    String? accessToken,
    String? apiHost,
    String? wsHost,
    bool reconnect = false,
  }) async {
    sbLog.i(StackTrace.current, 'userId: $userId');
    _listenAppLifecycleState(); // Check

    if (userId.isEmpty) {
      throw InvalidParameterException();
    }
    userId = userId.trim();

    return await connectionManager.connect(
      userId,
      nickname: nickname,
      accessToken: accessToken,
      apiHost: apiHost,
      wsHost: wsHost,
    );
  }

  Future<void> disconnect() async {
    sbLog.i(StackTrace.current, 'userId: ${chatContext.currentUserId}');
    return await connectionManager.disconnect(logout: true);
  }

  Future<bool> reconnect({bool reset = false}) async {
    sbLog.i(StackTrace.current, 'userId: ${chatContext.currentUserId}');
    return await connectionManager.reconnect(reset: reset);
  }

  int? getLastConnectedAt() {
    final result = chatContext.lastConnectedAt;
    sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }

  MyConnectionState getConnectionState() {
    if (connectionManager.isConnecting() ||
        connectionManager.isReconnecting()) {
      return MyConnectionState.connecting;
    } else if (connectionManager.webSocketClient.isConnected()) {
      return MyConnectionState.open;
    }
    return MyConnectionState.closed;
  }
}
