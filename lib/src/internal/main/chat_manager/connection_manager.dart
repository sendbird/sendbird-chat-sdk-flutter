// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/collection_manager/collection_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/collection_manager/message_retention_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/command_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/connection_state/base_connection_state.dart';
import 'package:sendbird_chat_sdk/src/internal/main/connection_state/connected_state.dart';
import 'package:sendbird_chat_sdk/src/internal/main/connection_state/connecting_state.dart';
import 'package:sendbird_chat_sdk/src/internal/main/connection_state/disconnected_state.dart';
import 'package:sendbird_chat_sdk/src/internal/main/connection_state/reconnecting_state.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/command/command.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/websocket_client.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/sendbird_error.dart';
import 'package:universal_io/io.dart';
import 'package:uuid/uuid.dart';

class ConnectionManager {
  Timer? reconnectTimer;

  final Chat chat;
  late WebSocketClient webSocketClient;
  late BaseConnectionState _currentState;
  Timer? _reconnectIfNeededTimer;

  // Test seams for the auto-reconnect background-defer race (CLNP-8835): when
  // set, _reconnect signals reconnectSocketGateReachedForTest and awaits
  // reconnectSocketGateForTest just before its background re-check, letting a
  // test flip isBackground in between.
  Completer<void>? reconnectSocketGateForTest;
  Completer<void>? reconnectSocketGateReachedForTest;
  // Test seam for the resume-during-teardown race: when set, doDisconnect signals
  // disconnectResumeGateReachedForTest and awaits disconnectResumeGateForTest just
  // before its fromEnterBackground foreground re-check, letting a test flip
  // isBackground to simulate a resume that lands mid-teardown. (CLNP-8835)
  Completer<void>? disconnectResumeGateForTest;
  Completer<void>? disconnectResumeGateReachedForTest;

