// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'group_channel.dart';

/// GroupChannelConfiguration
extension GroupChannelConfiguration on GroupChannel {
  /// Hides this channel from the current `User's `GroupChannel` list.
  /// When a new message is received from the channel, it appears again.
  ///
  /// If [hidePreviousMessage] is set true, the messages created before the hide will not be loaded anymore when the channel reappears.
  /// If [allowAutoUnhide] is set true, when a new message is received from the channel, it appears again.
  Future<void> hide({
    bool hidePreviousMessage = false,
    bool allowAutoUnhide = true,
  }) async {
    sbLog.i(StackTrace.current,
        'hidePreviousMessage: $hidePreviousMessage, allowAutoUnhide: $allowAutoUnhide');

    final res = await chat.apiClient.send(GroupChannelHideRequest(
      chat,
      channelUrl,
      hidePreviousMessages: hidePreviousMessage,
      allowAutoUnhide: allowAutoUnhide,
    ));

    messageOffsetTimestamp = res?['ts_message_offset'] as int?;
    if (hidePreviousMessage) clearUnreadCount();

    isHidden = true;
    hiddenState = allowAutoUnhide
        ? GroupChannelHiddenState.allowAutoUnhide
        : GroupChannelHiddenState.preventAutoUnhide;
  }

  /// Unhides this channel from the current `User`'s `GroupChannel` list.
  Future<void> unhide() async {
    sbLog.i(StackTrace.current);

    await chat.apiClient
        .send(GroupChannelUnhideRequest(chat, channelUrl: channelUrl));
    isHidden = false;
    hiddenState = GroupChannelHiddenState.unhidden;
  }

  /// Gets push trigger option of this channel. Refer to [PushTriggerOption].
  /// For details of push trigger option, refer to [setMyPushTriggerOption]
  Future<GroupChannelPushTriggerOption> getMyPushTriggerOption() async {
    sbLog.i(StackTrace.current);

    return await chat.apiClient.send<GroupChannelPushTriggerOption>(
      GroupChannelPushTriggerOptionGetRequest(chat, channelUrl: channelUrl),
    );
  }

  /// Sets push trigger option of this channel.
  /// If channel's push trigger option is set to [GroupChannelPushTriggerOption.defaultValue],
  /// it works according to the state of [PushTriggerOption].
  /// If not, push messages will be triggered according to the state of [GroupChannelPushTriggerOption].
  ///
  /// @param pushTriggerOption `PushTriggerOption`. Refer to [GroupChannelPushTriggerOption].
  Future<void> setMyPushTriggerOption(
    GroupChannelPushTriggerOption option,
  ) async {
    sbLog.i(StackTrace.current, 'option: $option');

    final res = await chat.apiClient.send<GroupChannelPushTriggerOption>(
      GroupChannelPushTriggerOptionSetRequest(
        chat,
        channelUrl: channelUrl,
        option: option,
      ),
    );
    myPushTriggerOption = res;
  }

  /// Sets my count preference for this channel.
  Future<void> setMyCountPreference(CountPreference countPreference) async {
    sbLog.i(StackTrace.current, 'countPreference: $countPreference');

    final result = await chat.apiClient.send<CountPreference>(
      GroupChannelCountReferenceRequest(
        chat,
        channelUrl: channelUrl,
        prefs: countPreference,
      ),
    );
    myCountPreference = result;
    if (canChangeUnreadMessageCount) unreadMessageCount = 0;
    if (canChangeUnreadMentionCount) unreadMentionCount = 0;
  }

  /// Freeze this `GroupChannel`.
  Future<void> freeze() async {
    sbLog.i(StackTrace.current);

    await chat.apiClient.send(GroupChannelFreezeSetRequest(
      chat,
      channelUrl: channelUrl,
      freeze: true,
    ));
  }

  /// Unfreeze this `GroupChannel`.
  Future<void> unfreeze() async {
    sbLog.i(StackTrace.current);

    await chat.apiClient.send(GroupChannelFreezeSetRequest(
      chat,
      channelUrl: channelUrl,
      freeze: false,
    ));
  }

  /// Notifies the current user took a screenshot in this channel.
  /// The server is going to send an admin message to notify this in the group channel.
  Future<void> notifyScreenshotWasTaken() async {
    sbLog.i(StackTrace.current);

    await chat.apiClient
        .send(GroupChannelScreenshotRequest(chat, channelUrl: channelUrl));
  }
}
