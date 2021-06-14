part of 'group_channel.dart';

/// Set of functionality related to typing feature for group channel
extension GroupChannelTyping on GroupChannel {
  /// Starts to send typing signal.
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onTypingStatusUpdated] will be invoked.
  void startTyping() {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastStartTypingTimestamp >
        _sdk.options.typingIndicatorThrottle) {
      final cmd = Command.buildStartTyping(channelUrl, now);
      _sdk.cmdManager.sendCommand(cmd);
      _lastStartTypingTimestamp = now;
      _lastEndTypingTimestamp = 0;
    }
  }

  /// Stops to send typing signal.
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onTypingStatusUpdated] will be invoked.
  void endTyping() {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastEndTypingTimestamp > _sdk.options.typingIndicatorThrottle) {
      final cmd = Command.buildEndTyping(channelUrl, now);
      _sdk.cmdManager.sendCommand(cmd);
      _lastStartTypingTimestamp = 0;
      _lastEndTypingTimestamp = now;
    }
  }

  /// Returns `true` if any members has been typing.
  bool get isTyping {
    final typingStatuses =
        _sdk.cache.findAll<TypingStatus>(channelKey: channelUrl);
    return typingStatuses != null && typingStatuses.isNotEmpty;
  }

  /// Returns a list of [User] who are currently typing.
  List<User> getTypingUsers() {
    final typingStatuses =
        _sdk.cache.findAll<TypingStatus>(channelKey: channelUrl);
    return typingStatuses?.map((e) => e.user).toList() ?? [];
  }
}
