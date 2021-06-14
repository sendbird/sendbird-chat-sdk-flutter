part of 'group_channel.dart';

/// Set of functionality related to configure group channel
extension GroupChannelConfiguration on GroupChannel {
  /// Hides this channel.
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onChannelHidden] will be invoked.
  Future<void> hideChannel({
    bool hidePreviousMessage = false,
    bool allowAutoUnhide = true,
  }) async {
    final offset = await _sdk.api.hideGroupChannel(
      channelUrl: channelUrl,
      hidePreviousMessages: hidePreviousMessage,
      allowAutoUnhide: allowAutoUnhide,
    );

    if (offset != null) messageOffsetTimestamp = offset;
    if (hidePreviousMessage) clearUnreadCount();

    isHidden = true;
    hiddenState = allowAutoUnhide
        ? GroupChannelHiddenState.allowAutoUnhide
        : GroupChannelHiddenState.preventAutoUnhide;
  }

  /// Unhides this channel
  Future<void> unhideChannel() async {
    await _sdk.api.unhideGroupChannel(channelUrl: channelUrl);
    isHidden = false;
    hiddenState = GroupChannelHiddenState.unhidden;
  }

  /// Returns current user's [GroupChannelPushTriggerOption] on this channel.
  Future<GroupChannelPushTriggerOption> getMyPushTriggerOption() async {
    return _sdk.api.getGroupChannelPushTriggerOption(channelUrl);
  }

  /// Sets current user's push trigger [option] on this channel.
  Future<void> setMyPushTriggerOption(
    GroupChannelPushTriggerOption option,
  ) async {
    final result = await _sdk.api.setGroupChannelPushTriggerOption(
      channelUrl: channelUrl,
      option: option,
    );
    myPushTriggerOption = result;
  }

  /// Sets current user's count preference with [countPreference].
  Future<void> setMyCountPreference(CountPreference countPreference) async {
    final result = await _sdk.api.setCountPreference(
      channelUrl: channelUrl,
      prefs: countPreference,
    );
    myCountPreference = result;
    if (canChangeUnreadMessageCount) unreadMessageCount = 0;
    if (canChangeUnreadMentionCount) unreadMentionCount = 0;
  }

  /// Freezes this channel.
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onChannelFrozen] will be invoked. Operator only
  Future<void> freeze() async {
    return _sdk.api.freezeChannel(
      channelType: channelType,
      channelUrl: channelUrl,
      freeze: true,
    );
  }

  /// Unfreezes this channel.
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onChannelUnfrozen] will be invoked. Operator only
  Future<void> unfreeze() async {
    return _sdk.api.freezeChannel(
      channelType: channelType,
      channelUrl: channelUrl,
      freeze: false,
    );
  }

  /// Notifies screenshot was taken on this channel.
  Future<void> notifyScreenshotWasTaken() async {
    return _sdk.api.notifyScreenshotWasTaken(channelUrl);
  }
}
