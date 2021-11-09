import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';

import 'package:sendbird_sdk/constant/contants.dart' as constants;
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/options.dart';
import 'package:sendbird_sdk/core/models/state.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/managers/command_manager.dart';
import 'package:sendbird_sdk/managers/connection_manager.dart';
import 'package:sendbird_sdk/managers/event_manager.dart';
import 'package:sendbird_sdk/managers/session_manager.dart';
import 'package:sendbird_sdk/sdk/internal/sendbird_sdk_streams.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbird_sdk/services/db/memory_cache_service.dart';
import 'package:sendbird_sdk/services/network/api_client.dart';
import 'package:sendbird_sdk/services/network/websocket_client.dart';
import 'package:sendbird_sdk/utils/async/async_operation.dart';
import 'package:sendbird_sdk/utils/async/async_queue.dart';
import 'package:sendbird_sdk/utils/logger.dart';
import 'package:sendbird_sdk/utils/parsers.dart';

const sdk_version = '3.1.6';
const platform = 'flutter';

/// Internal implementation for main class. Do not directly access this class.
class SendbirdSdkInternal with WidgetsBindingObserver {
  SendbirdState _state = SendbirdState();
  MemoryCacheStorage _cache = MemoryCacheStorage();

  SessionManager _sessionManager = SessionManager();
  EventManager _eventManager = EventManager();
  CommandManager _cmdManager = CommandManager();
  StreamManager _streamManager = StreamManager();

  late ApiClient _api;
  WebSocketClient? _webSocket;
  Completer<User>? _loginCompleter;

  late Options _options;
  AsyncQueue _commandQueue = AsyncQueue<String>();
  Map<String, AsyncQueue> _messageQueues = {};
  Map<String, AsyncSimpleTask> _uploads = {};

  Timer? _reconnectTimer;
  ConnectivityResult? _connectionResult;
  StreamSubscription? _connectionSub;

  Map<String, String> _extensions = {};
  List<String> _extraDatas = [
    constants.sbExtraDataPremiumFeatureList,
    constants.sbExtraDataFileUploadSizeLimit,
    constants.sbExtraDataApplicationAttributes,
    constants.sbExtraDataEmojiHash,
  ];

  bool registered = false;

