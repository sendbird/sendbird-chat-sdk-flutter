// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/event/login_event.dart';

class EventDispatcher {
  final Chat _chat;

  EventDispatcher({required Chat chat}) : _chat = chat;

  Future<void> onConnecting() async {
    sbLog.d(StackTrace.current);
    await _chat.statManager.onConnecting();
  }

  Future<void> onLogin(LoginEvent event) async {
    sbLog.d(StackTrace.current);
    _chat.collectionManager.onLogin();
    await _chat.statManager.onLogin(event);
  }

  Future<void> onDisconnected() async {
    sbLog.d(StackTrace.current);
  }

  Future<void> onReconnecting() async {
    sbLog.d(StackTrace.current);
  }

  Future<void> onReconnected(LoginEvent event) async {
    sbLog.d(StackTrace.current);
    _chat.collectionManager.onReconnected();
    await _chat.statManager.onReconnected(event);
  }

  Future<void> onLogout() async {
    sbLog.d(StackTrace.current);
    await _chat.statManager.onLogout();
  }
}
