// Copyright (c) 2025 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/event/login_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceTokenManager {
  final String prefDeviceTokenList = 'com.sendbird.chat.device_token_list';
  final String prefDeviceTokenLastDeletedAt =
      'com.sendbird.chat.device_token_last_deleted_at';

  DeviceTokenManager();

  final int maxDeviceTokenCount = 10; // Check

  bool isSdkDeviceTokenCache = false;
  bool lastUnique = false;

  int? deviceTokenLastDeletedAtForTest;
  bool? isRegisterPushTokenApiCalled;

  Future<void> checkLoginEvent(LoginEvent event) async {
    sbLog.d(StackTrace.current);

    isSdkDeviceTokenCache =
        event.applicationAttributes.contains('sdk_device_token_cache');

    if (isSdkDeviceTokenCache) {
      final prefs = await SharedPreferences.getInstance();

      final lastDeletedAtFromPrefs = prefs.getInt(prefDeviceTokenLastDeletedAt);
      final lastDeletedAtFromServer =
          deviceTokenLastDeletedAtForTest ?? event.deviceTokenLastDeletedAt;

      if (lastDeletedAtFromPrefs == null ||
          lastDeletedAtFromPrefs < lastDeletedAtFromServer) {
        await prefs.remove(prefDeviceTokenList);
        await prefs.setInt(
          prefDeviceTokenLastDeletedAt,
          lastDeletedAtFromServer,
        );
      }
    } else {
      cleanUp(); // Check: await
    }
  }

  Future<bool> isCachedDeviceToken(String deviceToken) async {
    sbLog.d(StackTrace.current);

    if (!isSdkDeviceTokenCache) {
      return false;
    }

    final prefs = await SharedPreferences.getInstance();
    final deviceTokenList = prefs.getStringList(prefDeviceTokenList);

    return (deviceTokenList != null && deviceTokenList.contains(deviceToken));
  }

  Future<void> cacheDeviceToken(
    String deviceToken,
    bool unique,
    int? deviceTokenLastDeletedAt,
  ) async {
    sbLog.d(StackTrace.current);

    if (!isSdkDeviceTokenCache) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final deviceTokenList = prefs.getStringList(prefDeviceTokenList);

    if (unique ||
        deviceTokenList == null ||
        deviceTokenList.length >= maxDeviceTokenCount) {
      await prefs.setStringList(prefDeviceTokenList, [deviceToken]);
    } else if (deviceTokenList.contains(deviceToken) == false) {
      await prefs.setStringList(
          prefDeviceTokenList, deviceTokenList..add(deviceToken));
    }

    if (deviceTokenLastDeletedAt != null) {
      await prefs.setInt(
          prefDeviceTokenLastDeletedAt, deviceTokenLastDeletedAt);
    }
  }

  Future<void> removeCachedDeviceToken(
    String deviceToken,
    int? deviceTokenLastDeletedAt,
  ) async {
    sbLog.d(StackTrace.current);

    if (!isSdkDeviceTokenCache) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final deviceTokenList = prefs.getStringList(prefDeviceTokenList);

    if (deviceTokenList != null && deviceTokenList.contains(deviceToken)) {
      await prefs.setStringList(
          prefDeviceTokenList, deviceTokenList..remove(deviceToken));
    }

    if (deviceTokenLastDeletedAt != null) {
      await prefs.setInt(
          prefDeviceTokenLastDeletedAt, deviceTokenLastDeletedAt);
    }
  }

  Future<void> removeAllCachedDeviceToken(
    int? deviceTokenLastDeletedAt,
  ) async {
    sbLog.d(StackTrace.current);

    if (!isSdkDeviceTokenCache) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(prefDeviceTokenList);

    if (deviceTokenLastDeletedAt != null) {
      await prefs.setInt(
          prefDeviceTokenLastDeletedAt, deviceTokenLastDeletedAt);
    }
  }

  Future<void> cleanUp() async {
    sbLog.d(StackTrace.current);

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(prefDeviceTokenList);
    await prefs.remove(prefDeviceTokenLastDeletedAt);
  }

  Future<int> getCachedDeviceTokenListSize() async {
    sbLog.d(StackTrace.current);

    final prefs = await SharedPreferences.getInstance();
    final deviceTokenList = prefs.getStringList(prefDeviceTokenList);

    return deviceTokenList?.length ?? 0;
  }
}
