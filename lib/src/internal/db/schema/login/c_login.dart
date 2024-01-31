// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/login/login.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_context/chat_context.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/reconnect_configuration.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/info/app_info.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/info/notification_info.dart';

part 'c_login.g.dart';

@collection
class CLogin {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String userId;

  @enumerated
  late List<Service> services;

  CAppInfo? appInfo;
  int? uploadSizeLimit;
  int? maxUnreadCountOnSuperGroup;
  int? lastConnectedAt;
  CReconnectConfiguration? reconnectConfig;

  CLogin();

  factory CLogin.fromLogin(Login login) {
    return CLogin()
      ..userId = login.userId
      ..services = login.services
      ..appInfo =
          login.appInfo != null ? CAppInfo.fromAppInfo(login.appInfo!) : null
      ..uploadSizeLimit = login.uploadSizeLimit
      ..maxUnreadCountOnSuperGroup = login.maxUnreadCountOnSuperGroup
      ..lastConnectedAt = login.lastConnectedAt
      ..reconnectConfig = login.reconnectConfig != null
          ? CReconnectConfiguration.fromReconnectConfiguration(
              login.reconnectConfig!)
          : null;
  }

  Future<Login?> toLogin(Chat chat, Isar isar) async {
    final login = Login(
      userId: userId,
      services: services,
      appInfo: appInfo?.toAppInfo(),
      uploadSizeLimit: uploadSizeLimit,
      maxUnreadCountOnSuperGroup: maxUnreadCountOnSuperGroup,
      lastConnectedAt: lastConnectedAt,
      reconnectConfig: reconnectConfig?.toReconnectConfiguration(),
      chat: chat,
    );
    return login;
  }

  static Future<CLogin> upsert(Chat chat, Isar isar, Login login) async {
    final cLogin = CLogin.fromLogin(login);

    // Login
    await chat.dbManager.write(() async {
      await isar.cLogins.put(cLogin);
    });

    return cLogin;
  }

  static Future<Login?> get(Chat chat, Isar isar, String userId) async {
    final cLogin = await isar.cLogins.where().userIdEqualTo(userId).findFirst();
    return await cLogin?.toLogin(chat, isar);
  }

  static Future<void> delete(Chat chat, Isar isar, String userId) async {
    await chat.dbManager.write(() async {
      await isar.cLogins.deleteByUserId(userId);
    });
  }
}

@embedded
class CAppInfo {
  late List<String> premiumFeatureList;
  late int uploadSizeLimit;
  late List<String> attributesInUse;
  late String emojiHash;
  late bool useReaction;
  CNotificationInfo? notificationInfo;
  late bool allowSdkStatsUpload;

  CAppInfo();

  factory CAppInfo.fromAppInfo(AppInfo info) {
    return CAppInfo()
      ..premiumFeatureList = info.premiumFeatureList
      ..uploadSizeLimit = info.uploadSizeLimit
      ..attributesInUse = info.attributesInUse
      ..emojiHash = info.emojiHash
      ..useReaction = info.useReaction
      ..notificationInfo = info.notificationInfo != null
          ? CNotificationInfo.fromNotificationInfo(info.notificationInfo!)
          : null
      ..allowSdkStatsUpload = info.allowSdkStatsUpload;
  }

  AppInfo toAppInfo() {
    return AppInfo(
      premiumFeatureList: premiumFeatureList,
      uploadSizeLimit: uploadSizeLimit,
      attributesInUse: attributesInUse,
      emojiHash: emojiHash,
      useReaction: useReaction,
      notificationInfo: notificationInfo?.toNotificationInfo(),
      allowSdkStatsUpload: allowSdkStatsUpload,
    );
  }
}

@embedded
class CNotificationInfo {
  late bool isEnabled;
  late String feedChannels; // Map<String, String>
  late int settingsUpdatedAt;
  String? templateListToken;

  CNotificationInfo();

  factory CNotificationInfo.fromNotificationInfo(NotificationInfo info) {
    return CNotificationInfo()
      ..isEnabled = info.isEnabled
      ..feedChannels = jsonEncode(info.feedChannels)
      ..settingsUpdatedAt = info.settingsUpdatedAt
      ..templateListToken = info.templateListToken;
  }

  NotificationInfo toNotificationInfo() {
    return NotificationInfo(
      isEnabled: isEnabled,
      feedChannels: (jsonDecode(feedChannels) as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value.toString())),
      settingsUpdatedAt: settingsUpdatedAt,
      templateListToken: templateListToken,
    );
  }
}

@embedded
class CReconnectConfiguration {
  late double interval;
  late double maxInterval;
  late int multiplier;
  late int maximumRetryCount;

  CReconnectConfiguration();

  factory CReconnectConfiguration.fromReconnectConfiguration(
      ReconnectConfiguration configuration) {
    return CReconnectConfiguration()
      ..interval = configuration.interval
      ..maxInterval = configuration.maxInterval
      ..multiplier = configuration.multiplier
      ..maximumRetryCount = configuration.maximumRetryCount;
  }

  ReconnectConfiguration toReconnectConfiguration() {
    return ReconnectConfiguration(
      interval: interval,
      maxInterval: maxInterval,
      multiplier: multiplier,
      maximumRetryCount: maximumRetryCount,
    );
  }
}
