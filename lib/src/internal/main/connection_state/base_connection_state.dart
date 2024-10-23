// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';

abstract class BaseConnectionState {
  final Chat chat;

  BaseConnectionState({required this.chat});

  Future<User> connect(
    String userId, {
    String? nickname,
    String? accessToken,
    String? apiHost,
    String? wsHost,
  });
  Future<void> disconnect({required bool logout});
  Future<bool> reconnect({required bool reset});

  Future<void> enterBackground();
  Future<void> enterForeground();

  @override
  bool operator ==(covariant BaseConnectionState other) {
    if (runtimeType.toString() == other.runtimeType.toString()) {
      return true;
    }
    return false;
  }

  @override
  int get hashCode => Object.hash(
        runtimeType.toString(),
        runtimeType.toString(),
      );
}
