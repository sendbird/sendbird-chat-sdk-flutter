// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'chat.dart';

extension ChatPush on Chat {
  String? getPendingPushToken() {
    return chatContext.pendingPushToken;
  }

  Future<PushTokenRegistrationStatus> registerPushToken({
    required PushTokenType type,
    required String token,
    bool alwaysPush = false,
    bool unique = false,
  }) async {
    sbLog.i(StackTrace.current, 'PushTokenType: $type');

    if (currentUser == null) {
      chatContext.pendingPushToken = token;
      deviceTokenManager.isRegisterPushTokenApiCalled = false;
      return PushTokenRegistrationStatus.pending;
    }

    deviceTokenManager.lastUnique = unique;

    if (unique == false && // Check
        await deviceTokenManager.isCachedDeviceToken(token)) {
      deviceTokenManager.isRegisterPushTokenApiCalled = false;
      return PushTokenRegistrationStatus.success;
    }

    final int? deviceTokenLastDeletedAt =
        await apiClient.send<int?>(UserPushTokenRegisterRequest(
      this,
      type: type,
      token: token,
      alwaysPush: alwaysPush,
      unique: unique,
    ));

    deviceTokenManager.isRegisterPushTokenApiCalled = true;

    await deviceTokenManager.cacheDeviceToken(
        token, unique, deviceTokenLastDeletedAt);

    chatContext.pendingPushToken = null;
    return PushTokenRegistrationStatus.success;
  }

  Future<void> unregisterPushToken({
    required PushTokenType type,
    required String token,
  }) async {
    sbLog.i(StackTrace.current, 'PushTokenType: $type');

    chatContext.pendingPushToken = null;
    final int? deviceTokenLastDeletedAt = await apiClient.send<int?>(
        UserPushTokenUnregisterRequest(this, type: type, token: token));

    await deviceTokenManager.removeCachedDeviceToken(
        token, deviceTokenLastDeletedAt);
  }

  Future<void> unregisterPushTokenAll() async {
    sbLog.i(StackTrace.current);

    chatContext.pendingPushToken = null;
    final int? deviceTokenLastDeletedAt =
        await apiClient.send<int?>(UserPushTokenUnregisterAllRequest(this));

    await deviceTokenManager
        .removeAllCachedDeviceToken(deviceTokenLastDeletedAt);
  }

  Future<void> setPushTriggerOption(PushTriggerOption option) async {
    sbLog.i(StackTrace.current, 'option: $option');
    await apiClient.send(UserPushTriggerOptionSetRequest(this, option));
  }

  Future<PushTriggerOption> getPushTriggerOption() async {
    sbLog.i(StackTrace.current);
    return await apiClient
        .send<PushTriggerOption>(UserPushTriggerOptionGetRequest(this));
  }

  Future<void> setPushSound(String sound) async {
    sbLog.i(StackTrace.current, 'sound: $sound');
    if (sound.isEmpty) throw InvalidParameterException();
    return await apiClient.send(UserPushSoundSetRequest(this, sound));
  }

  Future<String> getPushSound() async {
    sbLog.i(StackTrace.current);
    return await apiClient.send<String>(UserPushSoundGetRequest(this));
  }

  Future<void> setPushTemplate(String name) async {
    sbLog.i(StackTrace.current, 'name: $name');
    if (name.isEmpty) throw InvalidParameterException();
    return await apiClient.send(UserPushTemplateSetRequest(this, name));
  }

  Future<String> getPushTemplate() async {
    sbLog.i(StackTrace.current);
    return await apiClient.send<String>(UserPushTemplateGetRequest(this));
  }
}
