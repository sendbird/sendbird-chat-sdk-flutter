// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'group_channel.dart';

/// GroupChannelRead
extension GroupChannelRead on GroupChannel {
  /// Sends mark as read to this channel.
  Future<void> markAsRead() async {
    sbLog.i(StackTrace.current);

    final cmd = Command.buildRead(channelUrl);
    await chat.commandManager.sendCommand(cmd);
  }

  /// Gets the member list who have read the given message.
  ///
  /// If [includeAllMembers] is set false, this list excludes the current logged-in `User` and the sender of the message.
  /// Returns the list of members who have read the message.
  List<Member> getReadMembers(BaseMessage message,
      {bool includeAllMembers = false}) {
    sbLog.i(StackTrace.current,
        'messageId: ${message.messageId}, includeAllMembers: $includeAllMembers');

    if (message is AdminMessage) return [];
    if (isSuper) return [];

    return members.where((m) {
      if (!includeAllMembers && m.isCurrentUser) return false;
      if (message.sender?.userId == m.userId) return false;
      final readStatus = chat.channelCache.find<ReadStatus>(
        channelKey: channelUrl,
        key: m.userId,
      );
      if (readStatus == null || readStatus.timestamp == 0) return false;
      return readStatus.timestamp >= message.createdAt;
    }).toList();
  }

  /// Gets the member list who haven't read the given message.
  ///
  /// If [includeAllMembers] is set false, this list excludes the current logged-in `User` and the sender of the message.
  /// Returns the list of members who haven't read the message.
  List<Member> getUnreadMembers(BaseMessage message,
      {bool includeAllMembers = false}) {
    sbLog.i(StackTrace.current,
        'messageId: ${message.messageId}, includeAllMembers: $includeAllMembers');

    if (message is AdminMessage) return [];
    if (isSuper) return [];

    return members.where((m) {
      if (!includeAllMembers && m.isCurrentUser) return false;
      if (message.sender?.userId == m.userId) return false;
      final readStatus = chat.channelCache.find<ReadStatus>(
        channelKey: channelUrl,
        key: m.userId,
      );
      if (readStatus == null) return true;
      return readStatus.timestamp < message.createdAt;
    }).toList();
  }

  /// Gets [ReadStatus] for all members in this [GroupChannel].
  ///
  /// If [includeAllMembers] is set false, this excludes the current [User].
  /// Returns `Map` with `User` ID keys.
  Map<String, Map<String, dynamic>> getReadStatus(bool includeAllMembers) {
    sbLog.i(StackTrace.current, 'includeAllMembers: $includeAllMembers');
    if (isSuper) return {};

    return Map.fromIterable(
      members.where((member) {
        if (!includeAllMembers && member.isCurrentUser) return false;
        return true;
      }),
      key: (member) => member.userId,
      value: (member) {
        final readStatus = chat.channelCache.find<ReadStatus>(
          channelKey: channelUrl,
          key: member.userId,
        );
        return {'user': member, 'last_seen_at': readStatus?.timestamp};
      },
    );
  }

  /// Returns the list of members that haven't received the given message.
  /// This excludes the current logged-in [User] and the [Sender] of the message.
  /// It will always be zero if the passed on message is an [AdminMessage], or if this channel is a super group channel.
  List<Member> getUndeliveredMembers(BaseMessage message) {
    sbLog.i(StackTrace.current, 'messageId: ${message.messageId}');
    if (message is AdminMessage) return [];
    if (isSuper) return [];

    final deliveryStatus =
        chat.channelCache.find<DeliveryStatus>(channelKey: channelUrl);

    if (deliveryStatus == null) return [];

    return members.where((m) {
      if (m.isCurrentUser) return false;
      if (message.sender?.userId == m.userId) return false;
      if (m.memberState != MemberState.joined) return false;
      final deliveredAt = deliveryStatus.updatedDeliveryStatus[m.userId] ?? 0;
      return deliveredAt < message.createdAt;
    }).toList();
  }
}
