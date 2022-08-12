part of 'group_channel.dart';

/// Set of functionality related to read feature for group channel
extension GroupChannelRead on GroupChannel {
  /// Marks as read with current time.
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onReadReceiptUpdated] can be invoked
  Future<void> markAsRead() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastMarkAsReadTimestamp <= 1000) {
      throw MarkAsReadRateLimitExceededError();
    }

    _lastMarkAsReadTimestamp = now;
    final cmd = Command.buildRead(channelUrl);
    await _sdk.cmdManager.sendCommand(cmd);
  }

  /// Returns a list of [Member] who has read given [message]. If [includeAll]
  /// is provided as `true` then current user will be included as well.
  List<Member> getReadMembers(BaseMessage message, {bool includeAll = false}) {
    if (message is AdminMessage) return [];
    if (isSuper) return [];
    // if (_sdk.state.currentUser == null) return []; //check connection

    return members.where((m) {
      if (!includeAll && m.isCurrentUser) return false;
      if (message.sender?.userId == m.userId) return false;
      final readStatus = _sdk.cache.find<ReadStatus>(
        channelKey: channelUrl,
        key: m.userId,
      );
      if (readStatus == null || readStatus.timestamp == 0) return false;
      return readStatus.timestamp >= message.createdAt;
    }).toList();
  }

  /// Returns a list of [Member] who has not read given [message]. If
  /// [includeAll] is provided as `true` then current user will be included
  /// as well.
  List<Member> getUnreadMembers(BaseMessage message,
      {bool includeAll = false}) {
    if (message is AdminMessage) return [];
    if (isSuper) return [];
    // if (_sdk.state.currentUser == null) return []; //check connection

    return members.where((m) {
      if (!includeAll && m.isCurrentUser) return false;
      if (message.sender?.userId == m.userId) return false;
      final readStatus = _sdk.cache.find<ReadStatus>(
        channelKey: channelUrl,
        key: m.userId,
      );
      if (readStatus == null) return false;
      return readStatus.timestamp < message.createdAt;
    }).toList();
  }

  /// Returns `Map` with key as userId String and value as `Map` that conatins
  /// two keys: `user` and `last_seen_at`. If [includeAll] is provided as
  /// `true` then current user will be included as well.
  ///
  /// ```
  /// {
  ///   'userId1': {
  ///     'user': User(),
  ///     'last_seen_at': 1682131232
  ///   }
  /// }
  /// ```
  Map<String, Map<String, dynamic>> getReadStatus(bool includeAll) {
    if (isSuper) return {};
    // if (_sdk.state.currentUser == null) return []; //check connection
    return Map.fromIterable(
      members.where((m) {
        if (!includeAll && m.isCurrentUser) return false;
        return true;
      }),
      key: (m) => m.userId,
      value: (m) {
        final readStatus = _sdk.cache.find<ReadStatus>(
          channelKey: channelUrl,
          key: m.userId,
        );
        return {'user': m, 'last_seen_at': readStatus?.timestamp};
      },
    );
  }

  /// Returns undelivered member count as [int] with given [message].
  List<Member> getUndeliveredMembers(BaseMessage message) {
    if (message is AdminMessage) return [];
    if (isSuper) return [];
    // if (_sdk.state.currentUser == null) return []; //check connection

    final deliveryStatus =
        _sdk.cache.find<DeliveryStatus>(channelKey: channelUrl);

    // delivery receipt feature is not on, throw?
    if (deliveryStatus == null) return [];

    return members.where((m) {
      if (m.isCurrentUser) return false;
      if (message.sender?.userId == m.userId) return false;
      if (m.state != MemberState.joined) return false;
      final deliveredAt = deliveryStatus.updatedDeliveryReceipt[m.userId] ?? 0;
      return deliveredAt < message.createdAt;
    }).toList();
  }
}
