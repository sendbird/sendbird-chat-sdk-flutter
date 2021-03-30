import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';

import 'sendbird_sdk_streams.dart';

import '../../core/models/options.dart';
import '../../core/models/state.dart';
import '../../core/models/error.dart';
import '../../core/models/user.dart';
import '../../services/connection/connection_manager.dart';
import '../../constant/contants.dart' as Constants;
import '../../handlers/event_manager.dart';
import '../../services/command/command_manager.dart';
import '../../services/session/session_manager.dart';
import '../../services/db/memory_cache_service.dart';
import '../../services/network/api_client.dart';
import '../../services/network/websocket_client.dart';
import '../../utils/logger.dart';
import '../../utils/parsers.dart';
import '../../utils/async/async_operation.dart';
import '../../utils/async/async_queue.dart';

const sdk_version = '3.0.6';

/// Internal implementation for main class. Do not directly access this class.
class SendbirdSdkInternal with WidgetsBindingObserver {
  SendbirdState _state = SendbirdState();
  MemoryCacheStorage _cache = MemoryCacheStorage();

  SessionManager _sessionManager = SessionManager();
  EventManager _eventManager = EventManager();
  CommandManager _cmdManager = CommandManager();
  StreamManager _streamManager = StreamManager();

  ApiClient _api = ApiClient();
  WebSocketClient _webSocket;
  Completer<User> _loginCompleter;

  Options _options;
  Map<String, AsyncQueue> _messageQueues = {};

  Timer _reconnectTimer;
  ConnectivityResult _connectionResult;
  StreamSubscription _connectionSub;
  AsyncQueue _commandQueue = AsyncQueue<String>();
  Map<String, String> _extensions = {};
  List<String> _extraDatas = [
    Constants.SbExtraDataPremiumFeatureList,
    Constants.SbExtraDataFileUploadSizeLimit,
    Constants.SbExtraDataApplicationAttributes,
    Constants.SbExtraDataEmojiHash,
  ];

  //should only keep one instance
  SendbirdSdkInternal({
    String appId,
    String apiToken,
    Options options,
  }) : _options = options {
    _api.initialize(appId: appId, token: apiToken);
    _state.appId = appId;

    WidgetsBinding.instance?.addObserver(this);
    _listenConnectionEvents();
  }

  // getters  and setters

  SendbirdState get state => _state;
  MemoryCacheStorage get cache => _cache;
  SessionManager get sessionManager => _sessionManager;
  EventManager get eventManager => _eventManager;
  CommandManager get cmdManager => _cmdManager;
  StreamManager get streamManager => _streamManager;
  ApiClient get api => _api;
  WebSocketClient get webSocket => _webSocket;
  Completer<User> get loginCompleter => _loginCompleter;
  Options get options => _options;
  void setOptions(Options options) => _options = options ?? Options();
  AsyncQueue getMsgQueue(String channelUrl) =>
      _messageQueues[channelUrl] ?? AsyncQueue();
  void setMsgQueue(String channelUrl, AsyncQueue queue) =>
      _messageQueues[channelUrl] = queue;

  // socket callbacks

  /// Callback to handle socket connect
  void _onWebSocketConnect() {}

  /// Callback to handle socket disconnect
  void _onWebSocketDisconnect() {
    _state.connected = false;
    _cmdManager.clearCompleters(error: WebSocketDisconnectError());
  }

  /// Callback to handle incoming data from socket
  void _onWebSocketData(dynamic data) async {
    if (data == null) {
      return;
    }
    String stringCommand;

    if (data.runtimeType == String) {
      stringCommand = (data as String);
    } else {
      stringCommand =
          Utf8Decoder(allowMalformed: true).convert(data as List<int>);
    }

    if (stringCommand.isEmpty) {
      return;
    }

    //NOTE: compute does not gaurantee the order of commands
    final op = AsyncTask<String>(func: parseCommand, arg: stringCommand);
    final cmd = await _commandQueue.enqueue(op);
    // cmdManager.processCommand(cmd);
    runZoned(() async {
      try {
        _cmdManager.processCommand(cmd);
      } catch (e) {
        throw e;
      }
    }, onError: (e, s) {
      //handle error how to toss this..?
      //get waiting func and error?
      if (_loginCompleter != null)
        _loginCompleter?.completeError(e);
      else
        logger.e('[Sendbird] fatal error thrown ${e.toString()}');
      // throw e;
    });
  }

  /// Callback to handle socket error
  void _onWebSocketError(Object error) {
    if (_state.currentUser != null) {
      reconnect(reset: false);
    } else {
      throw WebSocketError();
    }
  }

