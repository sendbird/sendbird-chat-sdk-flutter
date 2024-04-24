// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/channel/channel_cache.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_context/chat_context.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/collection_manager/collection_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/command_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/connection_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/db_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/event_dispatcher.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/event_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/session_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/delivery_status.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/async/async_queue.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/async/async_task.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/api_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/feed_channel/feed_channel_change_logs_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/group_channel_change_logs_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/group_channel_mark_as_delivered_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/group_channel_mark_as_read_all_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/scheduled_message/group_channel_scheduled_message_total_count_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/invitation/channel_invitation_preference_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/emoji/emoji_category_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/emoji/emoji_container_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/emoji/emoji_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/notifications/global_notification_channel_setting_get_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/notifications/notification_template_get_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/notifications/notification_template_list_get_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/user/auth/authenticate_feed_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/user/block/user_block_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/user/block/user_unblock_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/user/count/user_group_channel_count_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/user/count/user_unread_channel_count_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/user/count/user_unread_item_count_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/user/count/user_unread_message_count_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/user/info/user_info_update_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/user/preference/user_do_not_disturb_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/user/preference/user_push_sound_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/user/preference/user_push_template_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/user/preference/user_push_trigger_option_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/user/preference/user_snooze_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/user/push/user_push_register_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/user/push/user_push_unregister_request.dart';
import 'package:universal_io/io.dart';

part 'chat_auth.dart';
part 'chat_caching.dart';
part 'chat_channel.dart';
part 'chat_connection.dart';
part 'chat_emoji.dart';
part 'chat_event_handler.dart';
part 'chat_notifications.dart';
part 'chat_push.dart';
part 'chat_user.dart';

const sdkVersion = '4.2.12';

// Internal implementation for main class. Do not directly access this class.
class Chat with WidgetsBindingObserver {
  static const platform = 'flutter';

  // Extension key
  static const extensionKeyUiKit = 'sb_uikit';

  // Extra data
  static const extraDataPremiumFeatureList = 'premium_feature_list';
  static const extraDataFileUploadSizeLimit = 'file_upload_size_limit';
  static const extraDataApplicationAttributes = 'application_attributes';
  static const extraDataEmojiHash = 'emoji_hash';
  static const extraDataNotifications = 'notifications';

  static int globalChatId = 0;

  final Map<String, String> extensions = {};
  final List<String> extraData = [
    extraDataPremiumFeatureList,
    extraDataFileUploadSizeLimit,
    extraDataApplicationAttributes,
    extraDataEmojiHash,
    extraDataNotifications,
  ];

  bool? _isObserverRegistered;
  List<ConnectivityResult> _connectivityResults = [ConnectivityResult.none];
  int lastMarkAsReadTimestamp;

  // This allows a value of type T or T? to be treated as a value of type T?.
  // We use this so that APIs that have become non-nullable can still be used
  // with `!` and `?` to support older versions of the API as well.
  T? _ambiguate<T>(T? value) => value; // (?)

  // isTest
  bool get isTest {
    return kIsWeb
        ? const String.fromEnvironment('FLUTTER_TEST') == 'true'
        : Platform.environment['FLUTTER_TEST'] == 'true';
  }

  // Check dependencies
  late ChatContext chatContext;
  late ChannelCache channelCache;
  late ConnectionManager connectionManager;
  late SessionManager sessionManager;
  late CommandManager commandManager;
  late EventManager eventManager;
  late ApiClient apiClient;
  late EventDispatcher eventDispatcher;
  late CollectionManager collectionManager;
  late StatManager statManager;
  late DBManager dbManager;

  final int chatId;

  Chat({
    required String appId,
    required SendbirdChatOptions options,
  })  : chatId = globalChatId++,
        lastMarkAsReadTimestamp = 0 {
    chatContext = ChatContext(appId: appId, options: options);
    channelCache = ChannelCache();
    connectionManager = ConnectionManager(chat: this); // WebSocketClient
    sessionManager = SessionManager(chat: this);
    commandManager = CommandManager(chat: this);
    eventManager = EventManager(sessionManager: sessionManager);
    statManager = StatManager(chat: this);
    apiClient = ApiClient(
      chatContext: chatContext,
      sessionManager: sessionManager,
      statManager: statManager,
    ); // HttpClient
    eventDispatcher = EventDispatcher(chat: this);
    collectionManager = CollectionManager(chat: this);
    dbManager = DBManager(chat: this);

    _listenConnectivityChangedEvent();
  }

  //+ FileMessage
  final Map<String, AsyncQueue> messageQueueMap = {};
  final Map<String, AsyncSimpleTask> uploadTaskMap = {};

