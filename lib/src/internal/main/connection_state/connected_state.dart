// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_context/chat_context.dart';
import 'package:sendbird_chat_sdk/src/internal/main/connection_state/base_connection_state.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';

class ConnectedState extends BaseConnectionState {
  ConnectedState({
    required Chat chat,
  }) : super(chat: chat);

  @override
  Future<User> connect(
    String userId, {
    String? nickname,
    String? accessToken,
    String? apiHost,
    String? wsHost,
  }) async {
    sbLog.i(StackTrace.current, 'userId: $userId');
    if (chat.chatContext.currentUserId == userId &&
        chat.chatContext.currentUser != null &&
        chat.chatContext.services.contains(Service.chat)) {
      return chat.chatContext.currentUser!;
    }

    await chat.connectionManager.doDisconnect(clear: true);
    return await chat.connectionManager.doConnect(
      userId,
      nickname: nickname,
      accessToken: accessToken,
      apiHost: apiHost,
      wsHost: wsHost,
    );
  }

  @override
  Future<void> disconnect({required logout}) async {
    sbLog.i(StackTrace.current);
    await chat.connectionManager.doDisconnect(clear: logout, logout: logout);
  }

  @override
  Future<bool> reconnect({bool reset = false}) async {
    sbLog.i(StackTrace.current);
    return await chat.connectionManager.doReconnect(reset: reset);
  }

  @override
  Future<void> enterBackground() async {
    sbLog.i(StackTrace.current);
    await chat.connectionManager.doDisconnect(clear: false);
  }

  @override
  Future<void> enterForeground() async {
    sbLog.i(StackTrace.current);
  }
}
