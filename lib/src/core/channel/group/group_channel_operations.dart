part of 'group_channel.dart';

extension GroupChannelOperations on GroupChannel {
  /// Invites one or more [User] with given `userIds` to this channel.
  ///
  /// After this method completes successfully,
  /// [ChannelEventHandler.onUserReceivedInvitation]
  /// will be invoked on each invited user's end and
  /// [ChannelEventHandler.onUserJoined] can be
  /// invoked based on their channel invitation preference which can be set
  /// through [SendbirdSdk.setChannelInvitationPreference]
  Future<void> inviteUsers(List<String> userIds) async {
    if (userIds == null || userIds.isEmpty) {
      throw InvalidParameterError();
    }

    await _sdk.api.inviteUsers(
      userIds: userIds,
      channelUrl: channelUrl,
      inviterId: _sdk.state.userId,
    );
  }

  /// Accepts received invitation to join on this channel.
  ///
  /// If this channel sets [accessCode] to join, you have to provide
  /// [accessCode] as parameter. After this method completes successfully,
  /// channel event [ChannelEventHandler.onUserJoined] will be invoked.
  Future<void> acceptInvitation({String accessCode}) async {
    //await or return?
    await _sdk.api.acceptInvitation(
      channelUrl: channelUrl,
      accessCode: accessCode,
    );
  }

  /// Declines received invitation to join this channel.
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onUserDeclinedInvitation] will be invoked.
  Future<void> declineInvitation() async {
    await _sdk.api.declineInvitation(channelUrl: channelUrl);
  }

  /// Joins this channel
  ///
  /// If this channel sets [accessCode] to join, you have to provide
  /// [accessCode] as parameter. After this method completes successfully,
  /// channel event [ChannelEventHandler.onUserJoined] will be invoked.
  Future<void> join({String accessCode}) async {
    await _sdk.api.joinGroupChannel(
      channelUrl: channelUrl,
      accessCode: accessCode,
    );
  }

  /// Leaves this channel
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onUserLeaved] will be invoked.
  Future<void> leave() async {
    await _sdk.api.leaveGroupChannel(channelUrl: channelUrl);
  }

  /// Resets (clear) any previous messages on this channel.
  Future<void> resetMyHistory() async {
    final offset =
        await _sdk.api.resetGroupChannelHistory(channelUrl: channelUrl);
    if (offset != null) {
      messageOffsetTimestamp = offset;
    }
  }
}