  /// Connect websocket with given [userId]
  ///
  /// [apiHost] and [wsHost] are optional in case to connect own server
  Future<User> connect({
    String userId,
    String accessToken,
    String apiHost,
    String wsHost,
    bool reconnect = false,
  }) async {
    if (userId == null || userId.isEmpty) {
      throw InvalidParameterError();
    }

    userId = userId.trim();
    String sessionKey;

    if (!reconnect) {
      // already connected
      if (_state.connected && _state.userId == userId) {
        return _state.currentUser;
      }

      // is already in progress to connect
      if (_state.connecting &&
          _state.userId == userId &&
          _loginCompleter != null) {
        return _loginCompleter.future;
      }
    } else {
      sessionKey = await _sessionManager.getSessionKey();
      if (sessionKey == '' || sessionKey == null) {
        ConnectionManager.flushCompleters(error: ConnectionRequiredError());
        _eventManager.notifyReconnectionFailed();
        return null;
      }
      if (!_state.reconnecting) _eventManager.notifyReconnectionStarted();
    }

    _state.userId = userId;
    _state.connecting = true;

    _streamManager.reset();
    _loginCompleter = Completer();

    _webSocket?.close();
    _webSocket = WebSocketClient(
      _onWebSocketConnect,
      _onWebSocketDisconnect,
      _onWebSocketData,
      _onWebSocketError,
    );

    apiHost = reconnect ? _state.apiHost : apiHost ?? _getDefaultApiHost();
    wsHost = reconnect ? _state.wsHost : wsHost ?? _getDefaultWsHost();

    _sessionManager.setAccessToken(accessToken);

    _state
      ..reconnecting = reconnect
      ..wsHost = wsHost
      ..apiHost = apiHost;

    _api.initialize(baseUrl: apiHost, headers: {
      'SB-User-Agent': this._sbUserAgent,
      'User-Agent': 'flutter/$sdk_version',
    });

    var params = {
      'p': Platform.operatingSystem,
      'pv': Platform.operatingSystemVersion, //device_info
      'sv': sdk_version,
      'ai': _state.appId,
      if (reconnect && sessionKey != null)
        'key': sessionKey
      else
        'user_id': userId,
      'SB-User-Agent': this._sbUserAgent,
      'include_extra_data': _extraDatas.join(','),
      'expiring_session':
          _eventManager.getHandler(type: EventType.session) != null ? '1' : '0',
      if (accessToken != null) 'access_token': accessToken,
    };

    final fullWsHost = wsHost + '/?' + Uri(queryParameters: params).query;

    await _webSocket.connect(fullWsHost);
    final user = await _loginCompleter.future
        .timeout(Duration(seconds: options.connectionTimeout), onTimeout: () {
      logout();
      throw WebSocketTimeoutError();
    });

    ConnectionManager.flushCompleters(
        error: reconnect ? null : ConnectionClosedError());

    _loginCompleter = null;
    _reconnectTimer = null;
    return user;
  }

  void logout() {
    logger.i('[Sendbird] logout');

    _sessionManager = SessionManager();
    _cache = MemoryCacheStorage();
    _eventManager = EventManager();
    _cmdManager = CommandManager();
    _streamManager.reset();

    _api = ApiClient();
    _api.initialize(appId: _state.appId);

    _state = SendbirdState()..appId = _state.appId;
    _webSocket?.close();
    _webSocket = null;

    WidgetsBinding.instance?.removeObserver(this);
    _connectionSub?.cancel();

    _commandQueue.cleanUp();
    _messageQueues = {};
    _loginCompleter = null;

    ConnectionManager.flushCompleters(error: ConnectionClosedError());
  }

  /// Reconnects websocket
  void reconnect({bool reset = false}) {
    if (reset) {
      _reconnectTimer?.cancel();
      _reconnectTimer = null;
      _state.resetReconnectTask();
    }

    if (_reconnectTimer != null) return;

    final task = _state.reconnectTask;
    if (task.exceedRetryCount && task.hasRetriedLastChance) {
      task.increaseRetryCount();
      _state.reconnecting = false;
      _eventManager.notifyReconnectionFailed();
      return;
    }

    final backoffPeriod = task.backOffPeriod;
    task.increaseRetryCount();
    _state.reconnecting = true;

    _reconnectTimer = Timer(Duration(seconds: backoffPeriod), () {
      connect(
        reconnect: true,
        userId: _state.userId,
        accessToken: _sessionManager.accessToken,
      );
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) _handleEnterBackground();
    if (state == AppLifecycleState.resumed) _handleEnterForeground();
  }

  _handleEnterBackground() {
    _cache.markAsDirtyAll();
    //clear all timers
    _state.connected = false;
    _state.connecting = false;
    _state.reconnecting = false;
    _webSocket.close();
  }

  _handleEnterForeground() async {
    //need to connect with existing session key
    //if previously connected
    //reconnecting
    if (_state.currentUser != null)
      await connect(userId: _state.userId, reconnect: true);
  }

  void _listenConnectionEvents() {
    //do not run connectivity on test
    bool isTest = Platform.environment['FLUTTER_TEST'] == 'true';
    if (!isTest) {
      _connectionSub = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        switch (result) {
          case ConnectivityResult.none:
            logger.i('[Sendbird] connection has been lost');
            break;
          case ConnectivityResult.mobile:
          case ConnectivityResult.wifi:
            if (_connectionResult == ConnectivityResult.none &&
                _state.sessionKey != null) {
              reconnect(reset: true);
            }
        }
      });
    }
  }

  String _getDefaultApiHost() {
    return 'api-' + _state.appId + '.sendbird.com';
  }

  String _getDefaultWsHost() {
    return 'wss://ws-' + _state.appId + '.sendbird.com';
  }

  String get _sbUserAgent {
    final uikitVersion = _extensions[Constants.SbExtensionKeyUIKit];
    final core = '/c$sdk_version';
    final uikit = uikitVersion != null ? '/u$uikitVersion' : '';
    return 'flutter$core$uikit';
  }

  void addVersionExtension(String key, String version) {
    if (key != Constants.SbExtensionKeyUIKit ||
        key != Constants.SbExtensionKeySyncManager) {
      return;
    }
    _extensions[key] = version;
  }
}
