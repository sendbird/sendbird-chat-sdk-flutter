import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_io/io.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';

import 'package:sendbird_sdk/constant/contants.dart' as constants;
import 'package:sendbird_sdk/core/models/state.dart';
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
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../constant/contants.dart';

const sdk_version = '3.2.20';
const platform = 'flutter';

/// This allows a value of type T or T? to be treated as a value of type T?.
///
/// We use this so that APIs that have become non-nullable can still be used
/// with `!` and `?` to support older versions of the API as well.
T? _ambiguate<T>(T? value) => value;

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
  bool _forceReconnect = false;

  set setForceReconnect(bool isForceReconnect) =>
      _forceReconnect = isForceReconnect;

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

    _connectionResult = ConnectivityResult.none;
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

    logger.i('receive data from ws, processing from ioslate');

    //NOTE: compute does not gaurantee the order of commands
    final op = AsyncTask<String>(func: parseCommand, arg: stringCommand);
    final cmd = await _commandQueue.enqueue(op);
    if (cmd == null) {
      logger.e('parsing command failed on isolate');
      return;
    }

    logger.i('ws data parsed completed, proceed ${cmd.cmd}');

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
    logger.i("sendbird connecting....");
    if (userId.isEmpty) {
      throw InvalidParameterError();
    }

    userId = userId.trim();
    String? sessionKey;

    logger.i('Attempting to connecting with $userId');
    // already connected
    if (_state.connected &&
        _webSocket?.isConnected() == true &&
        _state.userId == userId &&
        _state.currentUser != null) {
      logger.i('already connected with $userId, return user');
      return _state.currentUser!;
    }

    // is already in progress to connect
    if ((_state.connecting || _state.reconnecting) &&
        _state.userId == userId &&
        _loginCompleter != null &&
        !_forceReconnect) {
      logger.i('waiting to connect previous call with $userId');
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
      logger.i('clearing out previous connection');
      await logout();
    }

    // This has to be above any await for concurrent situation
    if (!_forceReconnect) _loginCompleter = Completer();
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
      'SendBird': _sendbirdHeader,
    });

    var params = {
      if (nickname != null && nickname != '') 'nickname': nickname,
      if (reconnect && sessionKey != null)
        'key': sessionKey
      else
        'user_id': userId,
      'SB-User-Agent': _sbUserAgent,
      'include_extra_data': _extraDatas.join(','),
      'expiring_session': _eventManager.getSessionHandler() != null ? '1' : '0',
      'include_poll_details': '1',
      if (accessToken != null) 'access_token': accessToken,
    };
    params.addAll(_webSocketParams);

    final fullWsHost = wsHostUrl + '/?' + Uri(queryParameters: params).query;

    logger.i('websocket connecting.. ');
    runZonedGuarded(() async {
      await _webSocket?.connect(fullWsHost);
    }, (error, stack) {
      if (_loginCompleter != null && !_loginCompleter!.isCompleted) {
        _loginCompleter!.completeError(error);
      }

      _state.connecting = false;
      _state.reconnecting = false;
      _loginCompleter = null;
      _forceReconnect = false;
    });

    final user = await _loginCompleter!.future.timeout(
        Duration(seconds: options.connectionTimeout), onTimeout: () async {
      logger.e('login timeout');
      throw LoginTimeoutError();
    }).onError((error, stackTrace) {
      if (error is SBError) {
        throw error;
      } else if (error is Exception) {
        throw WebSocketError(message: error.toString());
      } else {
        throw WebSocketConnectionFailed();
      }
    });

    logger.i('websocket connected and get user from sendbird server');
    ConnectionManager.flushCompleters(
        error: reconnect ? null : ConnectionClosedError());

    if (!registered) {
      _ambiguate(WidgetsBinding.instance)?.addObserver(this);
      registered = true;
    }

    _loginCompleter = null;
    _reconnectTimer = null;
    _forceReconnect = false;
    return user;
  }

  Future<void> logout() async {
    logger.i('logout');

    // Remove Push Tokens from Cache
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(prefDeviceToken);
    prefs.remove(prefDeviceTokenLastDeletedAt);

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

    // if previously existed completer with different userId then cancel out
    _loginCompleter?.completeError(ConnectionCancelError());
    _loginCompleter = null;

    // _api = ApiClient();
    // _api.initialize(appId: _state.appId);

    _state.cleanUp();
    logger.i('Deleting previous websocket');
    await _webSocket?.close();
    _webSocket = null;

    _ambiguate(WidgetsBinding.instance)?.removeObserver(this);
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
      logger.i('try to reconnect');
      try {
        await connect(
          reconnect: true,
          userId: _state.userId ?? '',
          accessToken: _sessionManager.accessToken,
        );
      } catch (e) {
        _eventManager.notifyReconnectionCanceled();
        _state.reconnecting = false;
        logger.e('reconnecting error: $e');
      }
      logger.i('reconnect succeeded');
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) _handleEnterBackground();
    if (state == AppLifecycleState.resumed) _handleEnterForeground();
  }

  void _handleEnterBackground() async {
    _cache.markAsDirtyAll();
    //clear all timers
    _state.connected = false;
    _state.connecting = false;
    _state.reconnecting = false;
    await _webSocket?.close();
    logger.i('going background');
  }

  void _handleEnterForeground() async {
    logger.i('going foreground');
    if (_state.userId != null && !_state.connected) {
      logger.i('attempting to reconnect from foreground');
      try {
        reconnect(reset: true);
      } catch (e) {
        logger.e('reconnection has failed');
      }
    }
  }

  void _listenConnectionEvents() {
    var flutterTest = const String.fromEnvironment('FLUTTER_TEST');
    if (flutterTest.isEmpty && kIsWeb) {
      flutterTest = '';
    }
    //NOTE: do not run connectivity on test
    final isTest = kIsWeb
        ? flutterTest == 'true'
        : Platform.environment['FLUTTER_TEST'] == 'true';
    if (!isTest) {
      Connectivity().onConnectivityChanged.asBroadcastStream(
            onCancel: (controller) => {
              _connectionResult = ConnectivityResult.none,
              controller.pause(),
            },
            onListen: (subscription) {
              subscription.onData((data) {
                switch (data) {
                  case ConnectivityResult.none:
                    logger.i('connection has been lost');
                    SendbirdSdk().getInternal().cache.markAsDirtyAll();
                    break;
                  case ConnectivityResult.mobile:
                    logger.i('connection status: mobile');
                    if (_connectionResult == ConnectivityResult.none &&
                        _state.sessionKey != null) {
                      reconnect(reset: true);
                    }
                    break;
                  case ConnectivityResult.wifi:
                    logger.i('connection status: wifi');
                    if (_connectionResult == ConnectivityResult.none &&
                        _state.sessionKey != null) {
                      reconnect(reset: true);
                    }
                    break;
                  case ConnectivityResult.bluetooth:
                  case ConnectivityResult.ethernet:
                    logger.i('connection status: ethernet');
                    if (_connectionResult == ConnectivityResult.none &&
                        _state.sessionKey != null) {
                      reconnect(reset: true);
                    }
                    break;
                  case ConnectivityResult.vpn:
                    logger.e("connection status: vpn");
                    if (_connectionResult == ConnectivityResult.none &&
                        _state.sessionKey != null) {
                      reconnect(reset: true);
                    }
                    break;
                  case ConnectivityResult.other:
                    logger.e("connection status: other");
                    break;
                }
                _connectionResult = data;
              });
            },
          );
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
    final os = '/o${kIsWeb ? 'web' : Platform.operatingSystem.toLowerCase()}';
    return '$platform$core$uikit$os';
  }

  String get _sendbirdHeader {
    var headers = [
      platform,
      kIsWeb ? '' : Platform.version.split(' ').first, //empty platform version
      sdk_version,
      state.appId ?? '',
      state.appVersion ?? '',
      kIsWeb ? 'web' : Platform.operatingSystem.toLowerCase(),
      kIsWeb ? '' : Platform.operatingSystemVersion,
    ];
    return headers.join(',');
  }

  Map<String, String> get _webSocketParams {
    final appVersion = _state.appVersion;
    final appId = _state.appId;

    return {
      'p': platform,
      if (!kIsWeb) 'pv': Platform.version.split(' ').first,
      'o': kIsWeb ? 'web' : Platform.operatingSystem.toLowerCase(),
      if (!kIsWeb) 'ov': Platform.operatingSystemVersion,
      'sv': sdk_version,
      if (appId != null) 'ai': appId,
      if (appVersion != null && appVersion != '') 'av': appVersion
    };
  }

  void addVersionExtension(String key, String version) {
    if (key != constants.sbExtensionKeyUIKit ||
        key != constants.sbExtensionKeySyncManager) {
      return;
    }
    _extensions[key] = version;
  }
}
