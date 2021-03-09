import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';

import '../channel/base_channel.dart';
import '../channel/group_channel.dart';
import '../core/async/async_operation.dart';
import '../core/async/async_queue.dart';
import '../services/connection/connection_manager.dart';
import '../constant/contants.dart' as Constants;
import '../constant/enums.dart';
import '../handlers/event_manager.dart';
import '../models/options.dart';
import '../models/responses.dart';
import '../models/state.dart';
import '../models/error.dart';
import '../models/user.dart';
import '../services/command/command_manager.dart';
import '../services/session/session_manager.dart';
import '../services/db/memory_cache_service.dart';
import '../services/network/api_client.dart';
import '../services/network/websocket_client.dart';
import '../utils/logger.dart';
import '../utils/parsers.dart';

const sdk_version = '3.0.3';

/// Internal implementation for main class. Do not directly access this class.
class SendbirdSdkInternal with WidgetsBindingObserver {
  SendbirdState state = SendbirdState();

  SessionManager sessionManager = SessionManager();
  MemoryCacheStorage cache = MemoryCacheStorage();
  EventManager eventManager = EventManager();
  CommandManager cmdManager = CommandManager();

  Map<String, String> _extensions = {};
  List<String> extraDatas = [
    Constants.SbExtraDataPremiumFeatureList,
    Constants.SbExtraDataFileUploadSizeLimit,
    Constants.SbExtraDataApplicationAttributes,
    Constants.SbExtraDataEmojiHash,
  ];

  ApiClient api = ApiClient();
  WebSocketClient webSocket;
  Completer<User> loginCompleter;

  StreamController<int> totalUnreadCountController;
  StreamController<ChannelMessageResponse> messageUpdateStreamController;
  StreamController<ChannelMessageResponse> messageReceiveStreamController;
  StreamController<BaseChannel> channelChangedStreamController;
  StreamController<GroupChannel> readStreamController;
  StreamController<GroupChannel> deliveryStreamController;
  StreamController<GroupChannel> usersTypingStreamController;
  StreamController<ConnectionEventType> connectionStreamController;

  Options options;
  Timer reconnectTimer;

  ConnectivityResult connectionResult;
  StreamSubscription connectionSub;

  AsyncQueue commandQueue = AsyncQueue<String>();
  Map<String, AsyncQueue> messageQueues = {};

