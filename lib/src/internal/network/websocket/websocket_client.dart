// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';

import 'package:sendbird_chat_sdk/src/internal/main/chat_context/chat_context.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/command/command.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:universal_io/io.dart';
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
  int _lastActiveAt = 0;
  Timer? _pingTimer;
  Timer? _watchdogTimer;

  final ChatContext _chatContext;
  final OnWebSocketConnected _onWebSocketConnected;
  final OnWebSocketClosed _onWebSocketClosed;
  final OnWebSocketData _onWebSocketData;
  final OnWebSocketError _onWebSocketError;

  WebSocketClient({
    required ChatContext chatContext,
    required OnWebSocketConnected onWebSocketConnected,
    required OnWebSocketClosed onWebSocketClosed,
    required OnWebSocketData onWebSocketData,
    required OnWebSocketError onWebSocketError,
  })  : _chatContext = chatContext,
        _onWebSocketConnected = onWebSocketConnected,
        _onWebSocketClosed = onWebSocketClosed,
        _onWebSocketData = onWebSocketData,
        _onWebSocketError = onWebSocketError;

  void connect(String url) {
    if (url == _url && _isConnected) return;

    sbLog.d(StackTrace.current, '[url] $url');

    runZonedGuarded(() {
      _webSocketChannel = WebSocketChannel.connect(Uri.parse(url)); // Check
      _streamSubscription = _webSocketChannel?.stream.listen(
        _onData,
        onError: _onError,
        onDone: _onDone,
        cancelOnError: true,
      );

      _url = url;
      _isConnected = true;

      _startPing();
      _onWebSocketConnected();
    }, (e, s) {
      sbLog.e(StackTrace.current, 'e: $e');
      throw WebSocketFailedException(message: e.toString());
    });
  }

  Future<bool> close({
    int code = WebSocketStatus.normalClosure,
    String reason = '',
  }) async {
    if (_webSocketChannel == null) return true;

    sbLog.d(StackTrace.current, reason.isNotEmpty ? 'reason: $reason' : '');

    _url = null;
    _isConnected = false;

    _stopPing();
    _stopWatchdog();

    try {
      _onDoneCompleter = Completer<bool>();
      // This should trigger callback for onDone().
      await _webSocketChannel?.sink.close(code, reason);

      final result = await _onDoneCompleter?.future
          .then((value) => value)
          .onError((error, stackTrace) {
        _onDoneCompleter = null;
        _onDone();
        return false;
      }).timeout(const Duration(milliseconds: 500), onTimeout: () {
        _onDoneCompleter = null;
        _onDone();
        return false;
      });
      return result ?? false;
    } catch (e) {
      sbLog.e(StackTrace.current, 'e: $e');
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

  Future<void> _onData(dynamic data) async {
    _lastActiveAt = DateTime.now().millisecondsSinceEpoch;
    _stopWatchdog();
    await _onWebSocketData(data);
  }

  Future<void> _onError(Object error) async {
    sbLog.d(StackTrace.current, 'error: $error');

    _cleanUp();
    await _onWebSocketError(error);
  }

  void _onDone() {
    sbLog.d(StackTrace.current);

    if (_onDoneCompleter != null) {
      _onDoneCompleter?.complete(true);
      _onDoneCompleter = null;

      _cleanUp();
      _onWebSocketClosed();
    }
  }

  void _cleanUp() {
    sbLog.d(StackTrace.current);

    _stopPing();
    _stopWatchdog();
    _isConnected = false;
    _streamSubscription?.cancel();
    _webSocketChannel = null;
  }

  void _startPing() {
    _pingTimer?.cancel();
    _pingTimer =
        Timer.periodic(Duration(seconds: _chatContext.pingInterval), (timer) {
      var now = DateTime.now().millisecondsSinceEpoch;
      if (now - _lastActiveAt >= _chatContext.pingInterval) {
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
        await _onError(SendbirdException(message: 'Watchdog timeout'));
      },
    );
  }

  void _stopWatchdog() {
    _watchdogTimer?.cancel();
    _watchdogTimer = null;
  }
}
