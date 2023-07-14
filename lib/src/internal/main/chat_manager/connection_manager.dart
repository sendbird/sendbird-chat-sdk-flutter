// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/command_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/connection_state/base_connection_state.dart';
import 'package:sendbird_chat_sdk/src/internal/main/connection_state/disconnected_state.dart';
import 'package:sendbird_chat_sdk/src/internal/main/connection_state/reconnecting_state.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/websocket_client.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:universal_io/io.dart';

class ConnectionManager {
  Timer? reconnectTimer;

  final Chat chat;
  late WebSocketClient webSocketClient;
  late BaseConnectionState _currentState;

  ConnectionManager({required this.chat}) {
    webSocketClient = WebSocketClient(
      chatContext: chat.chatContext,
      onWebSocketConnected: _onWebSocketConnected,
      onWebSocketClosed: _onWebSocketClosed,
      onWebSocketData: _onWebSocketData,
      onWebSocketError: _onWebSocketError,
    );
    _currentState = DisconnectedState(chat: chat);
  }

  bool changeState(BaseConnectionState state) {
    if (_currentState == state) {
      return false;
    }

    _currentState = state;
    sbLog.i(StackTrace.current, _currentState.runtimeType.toString());
    return true;
  }

  bool isConnected() {
    return _currentState.runtimeType.toString() == 'ConnectedState';
  }

  bool isConnecting() {
    return _currentState.runtimeType.toString() == 'ConnectingState';
  }

  bool isDisconnected() {
    return _currentState.runtimeType.toString() == 'DisconnectedState';
  }

  bool isReconnecting() {
    return _currentState.runtimeType.toString() == 'ReconnectingState';
  }

  BaseConnectionState getCurrentState() {
    return _currentState;
  }

  Future<User> connect(
    String userId, {
    String? nickname,
    String? accessToken,
    String? apiHost,
    String? wsHost,
  }) async {
    return await _currentState.connect(
      userId,
      nickname: nickname,
      accessToken: accessToken,
      apiHost: apiHost,
      wsHost: wsHost,
    );
  }

  Future<void> disconnect({required logout}) async {
    await _currentState.disconnect(logout: logout);
  }

  Future<bool> reconnect({bool reset = false}) async {
    return await _currentState.reconnect(reset: reset);
  }

  Future<void> enterBackground() async {
    return await _currentState.enterBackground();
  }

  Future<void> enterForeground() async {
    return await _currentState.enterForeground();
  }

//------------------------------//
// Implementation
//------------------------------//
  Future<User> doConnect(
    String userId, {
    String? nickname,
    String? accessToken,
    String? apiHost,
    String? wsHost,
  }) async {
    sbLog.i(StackTrace.current, 'userId: $userId');

    // ===== Connect =====
    chat.chatContext
      ..currentUserId = userId
      ..accessToken = accessToken
      ..apiHost = apiHost ?? _getDefaultApiHost()
      ..wsHost = wsHost ?? _getDefaultWsHost()
      ..apiHeaders = {
        'SB-User-Agent': _sbUserAgentHeader,
        'SendBird': _sendbirdHeader,
      }
      ..loginCompleter = Completer();

    final params = {
      'user_id': userId,
      if (nickname != null && nickname != '') 'nickname': nickname,
      if (accessToken != null) 'access_token': accessToken,
      'SB-User-Agent': _sbUserAgentHeader,
      'expiring_session':
          chat.eventManager.getSessionHandler() != null ? '1' : '0',
      'include_extra_data': chat.extraData.join(','),
      'include_poll_details': '1',
    };
    params.addAll(_webSocketParams);

    final url =
        '${chat.chatContext.wsHost}/?${Uri(queryParameters: params).query}';

    runZonedGuarded(() {
      sbLog.d(StackTrace.current, 'webSocketClient?.connect()');
      webSocketClient.connect(url);
    }, (e, s) async {
      sbLog.e(StackTrace.current, 'e: $e');
      changeState(DisconnectedState(chat: chat));
      if (chat.chatContext.loginCompleter != null &&
          !chat.chatContext.loginCompleter!.isCompleted) {
        if (e is SendbirdException) {
          chat.chatContext.loginCompleter?.completeError(e);
        } else {
          chat.chatContext.loginCompleter
              ?.completeError(WebSocketFailedException(message: e.toString()));
        }
      }
    });

    final user = await chat.chatContext.loginCompleter!.future
        .timeout(Duration(seconds: chat.chatContext.options.connectionTimeout),
            onTimeout: () async {
      await doDisconnect(logout: true);
      throw LoginTimeoutException();
    });

    // After 'LOGI' received
    return user;
  }