  ConnectionManager({required this.chat}) {
    webSocketClient = WebSocketClient(
      chat: chat,
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
    return _currentState is ConnectedState;
  }

  bool isConnecting() {
    return _currentState is ConnectingState;
  }

  bool isDisconnected() {
    return _currentState is DisconnectedState;
  }

  bool isReconnecting() {
    return _currentState is ReconnectingState;
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

  Future<void> disconnect({required bool logout}) async {
    await _currentState.disconnect(logout: logout);
  }

  Future<bool> reconnect({required bool reset, bool byUser = false}) async {
    return await _currentState.reconnect(reset: reset, byUser: byUser);
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
  void setLoginInfo({
    required bool fromWebSocket,
    required String userId,
    String? accessToken,
    String? nickname,
    String? apiHost,
    String? wsHost,
  }) {
    chat.chatContext
      ..currentUserId = userId
      ..accessToken = accessToken
      ..nickname = nickname
      ..apiHost = apiHost ?? getDefaultApiHost()
      ..apiHeaders = getDefaultApiHeader();

    if (fromWebSocket) {
      chat.chatContext
        ..wsHost = wsHost ?? _getDefaultWsHost()
        ..loginCompleter = Completer();
    }
  }

  Future<User> doConnect(
    String userId, {
    String? nickname,
    String? accessToken,
    String? apiHost,
    String? wsHost,
    bool isDelayedConnecting = false,
  }) async {
    sbLog.i(StackTrace.current, 'userId: $userId');

    if (!isDelayedConnecting) {
      chat.connectionManager.changeState(ConnectingState(chat: chat));
    }

    setLoginInfo(
      fromWebSocket: true,
      userId: userId,
      accessToken: accessToken,
      nickname: nickname,
      apiHost: apiHost,
      wsHost: wsHost,
    );

    // ===== Connect =====
    final params = {
      'user_id': userId,
      if (nickname != null && nickname != '') 'nickname': nickname,
      'SB-User-Agent': _sbUserAgentHeader,
      'SB-SDK-USER-AGENT': _sbSdkUserAgentHeader,
      'expiring_session':
          chat.eventManager.getSessionHandler() != null ? '1' : '0',
      'include_extra_data': chat.extraData.join(','),
      'include_poll_details': '1',
    };
    params.addAll(await _getWebSocketParams(userId: userId));

    final url =
        '${chat.chatContext.wsHost}/?${Uri(queryParameters: params).query}';

    runZonedGuarded(() {
      sbLog.d(StackTrace.current, 'webSocketClient?.connect()');

      chat.chatContext.connectingUrl = url;
      chat.statManager.startWsConnectStat(hostUrl: url);
      webSocketClient.connect(url: url, accessToken: accessToken);
    }, (e, s) async {
      sbLog.e(StackTrace.current, 'e: $e');

      if (!isDisconnected()) {
        if (!isDelayedConnecting) {
          changeState(DisconnectedState(chat: chat));
        }

        if (chat.chatContext.loginCompleter != null &&
            !chat.chatContext.loginCompleter!.isCompleted) {
          if (e is SendbirdException) {
            chat.statManager.endWsConnectStat(
              hostUrl: url,
              success: false,
              errorCode: e.code,
              errorDescription: e.message,
              accumTrial: isDelayedConnecting
                  ? chat.chatContext.reconnectTask?.retryCount ?? 1
                  : 1,
              isSoftRateLimited: isDelayedConnecting,
            );

            //+ [DBManager]
            if (chat.dbManager.isEnabled()) {
              final user =
                  await chat.dbManager.getLoginInfoByException(userId, e);
              if (user != null) {
                chat.chatContext.loginCompleter?.complete(user);
                chat.chatContext.loginCompleter = null;

                if (chat.chatContext.isChatConnected) {
                  await chat.connectionManager.reconnect(reset: true);
                }
                return;
              }
            }
            //- [DBManager]

            if (isDelayedConnecting) {
              await chat.connectionManager.doReconnect(
                reset: false,
                isDelayedConnecting: true,
              );
            } else {
              if (chat.chatContext.loginCompleter != null &&
                  !chat.chatContext.loginCompleter!.isCompleted) {
                chat.chatContext.loginCompleter?.completeError(e);
              }
            }
          } else {
            final exception = WebSocketFailedException(message: e.toString());

            chat.statManager.endWsConnectStat(
              hostUrl: url,
              success: false,
              errorCode: exception.code,
              errorDescription: exception.message,
              accumTrial: isDelayedConnecting
                  ? chat.chatContext.reconnectTask?.retryCount ?? 1
                  : 1,
              isSoftRateLimited: isDelayedConnecting,
            );

            if (isDelayedConnecting) {
              await chat.connectionManager.doReconnect(
                reset: false,
                isDelayedConnecting: true,
              );
            } else {
              if (chat.chatContext.loginCompleter != null &&
                  !chat.chatContext.loginCompleter!.isCompleted) {
                chat.chatContext.loginCompleter?.completeError(exception);
              }
            }
          }
        }
      }
    });

    final User user;
    if (isDelayedConnecting) {
      user = await chat.chatContext.loginCompleter!.future;
    } else {
      user = await chat.chatContext.loginCompleter!.future.timeout(
          Duration(seconds: chat.chatContext.options.connectionTimeout),
          onTimeout: () async {
        final e = LoginTimeoutException();

        chat.statManager.endWsConnectStat(
          hostUrl: url,
          success: false,
          errorCode: e.code,
          errorDescription: e.name,
          accumTrial: 1,
          isSoftRateLimited: isDelayedConnecting,
        );

        await doDisconnect(clear: true);
        throw e;
      });
    }

    // After 'LOGI' received
    chat.statManager.endWsConnectStat(
      hostUrl: url,
      success: true,
      connectedTs: webSocketClient.connectedTs,
      logiTs: chat.commandManager.logiTs,
      accumTrial: isDelayedConnecting
          ? chat.chatContext.reconnectTask?.retryCount ?? 1
          : 1,
      isSoftRateLimited: isDelayedConnecting,
    );
    return user;
  }

  Future<void> doDisconnect({
    required bool clear,
    bool logout = false,
    bool fromEnterBackground = false,
    int? timeForDelayedConnectingState,
    int? retryAfterForDelayedConnectingState,
    int? reasonCodeForDelayedConnectingState,
    String? messageForDelayedConnectingState,
  }) async {
    sbLog.i(
      StackTrace.current,
      'clear: $clear, logout: $logout, userId: ${chat.chatContext.currentUserId}',
    );

    if (chat.dbManager.isEnabled() == false) {
      if (chat.chatContext.loginCompleter != null &&
          !chat.chatContext.loginCompleter!.isCompleted) {
        chat.chatContext.loginCompleter
            ?.completeError(ConnectionCanceledException());
      }
    }

    if (isReconnecting()) {
      reconnectTimer?.cancel();
      reconnectTimer = null;
    }

    // Check
    if (!isDisconnected()) {
      await webSocketClient.close();
    }

    // The request-dedup cache is per-connection session state; drop it on every
    // WS teardown (background/network/logout) so a reconnect — or an HTTP
    // request made while the socket is down — never reuses a previous session's
    // result.
    chat.apiClient.clearRequestDedup();

    final disconnectedUserId = chat.chatContext.currentUserId ?? '';

    if (clear || logout) {
      // The connected span ends here without a disconnect stat (logout, or
      // connecting a different user via doDisconnect(clear: true)); close it so a
      // stale span can't be consumed by the next connection's socket close.
      // (CLNP-8835)
      chat.statManager.closeWsSpan();

      chat.messageQueueMap.forEach((key, q) => q.cleanUp());
      chat.messageQueueMap.clear();
      // chat.uploads.forEach((key, value) => _api.cancelUploadingFile(key));
      chat.uploadTaskMap.clear();

      chat.channelCache.cleanUp();
      chat.sessionManager.cleanUp();
      chat.commandManager.cleanUp();
      chat.apiClient.cleanUp();

      if (logout) {
        await chat.eventDispatcher.onLogout();

        chat.chatContext.cleanUp();
        chat.collectionManager.cleanUpGroupChannelCollections();
        chat.collectionManager.cleanUpMessageCollections();

        //+ [DBManager]
        if (chat.dbManager.isEnabled()) {
          await chat.dbManager.clear();
        }
        //- [DBManager]

        await chat.deviceTokenManager.cleanUp();
        await MessageRetentionManager().clearConfigTs();
      }
    } else {
      await chat.eventDispatcher.onDisconnected();
    }

    if (disconnectResumeGateForTest != null) {
      disconnectResumeGateReachedForTest?.complete();
      await disconnectResumeGateForTest!.future;
    }

    if (fromEnterBackground &&
        !chat.isBackground &&
        !isReconnecting() &&
        timeForDelayedConnectingState == null) {
      sbLog.i(StackTrace.current, 'reconnect()');
      chat.connectionManager.reconnect(reset: true); // Check
    } else {
      if (isReconnecting() && timeForDelayedConnectingState == null) {
        chat.eventManager.notifyReconnectFailed();
      }

      changeState(DisconnectedState(
        chat: chat,
        timeForDelayedConnectingState: timeForDelayedConnectingState,
        retryAfterForDelayedConnectingState:
            retryAfterForDelayedConnectingState,
        reasonCodeForDelayedConnectingState:
            reasonCodeForDelayedConnectingState,
        messageForDelayedConnectingState: messageForDelayedConnectingState,
      ));

      if (clear && disconnectedUserId.isNotEmpty) {
        chat.eventManager.notifyDisconnected(disconnectedUserId);
      }
    }
  }

  Future<bool> doReconnect({
    bool reset = false,
    bool isDelayedConnecting = false,
    bool byUser = false,
  }) async {
    sbLog.i(StackTrace.current,
        'reset: $reset, isDelayedConnecting: $isDelayedConnecting');

    bool doNotCallReconnectStartedEvent = false;
    if (isReconnecting() && reset) {
      doNotCallReconnectStartedEvent = true;
    }

    if (chat.chatContext.currentUser == null &&
        chat.chatContext.sessionKey == null &&
        chat.chatContext.currentUserId != null) {
      isDelayedConnecting = true;
    } else if (chat.chatContext.currentUser == null ||
        chat.chatContext.sessionKey == null) {
      changeState(DisconnectedState(chat: chat));
      return false;
    }

    final task = chat.chatContext.reconnectTask;
    if (task == null || (task.exceedRetryCount && task.hasRetriedLastChance)) {
      sbLog.w(StackTrace.current, 'exceedRetryCount and hasRetriedLastChance');
      disconnect(logout: task != null);
      return false;
    }

    changeState(ReconnectingState(chat: chat));
    chat.chatContext.reconnectTask?.increaseRetryCount(reset: reset); // Check

    sbLog.i(
      StackTrace.current,
      '[Timer()] ${chat.chatContext.reconnectTask?.backOffPeriod}sec, ${chat.chatContext.reconnectTask?.retryCount}/${chat.chatContext.reconnectTask?.config.maximumRetryCount}',
    );

    reconnectTimer?.cancel();
    reconnectTimer = Timer(
      Duration(seconds: chat.chatContext.reconnectTask!.backOffPeriod),
      () async {
        sbLog.i(
          StackTrace.current,
          '[Timer() => RUN] ${chat.chatContext.reconnectTask?.backOffPeriod}sec, ${chat.chatContext.reconnectTask?.retryCount}/${chat.chatContext.reconnectTask?.config.maximumRetryCount}',
        );

        if (chat.chatContext.reconnectTask?.retryCount == 1) {
          if (!doNotCallReconnectStartedEvent) {
            await chat.eventDispatcher.onReconnecting();
            chat.eventManager.notifyReconnectStarted();
          }
        }

        if (isDelayedConnecting) {
          if (chat.chatContext.currentUserId != null) {
            await doConnect(
              chat.chatContext.currentUserId!,
              nickname: chat.chatContext.nickname,
              accessToken: chat.chatContext.accessToken,
              apiHost: chat.chatContext.apiHost,
              wsHost: chat.chatContext.wsHost,
              isDelayedConnecting: true,
            );
          }
        } else {
          await _reconnect(byUser: byUser);
        }
      },
    );
    return true;
  }

  Future<void> _reconnect({bool byUser = false}) async {
    // ===== Reconnect =====
    final sessionKey = await chat.sessionManager.getSessionKey();
    final params = {
      if (sessionKey == null) 'user_id': chat.chatContext.currentUserId,
      'SB-User-Agent': _sbUserAgentHeader,
      'SB-SDK-USER-AGENT': _sbSdkUserAgentHeader,
      'expiring_session':
          chat.eventManager.getSessionHandler() != null ? '1' : '0',
      'include_extra_data': chat.extraData.join(','),
      'include_poll_details': '1',
    };
    params.addAll(await _getWebSocketParams(
        userId: chat.chatContext.currentUser?.userId ?? ''));

    final url =
        '${chat.chatContext.wsHost}/?${Uri(queryParameters: params).query}';

    // Test seam: lets the auto-reconnect-defer test flip isBackground right
    // before the background re-check below. (CLNP-8835)
    if (reconnectSocketGateForTest != null) {
      reconnectSocketGateReachedForTest?.complete();
      await reconnectSocketGateForTest!.future;
    }

    // Auto reconnect only: if the app was backgrounded/hidden while we awaited the
    // session key/params, don't open a socket into a suspended/throttled app (the
    // ping_pong churn this ticket removes). Stay paused in ReconnectingState; the
    // resume path (enterForeground -> doReconnect) continues this attempt.
    // Explicit reconnect() (byUser) always proceeds. (CLNP-8835)
    if (!byUser && chat.isBackground) {
      sbLog.i(StackTrace.current,
          'auto reconnect reached socket-open while backgrounded; defer to foreground');
      return;
    }

    runZonedGuarded(() {
      sbLog.d(StackTrace.current, 'webSocketClient?.connect()');

      chat.statManager.startWsConnectStat(hostUrl: url);
      if (chat.chatContext.reconnectTask != null) {
        chat.chatContext.reconnectTask?.url = url;
      }

      webSocketClient.connect(
        url: url,
        accessToken: chat.chatContext.accessToken,
        sessionKey: sessionKey,
        reconnect: true,
      );

      reconnectTimer?.cancel();
      reconnectTimer = null;
    }, (e, s) {
      sbLog.e(StackTrace.current, 'e: $e');

      if (e is SendbirdException) {
        chat.statManager.endWsConnectStat(
          hostUrl: url,
          success: false,
          errorCode: e.code,
          errorDescription: e.message,
          accumTrial: chat.chatContext.reconnectTask?.retryCount ?? 1,
          connectionId: chat.chatContext.reconnectTask?.id ?? const Uuid().v4(),
        );
      } else {
        final exception = WebSocketFailedException(message: e.toString());

        chat.statManager.endWsConnectStat(
          hostUrl: url,
          success: false,
          errorCode: exception.code,
          errorDescription: exception.message,
          accumTrial: chat.chatContext.reconnectTask?.retryCount ?? 1,
          connectionId: chat.chatContext.reconnectTask?.id ?? const Uuid().v4(),
        );
      }
    });
  }

//------------------------------//
// WebSocket Event Listener
//------------------------------//
  void _onWebSocketConnected() {
    // Nothing to do here.
  }

  void _onWebSocketClosed({int? unexpectedCloseCode}) async {
    chat.commandManager.clearCompleterMap();
    // The dedup cache is per-connection session state; drop it the moment the
    // socket closes — before the 1s reconnect-if-needed delay — so a request
    // issued during that gap can't reuse a previous session's result.
    chat.apiClient.clearRequestDedup();

    // Only a server/transport-initiated close carries a meaningful code: a local
    // close() always passes 1000 and already records its own semantic cause
    // (background/network/explicit/...). Record it span-guarded so it's dropped
    // if a semantic cause already closed this connection span. (CLNP-8835)
    if (unexpectedCloseCode != null) {
      chat.statManager.appendWsDisconnectStat(
        success: true,
        errorCode: SendbirdError.webSocketConnectionClosed,
        errorDescription: "cause=$unexpectedCloseCode",
      );
    }

    // On iOS, when connection is automatically disconnected after 1 hour in idle state,
    // attempt reconnection if still in connected state after 1 second
    if (isConnected() && !webSocketClient.isConnected()) {
      if (_reconnectIfNeededTimer != null) {
        _reconnectIfNeededTimer!.cancel();
      }
      _reconnectIfNeededTimer = Timer(const Duration(seconds: 1), () async {
        if (isConnected() && !webSocketClient.isConnected()) {
          sbLog.d(StackTrace.current, '_reconnectIfNeeded()');
          await _reconnectIfNeeded();
        }
      });
    }
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
    List<Command> commands = CommandManager.parseCommandsString(commandString);
    if (commands.isEmpty) return;

    runZonedGuarded(() async {
      try {
        for (final command in commands) {
          await chat.commandManager.processCommand(command);
        }
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
    await _reconnectIfNeeded();
  }

  Future<void> _reconnectIfNeeded() async {
    sbLog.d(StackTrace.current);
    if (chat.chatContext.currentUser != null) {
      // Don't reconnect while the app is backgrounded/hidden: reconnecting into a
      // suspended/throttled app just churns (the socket dies again -> ping_pong ->
      // retry). Disconnect and let the foreground/resume path reconnect
      // (DisconnectedState.enterForeground -> doReconnect). Matches chat-js's
      // "defer reconnect while hidden". (CLNP-8835)
      if (chat.isBackground) {
        sbLog.i(StackTrace.current,
            'ws closed while backgrounded; defer reconnect until foreground');
        // Only ConnectedState needs the fromEnterBackground re-check: its
        // enterForeground() is a no-op, so a resume during the async teardown
        // would otherwise be lost (the disconnect commits DisconnectedState after
        // the resume already passed). Mirrors ConnectedState.enterBackground().
        // Other states can reach here via _onWebSocketError, where their own
        // disconnect() is load-bearing — e.g. DelayedConnectingState's non-logout
        // disconnect is a no-op that preserves the server backoff timer; bypassing
        // it would strand that timer and risk a duplicate reconnect. (CLNP-8835)
        if (isConnected()) {
          await doDisconnect(clear: false, fromEnterBackground: true);
        } else {
          // Non-connected states also reach here via _onWebSocketError. Those
          // whose enterForeground() is a no-op (e.g. ConnectingState) have the
          // same race — a resume during this async teardown is lost, leaving us
          // Disconnected — so replay it after the teardown. DelayedConnectingState's
          // non-logout disconnect is a no-op that keeps us non-Disconnected, so
          // its backoff timer is untouched (isDisconnected() stays false).
          // (CLNP-8835)
          await disconnect(logout: false);
          if (!chat.isBackground && isDisconnected()) {
            await enterForeground();
          }
        }
        return;
      }

      if (isReconnecting()) {
        await Future.delayed(const Duration(
            milliseconds: 1)); // [Timing issue] Because of endWsConnectStat()
        await reconnect(reset: false);
      } else {
        await disconnect(logout: false);
        await reconnect(reset: true);
      }
    }
  }

//------------------------------//
// Values
//------------------------------//
  String getDefaultApiHost() {
    final appId = chat.chatContext.appId;
    return 'api-$appId.sendbird.com';
  }

  String _getDefaultWsHost() {
    final appId = chat.chatContext.appId;
    return 'wss://ws-$appId.sendbird.com';
  }

  Map<String, String> getDefaultApiHeader() {
    return <String, String>{
      'SB-User-Agent': _sbUserAgentHeader,
      'SB-SDK-USER-AGENT': _sbSdkUserAgentHeader,
      'SendBird': _sendbirdHeader,
      'Connection': 'keep-alive',
    };
  }

  String get _sbUserAgentHeader {
    const core = '/c$sdkVersion';

    final uikitVersion = chat.extensions[Chat.extensionKeyUiKit];
    final uikit = uikitVersion != null ? '/u$uikitVersion' : '';

    final os = '/o${kIsWeb ? 'web' : Platform.operatingSystem}';

    return '${Chat.platform}$core$uikit$os';
  }

  String get _sbSdkUserAgentHeader {
    const mainSdkInfo = 'chat/${Chat.platform}/$sdkVersion';
    final deviceOsPlatform = kIsWeb ? 'web' : Platform.operatingSystem;
    final osVersion = kIsWeb ? '' : Platform.operatingSystemVersion;
    // '2.19.0 (stable) (Mon Jan 23 11:29:09 2023 -0800) on "android_arm64"'
    final platformVersion = kIsWeb ? '' : Platform.version.split(' ').first;

    final uikitVersion = chat.extensions[Chat.extensionKeyUiKit];
    final uikitInfo = 'uikit-chat/$deviceOsPlatform/${uikitVersion ?? ''}';

    return 'main_sdk_info=$mainSdkInfo'
        '&device_os_platform=$deviceOsPlatform'
        '&os_version=$osVersion'
        '&platform_version=$platformVersion'
        '&extension_sdk_info=$uikitInfo';
  }

  String get _sendbirdHeader {
    var headers = [
      Chat.platform,
      kIsWeb ? '' : Platform.version.split(' ').first, // empty platform version
      sdkVersion,
      chat.chatContext.appId,
      chat.chatContext.appVersion ?? '',
      kIsWeb ? 'web' : Platform.operatingSystem,
      kIsWeb ? '' : Platform.operatingSystemVersion,
    ];
    return headers.join(',');
  }

  Future<Map<String, String>> _getWebSocketParams({
    required String userId,
  }) async {
    final appId = chat.chatContext.appId;
    final appVersion = chat.chatContext.appVersion;

    int configTs = await MessageRetentionManager().getConfigTs() ?? 0;
    String? uikitVersion = chat.extensions[Chat.extensionKeyUiKit];

    return {
      'p': Chat.platform,
      if (!kIsWeb) 'pv': Platform.version.split(' ').first,
      'o': kIsWeb ? 'web' : Platform.operatingSystem,
      if (!kIsWeb) 'ov': Platform.operatingSystemVersion,
      'sv': sdkVersion,
      'ai': appId,
      if (appVersion != null && appVersion != '') 'av': appVersion,
      'config_ts': configTs.toString(), // To get config_sync_needed
      if (uikitVersion != null) 'uikit_config': '1',
    };
  }
}
