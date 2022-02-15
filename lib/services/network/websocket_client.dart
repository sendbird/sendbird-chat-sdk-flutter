import 'dart:io';
import 'dart:async';

import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/command.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/utils/logger.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

typedef OnWSConnect = void Function();
typedef OnWSDisconnect = void Function();
typedef OnWSData = void Function(dynamic data);
typedef OnWSError = void Function(Object error);

class WebSocketClient {
  bool _connected = false;
  bool _disconnect = true;

  String? _url;
  WebSocketChannel? _socket;
  Stream? _rx;

  int _lastActiveAt = 0;
  int _pingInterval = 15;
  int _watchdogInterval = 5;
  Timer? _pingTimer;
  Timer? _watchdogTimer;

  StreamSubscription? _subscription;

  late OnWSConnect _functionConnect;
  late OnWSDisconnect _functionDisconnect;
  late OnWSData _functionData;
  late OnWSError _functionError;

  WebSocketClient({
    required OnWSConnect onConnect,
    required OnWSDisconnect onDisconnect,
    required OnWSData onData,
    required OnWSError onError,
  }) {
    _functionConnect = onConnect;
    _functionDisconnect = onDisconnect;
    _functionData = onData;
    _functionError = onError;
  }

  Future<void> connect(String url) async {
    if (url.length < 10) {
      logger.e('Socket url is too short');
      throw WebSocketError(message: 'Invalid URL supplied');
    }
    // already conncted on same url
    if (_connected && url == _url) return;

    var hdrs = <String, dynamic>{};
    hdrs['Content-Type'] = 'application/json;charset=utf8';

    try {
      _socket = WebSocketChannel.connect(Uri.parse(url));
      _disconnect = false;
      _connected = true;
      _url = url;

      _startPing();

      _functionConnect();
    } catch (e) {
      logger.e('Websocket connection error: ' + e.toString());
      throw WebSocketError(message: e.toString());
    }

    _rx = _socket!.stream;

    _subscription = _rx?.listen(
      onReceiveData,
      onError: onReceiveError,
      onDone: onReceiveDone,
      cancelOnError: true,
    );
  }

  Future<bool> close(
      {int code = WebSocketStatus.normalClosure, String reason = ''}) async {
    if (!_connected) {
      return true;
    }
    if (_socket == null) {
      return true;
    }

    //Prevent Re-Connect
    _disconnect = true;
    _connected = false;

    _stopPing();

    try {
      //This should trigger callback for Done()
      //And set _connected to false before returning from close
      await _socket?.sink.close(code, reason);
      _subscription?.cancel();
      _socket = null;
      logger.i('Socket closed ' + reason);
      return true;
    } catch (e) {
      onReceiveError(e);
      return false;
    }
  }

  void send(String data) {
    logger.i('Send command \n' + data);
    try {
      _socket?.sink.add(data);
    } catch (e) {
      throw WebSocketError(message: e.toString());
    }
  }

  void onReceiveData(dynamic evt) {
    _lastActiveAt = DateTime.now().millisecondsSinceEpoch;
    _stopWatchdog();
    _functionData(evt);
  }

  void onReceiveError(Object error) {
    logger.e('Websocket Error:' + error.toString());
    _functionError(error);
  }

  void onReceiveDone() async {
    _stopPing();
    _connected = false;
    _socket = null;

    _functionDisconnect();

    if (_disconnect) {
      return;
    }

    return;
  }

  bool isConnected() {
    return _connected;
  }

  ConnectionState get connectionState {
    if (_connected == true) {
      return ConnectionState.open;
    } else {
      return ConnectionState.closed;
    }
  }

  void setInterval(int seconds) {
    if (seconds < 0) return;
    _pingInterval = seconds;
  }

  void setWatchdogInterval(int seconds) {
    if (seconds < 0) return;
    _watchdogInterval = seconds;
  }

  void _startPing() {
    logger.i('Start socket ping');
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(Duration(seconds: _pingInterval), (timer) {
      var now = DateTime.now().millisecondsSinceEpoch;
      if (now - _lastActiveAt >= _pingInterval) {
        _lastActiveAt = now;
        send(Command.buildPing().encode());
        _startWatchdog();
      }
    });
    _watchdogTimer?.cancel();
  }

  void _stopPing() {
    logger.i('Stop socket ping');
    _pingTimer?.cancel();
    _pingTimer = null;
  }

  void _startWatchdog() {
    logger.i('Start watchdog');
    _watchdogTimer?.cancel();
    _watchdogTimer = Timer(
      Duration(seconds: _watchdogInterval),
      () {
        close(code: WebSocketStatus.goingAway, reason: 'Watchdog timeout');
        onReceiveError(SBError(message: 'Watchdog timeout'));
      },
    );
  }

  void _stopWatchdog() {
    logger.i('Stop watchdog');
    _watchdogTimer?.cancel();
    _watchdogTimer = null;
  }
}
