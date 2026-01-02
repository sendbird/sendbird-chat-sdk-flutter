// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_context/chat_context.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/command/command.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/sendbird_error.dart';
import 'package:universal_io/io.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

typedef OnWebSocketConnected = void Function();
typedef OnWebSocketClosed = void Function();
typedef OnWebSocketData = Future<void> Function(dynamic data);
typedef OnWebSocketError = Future<void> Function(Object error);

class WebSocketClient {
  WebSocketChannel? _webSocketChannel;
  String? _url;
  StreamSubscription? _streamSubscription;
  Completer<bool>? _onDoneCompleter;

  bool _isConnected = false;
  bool _isClosing = false; // Track if close is in progress
  bool _isCleanedUp = false; // Track if cleanup has been done
  final _closeLock = Object(); // Lock for synchronization
  int _lastActiveAt = 0;
  Timer? _pingTimer;
  Timer? _watchdogTimer;
  Timer? _forceCloseTimer; // Timer for force cleanup

  int? connectedTs;
  dynamic testData;

  final Chat _chat;
  final ChatContext _chatContext;
  final OnWebSocketConnected _onWebSocketConnected;
  final OnWebSocketClosed _onWebSocketClosed;
  final OnWebSocketData _onWebSocketData;
  final OnWebSocketError _onWebSocketError;

  WebSocketClient({
    required Chat chat,
    required ChatContext chatContext,
    required OnWebSocketConnected onWebSocketConnected,
    required OnWebSocketClosed onWebSocketClosed,
    required OnWebSocketData onWebSocketData,
    required OnWebSocketError onWebSocketError,
  })  : _chat = chat,
        _chatContext = chatContext,
        _onWebSocketConnected = onWebSocketConnected,
        _onWebSocketClosed = onWebSocketClosed,
        _onWebSocketData = onWebSocketData,
        _onWebSocketError = onWebSocketError;

  void connect({
    required String url,
    String? accessToken,
    String? sessionKey,
    bool reconnect = false,
  }) {
    if (url == _url && _isConnected) return;

    sbLog.d(StackTrace.current, '[url] $url');

    // Wait for any ongoing close operation to complete and clean up if needed
    bool shouldCleanup = false;
    bool isClosing = false;
    synchronized(_closeLock, () {
      isClosing = _isClosing;
      if (_webSocketChannel != null) {
        // Have existing connection - need cleanup
        shouldCleanup = true;
      }
      // Reset cleanup state for new connection
      _isCleanedUp = false;
    });

    if (shouldCleanup) {
      sbLog.d(StackTrace.current, 'Cleaning up - isClosing: $isClosing');
      _cleanUp();
    }

    connectedTs = null;
    runZonedGuarded(() async {
      Completer? reconnectTimeoutCompleter;

      if (kIsWeb) {
        List<String> protocols = [];
        if (sessionKey != null) {
          protocols.add(
            Uri.encodeComponent(jsonEncode({'auth': sessionKey})),
          );
        } else if (accessToken != null) {
          protocols.add(
            Uri.encodeComponent(jsonEncode({'token': accessToken})),
          );
        }

        _webSocketChannel = WebSocketChannel.connect(
          Uri.parse(url),
          protocols: protocols,
        );

        if (reconnect) {
          reconnectTimeoutCompleter = Completer();
          reconnectTimeoutCompleter.future.timeout(
              Duration(seconds: _chat.chatContext.options.connectionTimeout),
              onTimeout: () async {
            await close();

            final exception = WebSocketFailedException(
              message: 'Reconnection timeout on web',
            );

            _onError(exception);
            throw exception;
          });
        }
      } else {
        Map<String, String> headers = {};
        if (sessionKey != null) {
          headers['SENDBIRD-WS-AUTH'] = sessionKey;
        } else if (accessToken != null) {
          headers['SENDBIRD-WS-TOKEN'] = accessToken;
        }

        _webSocketChannel = IOWebSocketChannel.connect(
          Uri.parse(url),
          headers: headers,
          connectTimeout: reconnect
              ? Duration(seconds: _chat.chatContext.options.connectionTimeout)
              : null,
        );
      }

      _url = url;
      _isConnected = true;

      _webSocketChannel?.ready.then((value) {
        if (_isConnected) {
          connectedTs = DateTime.now().millisecondsSinceEpoch;
          reconnectTimeoutCompleter?.complete();
          _onWebSocketConnected();
        }
      }).catchError((error) {
        sbLog.e(StackTrace.current, 'WebSocket ready failed: $error');
        // Error will be handled by stream onError
      });

      _streamSubscription = _webSocketChannel?.stream.listen(
        onData,
        onError: _onError,
        onDone: _onDone,
        cancelOnError: true,
      );

      _startPing();
    }, (e, s) {
      sbLog.e(StackTrace.current, 'e: $e');
      // Clean up on connection failure
      _isConnected = false;
      _url = null;
      _cleanUp();
      throw WebSocketFailedException(message: e.toString());
    });
  }

