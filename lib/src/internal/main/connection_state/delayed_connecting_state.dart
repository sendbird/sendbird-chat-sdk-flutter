// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/connection_state/base_connection_state.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/reconnect_task.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';

class DelayedConnectingState extends BaseConnectionState {
  int retryAfter; // seconds
  int? reasonCode;
  String? message;
  Timer? retryAfterTimer;

  DelayedConnectingState({
    required Chat chat,
    required this.retryAfter,
    this.reasonCode,
    this.message,
  }) : super(chat: chat) {
    if (retryAfter < 0) {
      retryAfter = 0;
    }

    chat.eventManager.notifyConnectionDelayed(retryAfter);

    if (retryAfter > 0) {
      _setRetryAfterTimer();
    } else {
      Future.delayed(Duration.zero, () {
        _tryToConnect();
      });
    }
  }

  void _cancelRetryAfterTimer() {
    retryAfterTimer?.cancel();
    retryAfterTimer = null;
  }

  void _setRetryAfterTimer() {
    _cancelRetryAfterTimer();

    retryAfterTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      retryAfter -= 1;
      if (retryAfter <= 0) {
        timer.cancel();

        _tryToConnect();
      }
    });
  }

  Future<void> _tryToConnect() async {
    await chat.connectionManager.doDisconnect(clear: false);
    await chat.connectionManager.doReconnect(
      reset: true,
      isDelayedConnecting: true,
    );
  }

  @override
  Future<User> connect(
    String userId, {
    String? nickname,
    String? accessToken,
    String? apiHost,
    String? wsHost,
  }) async {
    sbLog.i(StackTrace.current, 'userId: $userId');

    final e = ServerOverloadedException(
      message: message,
      data: {
        'retry_after': retryAfter,
        'reason_code': reasonCode,
        'message': message,
      },
    );

    chat.statManager.endWsConnectStat(
      hostUrl: chat.chatContext.connectingUrl ?? '',
      success: false,
      errorCode: e.code,
      errorDescription: e.message,
      accumTrial: 1,
    );

    chat.eventManager.notifyConnectionDelayed(retryAfter);
    throw e;
  }

  @override
  Future<void> disconnect({required bool logout}) async {
    sbLog.i(StackTrace.current);

    if (logout) {
      _cancelRetryAfterTimer();
      await chat.connectionManager.doDisconnect(clear: logout, logout: logout);
    }
  }

  @override
  Future<bool> reconnect({bool reset = false}) async {
    sbLog.i(StackTrace.current);
    return false;
  }

  @override
  Future<void> enterBackground() async {
    sbLog.i(StackTrace.current);

    _cancelRetryAfterTimer();
    await chat.connectionManager.doDisconnect(
      clear: false,
      fromEnterBackground: true,
      timeForDelayedConnectingState: DateTime.now().millisecondsSinceEpoch,
      retryAfterForDelayedConnectingState: retryAfter,
      reasonCodeForDelayedConnectingState: reasonCode,
      messageForDelayedConnectingState: message,
    );
  }

  @override
  Future<void> enterForeground() async {
    sbLog.i(StackTrace.current);
  }
}
