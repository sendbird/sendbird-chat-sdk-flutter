part of 'base_channel.dart';

/// Set of functionality related to channel moderation
extension Moderations on BaseChannel {
  /// Gets current user's mute information
  Future<MuteInfoResponse> getMyMuteInfo() async {
    return _sdk.api.getMuteInfo(
      channelType: channelType,
      channelUrl: channelUrl,
      userId: _sdk.state.currentUser.userId,
    );
  }

  /// Bans a user from this channel.
  ///
  /// Provides [seconds] to set how long the user should be banned. `-1`
  /// indicates to ban the user parmanently.
  Future<void> banUser({
    @required String userId,
    int seconds = -1,
    String description,
  }) async {
    if (userId == null || userId.isEmpty) {
      throw InvalidParameterError();
    }

    await _sdk.api.banUser(
      userId: userId,
      channelType: channelType,
      channelUrl: channelUrl,
      description: description,
      seconds: seconds,
    );
  }

  /// Unbans a user from this channel
  Future<void> unbanUser({@required String userId}) async {
    if (userId == null || userId.isEmpty) {
      throw InvalidParameterError();
    }

    await _sdk.api.unbanUser(
      userId: userId,
      channelType: channelType,
      channelUrl: channelUrl,
    );
  }

  /// Mutes a user from this channel.
  ///
  /// Provides [seconds] to set how long the user should be muted. `-1`
  /// indicates to mute the user parmanently.
  Future<void> muteUser({
    @required String userId,
    int seconds = -1,
    String description,
  }) async {
    if (userId == null || userId.isEmpty) {
      throw InvalidParameterError();
    }

    await _sdk.api.muteUser(
      userId: userId,
      channelType: channelType,
      channelUrl: channelUrl,
      description: description,
      seconds: seconds,
    );
  }

  /// Unmutes user from this channel.
  Future<void> unmuteUser({@required String userId}) async {
    if (userId == null || userId.isEmpty) {
      throw InvalidParameterError();
    }

    await _sdk.api.unmuteUser(
      userId: userId,
      channelType: channelType,
      channelUrl: channelUrl,
    );
  }

  /// Reports this channel with [category] and [description] (optional)
  Future<void> reportChannel({
    @required ReportCategory category,
    String description,
  }) async {
    if (category == null) {
      throw InvalidParameterError();
    }

    await _sdk.api.reportChannel(
      channelType: channelType,
      channelUrl: channelUrl,
      category: category,
    );
  }

  /// Reports [message] with [category] and [description] (optional)
  Future<void> reportMessage({
    @required BaseMessage message,
    @required ReportCategory category,
    String description,
  }) async {
    if (message == null) {
      throw InvalidParameterError();
    }

    if (category == null) {
      throw InvalidParameterError();
    }

    await _sdk.api.reportMessage(
      messageId: message.messageId,
      senderId: message.sender.userId,
      channelType: channelType,
      channelUrl: channelUrl,
      category: category,
    );
  }

  /// Reports a [User] with [category] and [description] (optional)
  Future<void> reportUser({
    @required String userId,
    @required ReportCategory category,
    String description,
  }) async {
    if (userId == null) {
      throw InvalidParameterError();
    }

    if (category == null) {
      throw InvalidParameterError();
    }

    await _sdk.api.reportUser(
      userId: userId,
      channelType: channelType,
      channelUrl: channelUrl,
      category: category,
      reporterId: _sdk.state.userId,
    );
  }
}
