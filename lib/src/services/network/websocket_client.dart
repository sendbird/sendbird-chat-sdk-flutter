import 'dart:io';
import 'dart:async';

import '../../constant/enums.dart';
import '../../models/command.dart';
import '../../models/error.dart';
import '../../utils/logger.dart';

typedef void OnWSConnect();
typedef void OnWSDisconnect();
typedef void OnWSData(dynamic data);
typedef void OnWSError(Object error);

class WebSocketClient {
  bool _connected = false;
  bool _disconnect;
  String _url; //ConnectWithUser URL + parms
  //Completer _completer
  WebSocket _socket;
  Stream _rx;

  int _lastActiveAt = 0;
  int _pingInterval = 15;
  int _watchdogInterval = 5;
  Timer _pingTimer;
  Timer _watchdogTimer;

  StreamSubscription _subscription;
  OnWSConnect _functionConnect;
  OnWSDisconnect _functionDisconnect;
  OnWSData _functionData;
  OnWSError _functionError;

  WebSocketClient([
    OnWSConnect onConnect,
    OnWSDisconnect onDisconnect,
    OnWSData onData,
    OnWSError onError,
  ]) {
    _functionConnect = onConnect;
    _functionDisconnect = onDisconnect;
    _functionData = onData;
    _functionError = onError;
  }

  Future<void> connect(String url) async {
    if (url == null) {
      logger.e('[Sendbird] Socket url is null');
      throw WebSocketError(message: 'Invalid URL supplied');
    }
    if (url.length < 10) {
      logger.e('[Sendbird] Socket url is too short');
      throw WebSocketError(message: 'Invalid URL supplied');
    }
    // already conncted on same url
    if (_connected && url == _url) return;

    var hdrs = Map<String, dynamic>();
    hdrs['Content-Type'] = 'application/json;charset=utf8';

    try {
      _socket = await WebSocket.connect(url, headers: hdrs);
      _disconnect = false;
      _connected = true;
      _url = url;

      _startPing();

      if (_functionConnect != null) {
        _functionConnect();
      }
    } catch (e) {
      logger.e('[Sendbird] Websocket connection error: ' + e.toString());
      throw WebSocketError(message: e.toString());
    }

    _rx = _socket.asBroadcastStream();
    _subscription = _rx.listen(
      onReceiveData,
      onError: onReceiveError,
      onDone: onReceiveDone,
      cancelOnError: true,
    );
    return true;
  }

  bool close({int code = WebSocketStatus.normalClosure, String reason = ''}) {
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
      _socket.close(code, reason);
      _subscription.cancel();
      _socket = null;
      logger.i('[Sendbird] Socket closed ' + reason);
      return true;
    } catch (e) {
      onReceiveError(e);
      return false;
    }
  }

  void send(String data) {
    logger.i('[Sendbird] Send command \n' + data);
    try {
      _socket.add(data);
    } catch (e) {
      throw WebSocketError(message: e.toString());
    }
  }

  void onReceiveData(dynamic evt) {
    if (_functionData == null) {
      return;
    }
    _lastActiveAt = DateTime.now().millisecondsSinceEpoch;
    _stopWatchdog();
    _functionData(evt);
  }

  void onReceiveError(Object error) {
    logger.e('[Sendbird] Websocket Error:' + error.toString());
    if (_functionError == null) {
      return;
    }
    _functionError(error);
  }

  void onReceiveDone() async {
    _stopPing();
    _connected = false;
    _socket = null;

    if (_functionDisconnect != null) {
      _functionDisconnect();
    }

    if (_disconnect) {
      return;
    }

    return;
  }

  bool isConnected() {
    return _connected;
  }

  ConnectionState get connectionState {
    if (_socket?.readyState == WebSocket.open) {
      return ConnectionState.open;
    } else if (_socket?.readyState == WebSocket.connecting) {
      return ConnectionState.connecting;
    } else {
      return ConnectionState.closed;
    }
  }

  void setInterval(int seconds) {
    if (seconds == null) return;
    _pingInterval = seconds;
  }

  void setWatchdogInterval(int seconds) {
    if (seconds == null) return;
    _watchdogInterval = seconds;
  }

  void _startPing() {
    logger.i('[Sendbird] Start socket ping');
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(Duration(seconds: _pingInterval), (timer) {
      var now = DateTime.now().millisecondsSinceEpoch;
      if (_lastActiveAt != null && now - _lastActiveAt >= _pingInterval) {
        _lastActiveAt = now;
        send(Command.buildPing().encode());
        _startWatchdog();
      }
    });
    _watchdogTimer?.cancel();
  }

  void _stopPing() {
    logger.i('[Sendbird] Stop socket ping');
    _pingTimer?.cancel();
    _pingTimer = null;
  }

  void _startWatchdog() {
    logger.i('[Sendbird] Start watchdog');
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
    logger.i('[Sendbird] Stop watchdog');
    _watchdogTimer?.cancel();
    _watchdogTimer = null;
  }
}
