part of 'base_channel.dart';

/// Set of functionality related to channel moderation
extension Moderations on BaseChannel {
  /// Gets current user's mute information
  Future<MuteInfoResponse> getMyMuteInfo() async {
    return _sdk.api.send(
      ChannelMyMuteInfoGetRequest(
        channelType: channelType,
        channelUrl: channelUrl,
      ),
    );
  }

  /// Bans a user from this channel.
  ///
  /// Provides [seconds] to set how long the user should be banned. `-1`
  /// indicates to ban the user parmanently.
  Future<void> banUser({
    required String userId,
    int seconds = -1,
    String? description,
  }) async {
    if (userId.isEmpty) {
      throw InvalidParameterError();
    }

    await _sdk.api.send(ChannelUserBanRequest(
      targetId: userId,
      channelType: channelType,
      channelUrl: channelUrl,
      description: description,
      seconds: seconds,
    ));
  }

  /// Unbans a user from this channel
  Future<void> unbanUser({required String userId}) async {
    if (userId.isEmpty) {
      throw InvalidParameterError();
    }

    await _sdk.api.send(ChannelUserUnbanRequest(
      targetId: userId,
      channelType: channelType,
      channelUrl: channelUrl,
    ));
  }

  /// Mutes a user from this channel.
  ///
  /// Provides [seconds] to set how long the user should be muted. `-1`
  /// indicates to mute the user parmanently.
  Future<void> muteUser({
    required String userId,
    int seconds = -1,
    String? description,
  }) async {
    if (userId.isEmpty) {
      throw InvalidParameterError();
    }

    await _sdk.api.send(ChannelUserMuteRequest(
      targetId: userId,
      channelType: channelType,
      channelUrl: channelUrl,
      description: description,
      seconds: seconds,
    ));
  }

  /// Unmutes user from this channel.
  Future<void> unmuteUser({required String userId}) async {
    if (userId.isEmpty) {
      throw InvalidParameterError();
    }

    await _sdk.api.send(ChannelUserUnmuteRequest(
      targetId: userId,
      channelType: channelType,
      channelUrl: channelUrl,
    ));
  }

  /// Reports this channel with [category] and [description] (optional)
  Future<void> reportChannel({
    required ReportCategory category,
    String? description,
  }) async {
    await _sdk.api.send(ChannelReportRequest(
      channelType: channelType,
      channelUrl: channelUrl,
      category: category,
      description: description,
    ));
  }

  /// Reports [message] with [category] and [description] (optional)
  Future<void> reportMessage({
    required BaseMessage message,
    required ReportCategory category,
    String? description,
  }) async {
    final senderId = message.sender?.userId;
    if (senderId == null || senderId.isEmpty) {
      throw InvalidParameterError();
    }

    await _sdk.api.send(MessageReportRequest(
      messageId: message.messageId,
      senderId: senderId,
      channelType: channelType,
      channelUrl: channelUrl,
      category: category,
      description: description,
    ));
  }

  /// Reports a [User] with [category] and [description] (optional)
  Future<void> reportUser({
    required String userId,
    required ReportCategory category,
    String? description,
  }) async {
    await _sdk.api.send(UserReportRequest(
      targetId: userId,
      channelType: channelType,
      channelUrl: channelUrl,
      category: category,
      description: description,
    ));
  }
}
