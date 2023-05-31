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
      return PushTokenRegistrationStatus.pending;
    }

    final result = await apiClient
        .send<PushTokenRegistrationStatus>(UserPushTokenRegisterRequest(
      this,
      type: type,
      token: token,
      alwaysPush: alwaysPush,
      unique: unique,
    ));

    chatContext.pendingPushToken = null;
    return result;
  }

  Future<void> unregisterPushToken({
    required PushTokenType type,
    required String token,
  }) async {
    sbLog.i(StackTrace.current, 'PushTokenType: $type');

    chatContext.pendingPushToken = null;
    return await apiClient.send(UserPushTokenUnregisterRequest(
      this,
      type: type,
      token: token,
    ));
  }

  Future<void> unregisterPushTokenAll() async {
    sbLog.i(StackTrace.current);

    chatContext.pendingPushToken = null;
    return await apiClient.send(UserPushTokenUnregisterAllRequest(this));
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