  Future<bool> close({
    int code = WebSocketStatus.normalClosure,
    String reason = '',
  }) async {
    // Check if already closing or already closed
    WebSocketChannel? channelToClose;
    Completer<bool>? existingCompleter;

    synchronized(_closeLock, () {
      if (_webSocketChannel == null) {
        return;
      }
      if (_isClosing) {
        existingCompleter = _onDoneCompleter;
        return;
      }
      _isClosing = true;
      channelToClose = _webSocketChannel;
    });

    // If channel is null, already closed
    if (channelToClose == null) {
      return true;
    }

    // If already closing, wait for existing operation to complete
    if (existingCompleter != null) {
      try {
        return await existingCompleter!.future;
      } catch (e) {
        return false;
      }
    }

    sbLog.d(StackTrace.current, reason.isNotEmpty ? 'reason: $reason' : '');

    _url = null;
    _isConnected = false;

    _stopPing();
    _stopWatchdog();

    try {
      // Create completer for tracking close completion
      final localCompleter = Completer<bool>();
      synchronized(_closeLock, () {
        _onDoneCompleter = localCompleter;
      });

      // Cancel any existing force close timer
      _cancelForceCloseTimer();

      // Start force cleanup timer (3 seconds)
      _forceCloseTimer = Timer(const Duration(seconds: 3), () {
        sbLog.w(StackTrace.current, 'Force closing due to timeout');
        _forceCleanup();
      });

      // This should trigger callback for onDone().
      // Don't await here to prevent potential deadlock
      channelToClose?.sink.close(code, reason);

      final result = await localCompleter.future.then((value) {
        _cancelForceCloseTimer();
        synchronized(_closeLock, () {
          _isClosing = false;
        });
        return value;
      }).timeout(
        const Duration(milliseconds: 500),
        onTimeout: () {
          _cancelForceCloseTimer();
          synchronized(_closeLock, () {
            _isClosing = false;
          });
          _cleanUp();
          _onWebSocketClosed();
          return false;
        },
      );
      return result;
    } catch (e) {
      sbLog.e(StackTrace.current, 'e: $e');
      _cancelForceCloseTimer();
      synchronized(_closeLock, () {
        _isClosing = false;
        // Clean up completer to prevent memory leak
        if (_onDoneCompleter != null && !_onDoneCompleter!.isCompleted) {
          _onDoneCompleter = null;
        }
      });
      _onError(e);
      return false;
    }
  }

  void send(String data) {
    if (!_isConnected) {
      throw WebSocketFailedException();
    }

    runZonedGuarded(() {
      _webSocketChannel?.sink.add(data);
    }, (e, s) {
      sbLog.e(StackTrace.current, 'e: $e');
      throw WebSocketFailedException(message: e.toString());
    });
  }

  bool isConnected() {
    return _isConnected;
  }

  int? getCloseCode() {
    return _webSocketChannel?.closeCode;
  }

  void setTestData(dynamic data) {
    testData = data;
  }

  Future<void> onData(dynamic data) async {
    _lastActiveAt = DateTime.now().millisecondsSinceEpoch;
    _stopWatchdog();

    if (testData != null) {
      data = testData;
    }
    await _onWebSocketData(data);
    testData = null;
  }

  Future<void> _onError(Object error) async {
    sbLog.d(StackTrace.current, 'error: $error');

    // Clean up regardless of closing state for error scenarios
    _cleanUp();
    await _onWebSocketError(error);
  }

