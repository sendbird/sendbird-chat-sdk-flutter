// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'base_channel.dart';

/// BaseChannelModeration
extension BaseChannelModeration on BaseChannel {
  /// Gets my muted information in this channel.
  Future<MuteInfo> getMyMuteInfo() async {
    sbLog.i(StackTrace.current);
    checkUnsupportedAction();

    return await chat.apiClient.send(
      ChannelMyMuteInfoGetRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
      ),
    );
  }

  /// Bans a user.
  /// Operators can ban users from this channel.
  /// Banned user is kicked out of this channel and cannot enter during the specified seconds.
  /// If you want to ban the user indefinitely, pass -1 to seconds as the argument.
  Future<void> banUser({
    required String userId,
    int seconds = -1,
    String? description,
  }) async {
    sbLog.i(StackTrace.current, 'userId: $userId');
    checkUnsupportedAction();

    if (userId.isEmpty) {
      throw InvalidParameterException();
    }

    await chat.apiClient.send(ChannelUserBanRequest(
      chat,
      targetId: userId,
      channelType: channelType,
      channelUrl: channelUrl,
      description: description,
      seconds: seconds,
    ));
  }

  /// Unbans `User`.
  /// Operators can unban `User` who has been banned from this channel.
  Future<void> unbanUser({required String userId}) async {
    sbLog.i(StackTrace.current, 'userId: $userId');
    checkUnsupportedAction();

    if (userId.isEmpty) {
      throw InvalidParameterException();
    }

    await chat.apiClient.send(ChannelUserUnbanRequest(
      chat,
      targetId: userId,
      channelType: channelType,
      channelUrl: channelUrl,
    ));
  }

  /// Mutes `User`.
  /// Muted `User`'s messages are no longer delivered to current `User`.
  Future<void> muteUser({
    required String userId,
    int seconds = -1,
    String? description,
  }) async {
    sbLog.i(StackTrace.current, 'userId: $userId');
    checkUnsupportedAction();

    if (userId.isEmpty) {
      throw InvalidParameterException();
    }

    await chat.apiClient.send(ChannelUserMuteRequest(
      chat,
      targetId: userId,
      channelType: channelType,
      channelUrl: channelUrl,
      description: description,
      seconds: seconds,
    ));
  }

  /// Unmutes `User`.
  /// Unmuted `User`'s messages are again shown to current `User`.
  Future<void> unmuteUser({required String userId}) async {
    sbLog.i(StackTrace.current, 'userId: $userId');
    checkUnsupportedAction();

    if (userId.isEmpty) {
      throw InvalidParameterException();
    }

    await chat.apiClient.send(ChannelUserUnmuteRequest(
      chat,
      targetId: userId,
      channelType: channelType,
      channelUrl: channelUrl,
    ));
  }

  /// Reports this channel of inappropriate activities.
  Future<void> report({
    required ReportCategory category,
    String? description,
  }) async {
    sbLog.i(StackTrace.current, 'category: $category');
    checkUnsupportedAction();

    await chat.apiClient.send(ChannelReportRequest(
      chat,
      channelType: channelType,
      channelUrl: channelUrl,
      category: category,
      description: description,
    ));
  }

  /// Reports a malicious message.
  Future<void> reportMessage({
    required BaseMessage message,
    required ReportCategory category,
    String? description,
  }) async {
    sbLog.i(
        StackTrace.current, 'message: ${message.message}, category: $category');
    checkUnsupportedAction();

    final senderId = message.sender?.userId;
    if (senderId == null || senderId.isEmpty) {
      throw InvalidParameterException();
    }

    await chat.apiClient.send(MessageReportRequest(
      chat,
      messageId: message.messageId,
      senderId: senderId,
      channelType: channelType,
      channelUrl: channelUrl,
      category: category,
      description: description,
    ));
  }

  /// Reports a user of suspicious activities.
  Future<void> reportUser({
    required String userId,
    required ReportCategory category,
    String? description,
  }) async {
    sbLog.i(StackTrace.current, 'userId: $userId, category: $category');
    checkUnsupportedAction();

    await chat.apiClient.send(UserReportRequest(
      chat,
      targetId: userId,
      channelType: channelType,
      channelUrl: channelUrl,
      category: category,
      description: description,
    ));
  }
}