  AsyncQueue getMessageQueue(String channelUrl) =>
      messageQueueMap[channelUrl] ?? AsyncQueue();

  void setMessageQueue(String channelUrl, AsyncQueue queue) =>
      messageQueueMap[channelUrl] = queue;

  AsyncSimpleTask? getUploadTask(String requestId) => uploadTaskMap[requestId];

  void setUploadTask(String requestId, AsyncSimpleTask task) =>
      uploadTaskMap[requestId] = task;

  //- FileMessage

  void listenAppLifecycleState() {
    if (_isObserverRegistered == null) {
      if (_ambiguate(WidgetsBinding.instance) != null) {
        sbLog.i(StackTrace.current, '(WidgetsBinding.instance).addObserver()');
        _ambiguate(WidgetsBinding.instance)?.addObserver(this);
        _isObserverRegistered = true;
      } else {
        sbLog.w(StackTrace.current, '(WidgetsBinding.instance) == null');
      }
    }
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    sbLog.i(StackTrace.current, 'state: $state');

    if (state == AppLifecycleState.paused) await _handleEnterBackground();
    if (state == AppLifecycleState.resumed) await _handleEnterForeground();
  }

  Future<void> _handleEnterBackground() async {
    sbLog.i(StackTrace.current);
    channelCache.markAsDirtyAll();
    if (chatContext.isChatConnected) {
      await connectionManager.enterBackground();
    }
  }

  Future<void> _handleEnterForeground() async {
    sbLog.i(StackTrace.current);
    if (chatContext.isChatConnected) {
      await connectionManager.enterForeground();
    }
    if (chatContext.isFeedAuthenticated) {
      collectionManager.refreshNotificationCollections();
    }
  }

  void _listenConnectivityChangedEvent() {
    sbLog.d(StackTrace.current);

    // Do not run connectivity on test
    if (!isTest) {
      sbLog.d(
          StackTrace.current, 'Connectivity().onConnectivityChanged.listen()');

      Connectivity()
          .onConnectivityChanged
          .listen((dynamic connectivityResults) async {
        final List<ConnectivityResult> results = [];

        if (connectivityResults is ConnectivityResult) {
          // connectivity_plus <6.0.0
          results.add(connectivityResults);
        } else if (connectivityResults is List<ConnectivityResult>) {
          // connectivity_plus ^6.0.0
          results.addAll(connectivityResults);
        }

        sbLog.d(StackTrace.current, results.toString());

        if (results.contains(ConnectivityResult.mobile) ||
            results.contains(ConnectivityResult.wifi) ||
            results.contains(ConnectivityResult.ethernet) ||
            results.contains(ConnectivityResult.vpn) ||
            results.contains(ConnectivityResult.other)) {
          if (_connectivityResults.contains(ConnectivityResult.none)) {
            if (chatContext.isChatConnected) {
              await connectionManager.reconnect(reset: true);
            }
            if (chatContext.isFeedAuthenticated) {
              collectionManager.refreshNotificationCollections();
            }
          }
        } else if (results.contains(ConnectivityResult.bluetooth)) {
          // Nothing
        } else if (results.contains(ConnectivityResult.none)) {
          channelCache.markAsDirtyAll(); // Check
          await connectionManager.disconnect(logout: false);
        }

        _connectivityResults = results;
      });
    }
  }

  String getSdkVersion() {
    sbLog.i(StackTrace.current, 'return: $sdkVersion');
    return sdkVersion;
  }

  void setOptions(SendbirdChatOptions options) {
    sbLog.i(StackTrace.current);
    chatContext.options = options;
  }

  SendbirdChatOptions getOptions() {
    sbLog.i(StackTrace.current);
    return chatContext.options;
  }

  void setAppVersion(String version) {
    sbLog.i(StackTrace.current, 'version: $version');
    chatContext.appVersion = version;
  }

  void setLogLevel(LogLevel level) {
    sbLog.i(StackTrace.current, 'level: $level');
    sbLog.setLogLevel(level);
  }

  bool isInitialized() {
    final result = chatContext.appId.isNotEmpty;
    sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }

  String? getApplicationId() {
    final result = chatContext.appId;
    sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }

  AppInfo? getAppInfo() {
    sbLog.i(StackTrace.current);
    return chatContext.appInfo;
  }

  void addExtension(String key, String version) {
    sbLog.i(StackTrace.current, 'key: $key, version: $version');
    if (key != extensionKeyUiKit) return;
    extensions[key] = version;
  }
}