  Future<void> doDisconnect({required bool logout}) async {
    sbLog.i(StackTrace.current,
        'logout: $logout, userId: ${chat.chatContext.currentUserId}');

    if (chat.chatContext.loginCompleter != null &&
        !chat.chatContext.loginCompleter!.isCompleted) {
      chat.chatContext.loginCompleter
          ?.completeError(ConnectionCanceledException());
    }

    if (isReconnecting()) {
      reconnectTimer?.cancel();
      reconnectTimer = null;
      if (logout) {
        chat.eventManager.notifyReconnectFailed();
      }
    }

    await webSocketClient.close();

    final disconnectedUserId = chat.chatContext.currentUserId ?? '';

    if (logout) {
      await chat.eventDispatcher.onLogout();

      chat.messageQueueMap.forEach((key, q) => q.cleanUp());
      chat.messageQueueMap.clear();
      // chat.uploads.forEach((key, value) => _api.cancelUploadingFile(key));
      chat.uploadTaskMap.clear();

      chat.chatContext.cleanUp();
      chat.channelCache.cleanUp();
      chat.sessionManager.cleanUp();
      chat.commandManager.cleanUp();
      chat.apiClient.cleanUp();
    } else {
      await chat.eventDispatcher.onDisconnected();
    }

    changeState(DisconnectedState(chat: chat));

    if (logout && disconnectedUserId.isNotEmpty) {
      chat.eventManager.notifyDisconnected(disconnectedUserId);
    }
  }

  Future<bool> doReconnect({bool reset = false}) async {
    sbLog.i(StackTrace.current, 'reset: $reset');

    if (chat.chatContext.currentUser == null ||
        chat.chatContext.sessionKey == null) {
      changeState(DisconnectedState(chat: chat));
      chat.eventManager.notifyReconnectFailed();
      return false;
    }

    final task = chat.chatContext.reconnectTask;
    if (task == null || (task.exceedRetryCount && task.hasRetriedLastChance)) {
      sbLog.w(StackTrace.current, 'exceedRetryCount and hasRetriedLastChance');
      disconnect(logout: true);
      return false;
    }

    changeState(ReconnectingState(chat: chat));

    if (reset) {
      chat.chatContext.resetReconnectTask();
    } else {
      chat.chatContext.reconnectTask?.increaseRetryCount();
    }

    sbLog.i(
      StackTrace.current,
      '[Timer()] ${chat.chatContext.reconnectTask?.backOffPeriod}sec, ${chat.chatContext.reconnectTask?.retryCount}/${chat.chatContext.reconnectTask?.config.maximumRetryCount}',
    );

    reconnectTimer?.cancel();
    reconnectTimer =
        Timer(Duration(seconds: chat.chatContext.reconnectTask!.backOffPeriod),
            () async {
      sbLog.i(
        StackTrace.current,
        '[Timer() => RUN] ${chat.chatContext.reconnectTask?.backOffPeriod}sec, ${chat.chatContext.reconnectTask?.retryCount}/${chat.chatContext.reconnectTask?.config.maximumRetryCount}',
      );

      if (chat.chatContext.reconnectTask?.retryCount == 1) {
        await chat.eventDispatcher.onReconnecting();
        chat.eventManager.notifyReconnectStarted();
      }

      // ===== Reconnect =====
      final sessionKey = await chat.sessionManager.getSessionKey();
      final params = {
        if (sessionKey != null)
          'key': sessionKey
        else
          'user_id': chat.chatContext.currentUserId,
        'access_token': chat.chatContext.accessToken,
        'SB-User-Agent': _sbUserAgentHeader,
        'expiring_session':
            chat.eventManager.getSessionHandler() != null ? '1' : '0',
        'include_extra_data': chat.extraData.join(','),
        'include_poll_details': '1',
      };
      params.addAll(_webSocketParams);

      final url =
          '${chat.chatContext.wsHost}/?${Uri(queryParameters: params).query}';

      runZonedGuarded(() {
        sbLog.d(StackTrace.current, 'webSocketClient?.connect()');
        webSocketClient.connect(url);

        reconnectTimer?.cancel();
        reconnectTimer = null;
      }, (e, s) {
        sbLog.e(StackTrace.current, 'e: $e');
      });
    });
    return true;
  }

//------------------------------//
// WebSocket Event Listener
//------------------------------//
  void _onWebSocketConnected() {}

