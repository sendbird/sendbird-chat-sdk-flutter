// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'group_channel.dart';

/// GroupChannelTyping
extension GroupChannelTyping on GroupChannel {
  /// Sends start typing event.
  void startTyping() {
    sbLog.i(StackTrace.current);

    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastStartTypingTimestamp >
        chat.chatContext.options.typingIndicatorThrottle) {
      final cmd = Command.buildStartTyping(channelUrl, now);
      chat.commandManager.sendCommand(cmd);
      _lastStartTypingTimestamp = now;
      _lastEndTypingTimestamp = 0;
    }
  }

  /// Sends end typing event.
  void endTyping() {
    sbLog.i(StackTrace.current);

    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastEndTypingTimestamp >
        chat.chatContext.options.typingIndicatorThrottle) {
      final cmd = Command.buildEndTyping(channelUrl, now);
      chat.commandManager.sendCommand(cmd);
      _lastStartTypingTimestamp = 0;
      _lastEndTypingTimestamp = now;
    }
  }

  /// Whether one or more members are typing.
  bool get isTyping {
    final typingStatuses =
        chat.channelCache.findAll<TypingStatus>(channelKey: channelUrl);
    final result = typingStatuses != null && typingStatuses.isNotEmpty;

    sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }

  /// The typing user list.
  List<User> getTypingUsers() {
    final typingStatuses =
        chat.channelCache.findAll<TypingStatus>(channelKey: channelUrl);
    final result = typingStatuses?.map((e) => e.user).toList() ?? [];

    // sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }
}
