// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/connection_state/base_connection_state.dart';
import 'package:sendbird_chat_sdk/src/internal/main/connection_state/connecting_state.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';

class DisconnectedState extends BaseConnectionState {
  DisconnectedState({
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
    chat.connectionManager.changeState(ConnectingState(chat: chat));

    final result = chat.connectionManager.doConnect(
      userId,
      nickname: nickname,
      accessToken: accessToken,
      apiHost: apiHost,
      wsHost: wsHost,
    );

    await chat.eventDispatcher.onConnecting();
    return result;
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
    await chat.connectionManager.doReconnect(reset: true);
  }
}
