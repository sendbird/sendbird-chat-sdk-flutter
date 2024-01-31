// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_context/chat_context.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/reconnect_configuration.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/info/app_info.dart';

class Login {
  final String userId;
  final List<Service> services;
  AppInfo? appInfo;
  final int uploadSizeLimit;
  int? maxUnreadCountOnSuperGroup;
  int? lastConnectedAt;
  ReconnectConfiguration? reconnectConfig;

  final Chat chat;

  Login({
    required this.userId,
    List<Service>? services,
    this.appInfo,
    int? uploadSizeLimit,
    this.maxUnreadCountOnSuperGroup,
    this.lastConnectedAt,
    this.reconnectConfig,
    Chat? chat,
  })  : services = services ?? [],
        uploadSizeLimit = uploadSizeLimit ?? 0,
        chat = chat ?? SendbirdChat().chat;
}
