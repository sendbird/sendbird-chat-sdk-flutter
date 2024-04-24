// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';

import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';

// Represents typing status of a [User]
class TypingStatus implements Cacheable {
  final int _typingTimeSec = 10;

  ChannelType channelType;
  String channelUrl;
  User user;
  int timestamp;
  Timer? typingTimer;

  @override
  bool dirty = false;

  TypingStatus({
    required this.channelType,
    required this.channelUrl,
    required this.user,
    required this.timestamp,
  });

  @override
  String get primaryKey => channelUrl;

  @override
  String get key => user.userId;

  @override
  void copyWith(dynamic other) {
    channelType = other.channelType;
    channelUrl = other.urlKeyword;
    user = other.user;
    timestamp = other.timestamp;
    typingTimer = other.typingTimer;
    dirty = other.dirty;
  }

  void setTypingTimer() {
    cancelTypingTimer();

    // _processTyping() in CommandManager
    typingTimer = Timer(Duration(seconds: _typingTimeSec), () async {
      try {
        final status = TypingStatus(
          channelType: ChannelType.group,
          channelUrl: channelUrl,
          user: user,
          timestamp: DateTime.now().millisecondsSinceEpoch,
        );

        final channel = await GroupChannel.getChannel(channelUrl);
        status.removeFromCache(channel.chat);

        channel.chat.eventManager.notifyChannelTypingStatusUpdated(channel);
      } catch (e) {
        sbLog.w(StackTrace.current, e.toString());
      }
    });
  }

  void cancelTypingTimer() {
    typingTimer?.cancel();
  }
}