  void _onWebSocketClosed() {
    chat.commandManager.clearCompleterMap();
  }

  Future<void> _onWebSocketData(dynamic data) async {
    if (data == null) return;

    String commandString;
    if (data.runtimeType == String) {
      commandString = (data as String);
    } else {
      commandString =
          const Utf8Decoder(allowMalformed: true).convert(data as List<int>);
    }

    if (commandString.isEmpty) return;
    final cmd = CommandManager.parseCommandString(commandString);
    if (cmd == null) return;

    runZonedGuarded(() async {
      try {
        await chat.commandManager.processCommand(cmd);
      } catch (e) {
        sbLog.e(StackTrace.current, 'e: $e');
        rethrow;
      }
    }, (e, s) {
      if (chat.chatContext.loginCompleter != null &&
          !chat.chatContext.loginCompleter!.isCompleted) {
        chat.chatContext.loginCompleter?.completeError(e);
      }
    });
  }

  Future<void> _onWebSocketError(Object e) async {
    if (chat.chatContext.currentUser != null) {
      if (isReconnecting()) {
        await reconnect(reset: false);
      } else {
        await disconnect(logout: false);
        await reconnect(reset: true);
      }
    } else {
      throw WebSocketFailedException(message: e.toString());
    }
  }

//------------------------------//
// Values
//------------------------------//
  String _getDefaultApiHost() {
    final appId = chat.chatContext.appId;
    return 'api-$appId.sendbird.com';
  }

  String _getDefaultWsHost() {
    final appId = chat.chatContext.appId;
    return 'wss://ws-$appId.sendbird.com';
  }

  String get _sbUserAgentHeader {
    final uikitVersion = chat.extensions[Chat.extensionKeyUiKit];
    const core = '/c$sdkVersion';
    final uikit = uikitVersion != null ? '/u$uikitVersion' : '';
    final os = '/o${kIsWeb ? 'web' : Platform.operatingSystem.toLowerCase()}';
    return '${Chat.platform}$core$uikit$os';
  }

  String get _sendbirdHeader {
    var headers = [
      Chat.platform,
      kIsWeb ? '' : Platform.version.split(' ').first, // empty platform version
      sdkVersion,
      chat.chatContext.appId,
      chat.chatContext.appVersion ?? '',
      kIsWeb ? 'web' : Platform.operatingSystem.toLowerCase(),
      kIsWeb ? '' : Platform.operatingSystemVersion,
    ];
    return headers.join(',');
  }

  Map<String, String> get _webSocketParams {
    final appId = chat.chatContext.appId;
    final appVersion = chat.chatContext.appVersion;

    return {
      'p': Chat.platform,
      if (!kIsWeb) 'pv': Platform.version.split(' ').first,
      'o': kIsWeb ? 'web' : Platform.operatingSystem.toLowerCase(),
      if (!kIsWeb) 'ov': Platform.operatingSystemVersion,
      'sv': sdkVersion,
      'ai': appId,
      if (appVersion != null && appVersion != '') 'av': appVersion
    };
  }
}