  //should only keep one instance
  SendbirdSdkInternal({
    String appId,
    String apiToken,
    this.options,
  }) {
    api.initialize(appId: appId, token: apiToken);
    state.appId = appId;

    WidgetsBinding.instance?.addObserver(this);
    // sessionManager.addHttpListener(api.errorStream);

    //do not run connectivity on test
    bool isTest = Platform.environment['FLUTTER_TEST'] == 'true';
    if (!isTest) {
      connectionSub = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        switch (result) {
          case ConnectivityResult.none:
            logger.i('[Sendbird] connection has been lost');
            break;
          case ConnectivityResult.mobile:
          case ConnectivityResult.wifi:
            if (connectionResult == ConnectivityResult.none &&
                state.sessionKey != null) {
              reconnect(reset: true);
            }
        }
      });
    }
  }

  void onWebSocketConnect() {}

  //the socket has closed - return true to re-connect?
  void onWebSocketDisconnect() {
    state.connected = false;
    cmdManager.clearCompleters(error: WebSocketDisconnectError());
  }

  //Inbound Web Data
  void onWebSocketData(dynamic data) async {
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
    final cmd = await commandQueue.enqueue(op);
    // cmdManager.processCommand(cmd);
    runZoned(() async {
      try {
        cmdManager.processCommand(cmd);
      } catch (e) {
        throw e;
      }
    }, onError: (e, s) {
      //handle error how to toss this..?
      //get waiting func and error?
      if (loginCompleter != null)
        loginCompleter?.completeError(e);
      else
        logger.e('[Sendbird] fatal error thrown ${e.toString()}');
      // throw e;
    });
  }

  void onWebSocketError(Object error) {
    if (state.currentUser != null) {
      reconnect(reset: false);
    } else {
      throw WebSocketError();
    }
  }

  //TODO: handle error and reset states
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
      if (state.connected && state.userId == userId) {
        return state.currentUser;
      }

      // is already in progress to connect
      if (state.connecting &&
          state.userId == userId &&
          loginCompleter != null) {
        return loginCompleter.future;
      }
    } else {
      sessionKey = await sessionManager.getSessionKey();
      if (sessionKey == '' || sessionKey == null) {
        ConnectionManager.flushCompleters(error: ConnectionRequiredError());
        eventManager.notifyReconnectionFailed();
        return null;
      }
      if (!state.reconnecting) eventManager.notifyReconnectionStarted();
    }

    state.userId = userId;
    state.connecting = true;

    _resetControllers();
    loginCompleter = Completer();

    webSocket?.close();
    webSocket = WebSocketClient(
      onWebSocketConnect,
      onWebSocketDisconnect,
      onWebSocketData,
      onWebSocketError,
    );

    apiHost = reconnect ? state.apiHost : apiHost ?? _getDefaultApiHost();
    wsHost = reconnect ? state.wsHost : wsHost ?? _getDefaultWsHost();

    sessionManager.setAccessToken(accessToken);

    state
      ..reconnecting = reconnect
      ..wsHost = wsHost
      ..apiHost = apiHost;

    api.initialize(baseUrl: apiHost, headers: {
      'SB-User-Agent': this._sbUserAgent,
    });

    var params = {
      'p': Platform.operatingSystem,
      'pv': Platform.operatingSystemVersion, //device_info
      'sv': sdk_version,
      'ai': state.appId,
      if (reconnect && sessionKey != null)
        'key': sessionKey
      else
        'user_id': userId,
      'SB-User-Agent': this._sbUserAgent,
      'include_extra_data': extraDatas.join(','),
      'expiring_session':
          eventManager.getHandler(type: EventType.session) != null ? '1' : '0',
      if (accessToken != null) 'access_token': accessToken,
    };

    final fullWsHost = wsHost + '/?' + Uri(queryParameters: params).query;

    await webSocket.connect(fullWsHost);
    final user = await loginCompleter.future
        .timeout(Duration(seconds: options.connectionTimeout), onTimeout: () {
      logout();
      throw WebSocketTimeoutError();
    });

    ConnectionManager.flushCompleters(
        error: reconnect ? null : ConnectionClosedError());

    loginCompleter = null;
    reconnectTimer = null;
    return user;
  }

  void _resetControllers() {
    totalUnreadCountController?.close();
    messageReceiveStreamController?.close();
    messageUpdateStreamController?.close();
    readStreamController?.close();
    deliveryStreamController?.close();
    channelChangedStreamController?.close();
    usersTypingStreamController?.close();
    connectionStreamController?.close();

    totalUnreadCountController = StreamController<int>.broadcast();
    messageUpdateStreamController =
        StreamController<ChannelMessageResponse>.broadcast();
    messageReceiveStreamController =
        StreamController<ChannelMessageResponse>.broadcast();
    channelChangedStreamController = StreamController<BaseChannel>.broadcast();
    readStreamController = StreamController<GroupChannel>.broadcast();
    deliveryStreamController = StreamController<GroupChannel>.broadcast();
    usersTypingStreamController = StreamController<GroupChannel>.broadcast();
    connectionStreamController =
        StreamController<ConnectionEventType>.broadcast();
  }

  void logout() {
    sessionManager = SessionManager();
    cache = MemoryCacheStorage();
    eventManager = EventManager();
    cmdManager = CommandManager();
    api = ApiClient();
    api.initialize(appId: state.appId);

    state = SendbirdState()..appId = state.appId;
    webSocket?.close();
    webSocket = null;

    WidgetsBinding.instance?.removeObserver(this);
    connectionSub?.cancel();

    loginCompleter = null;

    ConnectionManager.flushCompleters(error: ConnectionClosedError());
    _resetControllers();
  }

  //reset reconnection logic
  void reconnect({bool reset = false}) {
    if (reset) {
      reconnectTimer?.cancel();
      reconnectTimer = null;
      state.resetReconnectTask();
    }

    if (reconnectTimer != null) return;

    final task = state.reconnectTask;
    if (task.exceedRetryCount && task.hasRetriedLastChance) {
      task.increaseRetryCount();
      state.reconnecting = false;
      eventManager.notifyReconnectionFailed();
      return;
    }

    final backoffPeriod = task.backOffPeriod;
    task.increaseRetryCount();
    state.reconnecting = true;

    reconnectTimer = Timer(Duration(seconds: backoffPeriod), () {
      connect(
        reconnect: true,
        userId: state.userId,
        accessToken: sessionManager.accessToken,
      );
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) _handleEnterBackground();
    if (state == AppLifecycleState.resumed) _handleEnterForeground();
  }

  _handleEnterBackground() {
    cache.markAsDirtyAll();
    //clear all timers
    state.connected = false;
    state.connecting = false;
    state.reconnecting = false;
    webSocket.close();
  }

  _handleEnterForeground() async {
    //need to connect with existing session key
    //if previously connected
    //reconnecting
    if (state.currentUser != null)
      await connect(userId: state.userId, reconnect: true);
  }

  String _getDefaultApiHost() {
    return 'api-' + state.appId + '.sendbird.com';
  }

  String _getDefaultWsHost() {
    return 'wss://ws-' + state.appId + '.sendbird.com';
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
