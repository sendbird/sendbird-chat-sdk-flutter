// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/reconnect_configuration.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/reconnect_task.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/unread_message_count_info.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat_options.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/info/app_info.dart';

enum Service {
  chat,
  feed,
}

class ChatContext {
  String appId;
  SendbirdChatOptions options;
  String? appVersion;
  String? apiToken; // for test

  ChatContext({
    required this.appId,
    required this.options,
  });

  factory ChatContext.test() =>
      ChatContext(appId: '', options: SendbirdChatOptions());

  // From here for cleanUp()

  // connect()
  String? accessToken;
  String? pendingPushToken;

  // 'LOGI' event
  User? currentUser;
  String? currentUserId;
  List<Service> services = [];
  String? sessionKey;
  String? eKey;
  AppInfo? appInfo;
  int uploadSizeLimit = 0;
  int? maxUnreadCountOnSuperGroup;
  int? lastConnectedAt;
  ReconnectConfiguration? reconnectConfig;

  // Connection
  ReconnectTask? reconnectTask;
  Completer<User>? loginCompleter;

  // Entered OpenChannels
  Set<String> enteredOpenChannelUrls = {};

  // Network
  String? apiHost;
  String? wsHost;
  Map<String, String> apiHeaders = {};

  // WebSocketClient
  int pingInterval = 15;
  int watchdogInterval = 5;

  void init({
    required Chat chat,
    required String appId,
    required SendbirdChatOptions options,
  }) {
    this.appId = appId;
    this.options = options;
    apiHost = chat.connectionManager.getDefaultApiHost();
    apiHeaders = chat.connectionManager.getDefaultApiHeader();
  }

  void setPingInterval(int seconds) {
    if (seconds >= 0) {
      pingInterval = seconds;
    }
  }

  void setWatchdogInterval(int seconds) {
    if (seconds >= 0) {
      watchdogInterval = seconds;
    }
  }

  // UnreadCountInfo
  UnreadMessageCountInfo unreadMessageCountInfo =
      UnreadMessageCountInfo(all: 0, customTypes: {}, ts: 0);

  void resetReconnectTask() {
    final config = reconnectConfig;
    if (config != null) {
      reconnectTask = ReconnectTask(config);
    }
  }

  bool get isChatConnected {
    return (services.isEmpty || services.contains(Service.chat)); // Check
  }

  bool get isFeedAuthenticated {
    return (services.contains(Service.feed));
  }

  void cleanUp() {
    accessToken = null;
    pendingPushToken = null;

    currentUser = null;
    currentUserId = null;
    services.clear();
    sessionKey = null;
    eKey = null;
    appInfo = null;
    uploadSizeLimit = 0;
    maxUnreadCountOnSuperGroup = null;
    lastConnectedAt = null;
    reconnectConfig = null;

    loginCompleter = null;
    reconnectTask = null;

    enteredOpenChannelUrls.clear();

    apiHost = null;
    wsHost = null;
    apiHeaders.clear();

    unreadMessageCountInfo =
        UnreadMessageCountInfo(all: 0, customTypes: {}, ts: 0);
  }
}