  void _onDone() {
    sbLog.d(StackTrace.current);

    bool shouldComplete = false;
    bool wasClosing = false;
    bool wasCleanedUp = false;
    Completer<bool>? completerToComplete;

    synchronized(_closeLock, () {
      wasClosing = _isClosing;
      wasCleanedUp = _isCleanedUp;
      if (_onDoneCompleter != null && !_onDoneCompleter!.isCompleted) {
        shouldComplete = true;
        completerToComplete = _onDoneCompleter;
        _onDoneCompleter = null;
      }
    });

    // Avoid duplicate cleanup and callback
    if (wasCleanedUp) {
      return;
    }

    // Cancel force timer since we got onDone callback
    _cancelForceCloseTimer();

    if (shouldComplete && completerToComplete != null) {
      try {
        completerToComplete!.complete(true);
      } catch (e) {
        // Completer may already be completed, ignore
        sbLog.d(
            StackTrace.current, 'Completer already completed in _onDone: $e');
      }
      _cleanUp();
      _onWebSocketClosed();
    } else if (wasClosing) {
      // If we're closing but no completer to complete, still need to clean up
      _cleanUp();
      _onWebSocketClosed();
    } else {
      // onDone called without close() - unexpected disconnection
      _cleanUp();
      _onWebSocketClosed(); // Need to notify about disconnection
    }
  }

  void _cleanUp() {
    sbLog.d(StackTrace.current);

    bool alreadyCleaned = false;
    synchronized(_closeLock, () {
      if (_isCleanedUp) {
        alreadyCleaned = true;
      } else {
        _isCleanedUp = true;
      }
    });

    if (alreadyCleaned) {
      return;
    }

    _stopPing();
    _stopWatchdog();
    _cancelForceCloseTimer();
    _isConnected = false;

    // Cancel stream subscription before nullifying channel
    try {
      _streamSubscription?.cancel();
    } catch (e) {
      sbLog.e(StackTrace.current, 'Error cancelling stream subscription: $e');
    }

    _streamSubscription = null;
    _webSocketChannel = null;

    synchronized(_closeLock, () {
      _isClosing = false;
    });
  }

  void _forceCleanup() {
    sbLog.w(StackTrace.current, 'Forcing cleanup');

    bool shouldCleanup = false;
    bool wasCleanedUp = false;
    Completer<bool>? completerToComplete;

    synchronized(_closeLock, () {
      wasCleanedUp = _isCleanedUp;
      if (!wasCleanedUp &&
          _onDoneCompleter != null &&
          !_onDoneCompleter!.isCompleted) {
        completerToComplete = _onDoneCompleter;
        _onDoneCompleter = null;
        shouldCleanup = true;
      }
    });

    if (shouldCleanup && completerToComplete != null) {
      try {
        completerToComplete!.complete(false);
      } catch (e) {
        // Completer may already be completed, ignore
        sbLog.d(StackTrace.current, 'Completer already completed: $e');
      }
      _cleanUp();
      _onWebSocketClosed();
    } else if (!wasCleanedUp) {
      // Even if no completer, we should still cleanup
      _cleanUp();
      _onWebSocketClosed();
    }
  }

  void _cancelForceCloseTimer() {
    _forceCloseTimer?.cancel();
    _forceCloseTimer = null;
  }

  // Helper method for synchronization
  T synchronized<T>(Object lock, T Function() action) {
    // Dart is single-threaded, but we still need to ensure
    // atomic operations for async event handling.
    // This is a simplified version - in production, consider using
    // a proper synchronization package like synchronized or mutex
    //
    // For now, we rely on Dart's event loop guarantees:
    // Synchronous code blocks are atomic between await points
    return action();
  }

  void _startPing() {
    _pingTimer?.cancel();
    _pingTimer =
        Timer.periodic(Duration(seconds: _chatContext.pingInterval), (timer) {
      var now = DateTime.now().millisecondsSinceEpoch;
      if (now - _lastActiveAt >= (_chatContext.pingInterval - 1) * 1000) {
        _lastActiveAt = now;
        send(Command.buildPing().encode());
        _startWatchdog();
      }
    });
    _watchdogTimer?.cancel();
  }

  void _stopPing() {
    _pingTimer?.cancel();
    _pingTimer = null;
  }

  void _startWatchdog() {
    _watchdogTimer?.cancel();
    _watchdogTimer = Timer(
      Duration(seconds: _chatContext.watchdogInterval),
      () async {
        _chat.statManager.appendWsDisconnectStat(
          success: true,
          errorCode: SendbirdError.networkError,
          errorDescription: "cause=ping_pong_timedout",
        );

        await _onError(SendbirdException(message: 'Watchdog timeout'));
      },
    );
  }

  void _stopWatchdog() {
    _watchdogTimer?.cancel();
    _watchdogTimer = null;
  }
}