  //should only keep one instance
  SendbirdSdkInternal({
    String? appId,
    String? apiToken,
    Options? options,
  }) {
    // _api.initialize(appId: appId, token: apiToken);
    _state
      ..appId = appId
      ..token = apiToken;

    _options = options ?? Options();
    _api = ApiClient(state: _state, appId: appId, token: apiToken);

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
  WebSocketClient? get webSocket => _webSocket;
  Completer<User>? get loginCompleter => _loginCompleter;
  Options get options => _options;
  void setOptions(Options options) => _options = options;
  AsyncQueue getMsgQueue(String channelUrl) =>
      _messageQueues[channelUrl] ?? AsyncQueue();
  void setMsgQueue(String channelUrl, AsyncQueue queue) =>
      _messageQueues[channelUrl] = queue;
  AsyncSimpleTask? getUploadTask(String requestId) => _uploads[requestId];
  void setUploadTask(String requestId, AsyncSimpleTask task) =>
      _uploads[requestId] = task;

  // socket callbacks
  /// Callback to handle socket connect
  void _onWebSocketConnect() {}

  /// Callback to handle socket disconnect
  void _onWebSocketDisconnect() {
    _state.connected = false;
    _cmdManager.clearCompleters(error: WebSocketConnectionFailed());
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

    runZonedGuarded(() async {
      try {
        _cmdManager.processCommand(cmd);
      } catch (e) {
        rethrow;
      }
    }, (e, s) {
      if (_loginCompleter != null) {
        _loginCompleter?.completeError(e);
      } else {
        logger.e('fatal error thrown ${e.toString()}');
      }
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
    required String userId,
    String? nickname,
    String? accessToken,
    String? apiHost,
    String? wsHost,
    bool reconnect = false,
  }) async {
    if (userId.isEmpty) {
      throw InvalidParameterError();
    }

    userId = userId.trim();
    String? sessionKey;

    // already connected
    if (_state.connected && _state.userId == userId && !reconnect) {
      return _state.currentUser!;
    }

    // is already in progress to connect
    if ((_state.connecting || _state.reconnecting) &&
        _state.userId == userId &&
        _loginCompleter != null) {
      return _loginCompleter!.future;
    }

    if (reconnect) {
      sessionKey = await _sessionManager.getSessionKey();
      if (sessionKey == null || sessionKey.isEmpty) {
        ConnectionManager.flushCompleters(error: ConnectionRequiredError());
        _eventManager.notifyReconnectionFailed();
        throw ConnectionFailedError();
      }
      _eventManager.notifyReconnectionStarted();
    } else {
      // start from clean slate
      await logout();
    }

    await _webSocket?.close();

    _state.userId = userId;
    _state.connecting = true;

    _webSocket = WebSocketClient(
      onConnect: _onWebSocketConnect,
      onDisconnect: _onWebSocketDisconnect,
      onData: _onWebSocketData,
      onError: _onWebSocketError,
    );

    _sessionManager.setAccessToken(accessToken);

    final apiHostUrl =
        reconnect ? _state.apiHost! : apiHost ?? _getDefaultApiHost();
    final wsHostUrl =
        reconnect ? _state.wsHost! : wsHost ?? _getDefaultWsHost();

    _state
      ..reconnecting = reconnect
      ..apiHost = apiHostUrl
      ..wsHost = wsHostUrl;

    _api.initialize(baseUrl: apiHostUrl, headers: {
      'SB-User-Agent': _sbUserAgent,
      'User-Agent':
          '$platform/$sdk_version/${Platform.operatingSystem.toLowerCase()}',
    });

    var params = {
      'p': platform,
      'pv': Platform.version.split(' ').first,
      'o': Platform.operatingSystem, // os
      'ov': Platform.operatingSystemVersion, // os version
      'sv': sdk_version,
      'ai': _state.appId,
      if (nickname != null && nickname != '') 'nickname': nickname,
      if (reconnect && sessionKey != null)
        'key': sessionKey
      else
        'user_id': userId,
      'SB-User-Agent': _sbUserAgent,
      'include_extra_data': _extraDatas.join(','),
      'expiring_session':
          _eventManager.getHandler<SessionEventHandler>() != null ? '1' : '0',
      if (accessToken != null) 'access_token': accessToken,
    };

    final fullWsHost = wsHostUrl + '/?' + Uri(queryParameters: params).query;

    try {
      await _webSocket?.connect(fullWsHost);
    } catch (e) {
      _state.connecting = false;
      _state.reconnecting = false;
      rethrow;
    }

    _loginCompleter = Completer();
    final user = await _loginCompleter!.future.timeout(
        Duration(seconds: options.connectionTimeout), onTimeout: () async {
      await logout();
      throw LoginTimeoutError();
    });

    ConnectionManager.flushCompleters(
        error: reconnect ? null : ConnectionClosedError());

    if (!registered) {
      WidgetsBinding.instance?.addObserver(this);
      registered = true;
    }

    _loginCompleter = null;
    _reconnectTimer = null;
    return user;
  }

  Future<void> logout() async {
    logger.i('logout');

    if (state.reconnecting) {
      eventManager.notifyReconnectionCanceled();
    }

    _sessionManager = SessionManager();
    _cache = MemoryCacheStorage();
    _cmdManager = CommandManager();
    _streamManager.reset();

    _commandQueue.cleanUp();
    _messageQueues.forEach((key, q) => q.cleanUp());
    _messageQueues = {};
    // _uploads.forEach((key, value) => _api.cancelUploadingFile(key));
    _uploads = {};

    _loginCompleter = null;

    // _api = ApiClient();
    // _api.initialize(appId: _state.appId);

    _state.cleanUp();
    await _webSocket?.close();
    _webSocket = null;

    WidgetsBinding.instance?.removeObserver(this);
    registered = false;
    _connectionSub?.cancel();

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
    if (task == null) throw MisConfigurationError();
    if (task.exceedRetryCount && task.hasRetriedLastChance) {
      task.increaseRetryCount();
      _state.reconnecting = false;
      _eventManager.notifyReconnectionFailed();
      return;
    }

    final backoffPeriod = task.backOffPeriod;
    task.increaseRetryCount();
    _state.reconnecting = true;

    _reconnectTimer = Timer(Duration(seconds: backoffPeriod), () async {
      await connect(
        reconnect: true,
        userId: _state.userId ?? '',
        accessToken: _sessionManager.accessToken,
      );
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) _handleEnterBackground();
    if (state == AppLifecycleState.resumed) _handleEnterForeground();
  }

  void _handleEnterBackground() {
    _cache.markAsDirtyAll();
    //clear all timers
    _state.connected = false;
    _state.connecting = false;
    _state.reconnecting = false;
    _webSocket?.close();
  }

  void _handleEnterForeground() async {
    if (_state.userId != null) {
      reconnect();
    }
  }

  void _listenConnectionEvents() {
    //NOTE: do not run connectivity on test
    final isTest = Platform.environment['FLUTTER_TEST'] == 'true';
    if (!isTest) {
      _connectionSub = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        switch (result) {
          case ConnectivityResult.none:
            logger.i('connection has been lost');
            break;
          case ConnectivityResult.mobile:
          case ConnectivityResult.wifi:
            if (_connectionResult == ConnectivityResult.none &&
                _state.sessionKey != null) {
              reconnect(reset: true);
            }
        }
        _connectionResult = result;
      });
    }
  }

  String _getDefaultApiHost() {
    final appId = _state.appId;
    if (appId == null) throw MisConfigurationError();
    return 'api-' + appId + '.sendbird.com';
  }

  String _getDefaultWsHost() {
    final appId = _state.appId;
    if (appId == null) throw MisConfigurationError();
    return 'wss://ws-' + appId + '.sendbird.com';
  }

  String get _sbUserAgent {
    final uikitVersion = _extensions[constants.sbExtensionKeyUIKit];
    final core = '/c$sdk_version';
    final uikit = uikitVersion != null ? '/u$uikitVersion' : '';
    final os = '/o${Platform.operatingSystem.toLowerCase()}';
    return '$platform$core$uikit$os';
  }

  void addVersionExtension(String key, String version) {
    if (key != constants.sbExtensionKeyUIKit ||
        key != constants.sbExtensionKeySyncManager) {
      return;
    }
    _extensions[key] = version;
  }
}
