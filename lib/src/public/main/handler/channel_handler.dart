// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

abstract class RootChannelHandler {}

/// The BaseChannel handler.
/// This handler provides callbacks for events related [OpenChannel] or [GroupChannel].
/// All callbacks are called only when the currently logged-in [User] is a participant or member of `OpenChannel` or `GroupChannel` respectively.
/// To add or remove this handler, refer to [SendbirdChat.addChannelHandler] and [SendbirdChat.removeChannelHandler].
abstract class BaseChannelHandler extends RootChannelHandler {
  /// A callback for when a message is received.
  void onMessageReceived(BaseChannel channel, BaseMessage message);

  /// A callback for when a message is updated.
  void onMessageUpdated(BaseChannel channel, BaseMessage message) {}

  /// A callback for when a message is deleted.
  void onMessageDeleted(BaseChannel channel, int messageId) {}

  /// A callback for when a mention is received.
  void onMentionReceived(BaseChannel channel, BaseMessage message) {}

  /// A callback for when channel property is changed.
  void onChannelChanged(BaseChannel channel) {}

  /// A callback for when channel is deleted.
  void onChannelDeleted(String channelUrl, ChannelType channelType) {}

  /// A callback for when a reactionEvent is updated.
  /// Not for FeedChannel
  void onReactionUpdated(BaseChannel channel, ReactionEvent event) {}

  /// A callback for when a user is muted from channel.
  /// Not for FeedChannel
  void onUserMuted(BaseChannel channel, RestrictedUser restrictedUser) {}

  /// A callback for when a user is unmuted from channel.
  /// Not for FeedChannel
  void onUserUnmuted(BaseChannel channel, User user) {}

  /// A callback for when a user is banned from channel.
  /// Not for FeedChannel
  void onUserBanned(BaseChannel channel, RestrictedUser restrictedUser) {}

  /// A callback for when a user is unbanned from channel.
  /// Not for FeedChannel
  void onUserUnbanned(BaseChannel channel, User user) {}

  /// A callback for when channel is frozen (Users can't send messages).
  /// Not for FeedChannel
  void onChannelFrozen(BaseChannel channel) {}

  /// A callback for when channel is unfrozen (Users can send messages).
  /// Not for FeedChannel
  void onChannelUnfrozen(BaseChannel channel) {}

  /// A callback for when channel meta data is created.
  /// Not for FeedChannel
  void onMetaDataCreated(BaseChannel channel, Map<String, String> metaData) {}

  /// A callback for when channel meta data is updated.
  /// Not for FeedChannel
  void onMetaDataUpdated(BaseChannel channel, Map<String, String> metaData) {}

  /// A callback for when channel meta data is deleted.
  /// Not for FeedChannel
  void onMetaDataDeleted(BaseChannel channel, List<String> metaDataKeys) {}

  /// A callback for when channel meta counters is created.
  /// Not for FeedChannel
  void onMetaCountersCreated(
      BaseChannel channel, Map<String, int> metaCounters) {}

  /// A callback for when channel meta counters is updated.
  /// Not for FeedChannel
  void onMetaCountersUpdated(
      BaseChannel channel, Map<String, int> metaCounters) {}

  /// A callback for when channel meta counters are deleted.
  /// Not for FeedChannel
  void onMetaCountersDeleted(
      BaseChannel channel, List<String> metaCounterKeys) {}

  /// A callback for when operators change in channel
  /// Not for FeedChannel
  void onOperatorUpdated(BaseChannel channel) {}

  /// A callback for when the thread information is updated.
  /// Not for FeedChannel
  void onThreadInfoUpdated(BaseChannel channel, ThreadInfoUpdateEvent event) {}
}

/// The GroupChannel handler.
abstract class GroupChannelHandler extends BaseChannelHandler {
  /// A callback for when read receipts are updated on [GroupChannel].
  /// To use the updated read receipt, refer to [GroupChannelRead.getReadStatus],
  /// [GroupChannelRead.getReadMembers], [GroupChannelRead.getUnreadMembers].
  void onReadStatusUpdated(GroupChannel channel) {}

  /// A callback for when delivered receipts are updated on `GroupChannel`.
  /// To use the updated delivered receipt, refer to [GroupChannelRead.getUndeliveredMembers]
  void onDeliveryStatusUpdated(GroupChannel channel) {}

  /// A callback for when `User`s send typing status for `GroupChannel`.
  /// To use the typing status, refer to [GroupChannelTyping.isTyping] and [GroupChannelTyping.getTypingUsers].
  void onTypingStatusUpdated(GroupChannel channel) {}

  /// A callback for when a new member has been invited to `GroupChannel`.
  /// If the member accepts the invitation (refer to [GroupChannelOperation.acceptInvitation]),
  /// [onUserJoined] will be called.
  /// Or, the member can also decline the invitation (refer to [GroupChannelOperation.declineInvitation])
  /// to cause [onUserDeclinedInvitation].
  void onUserReceivedInvitation(
      GroupChannel channel, List<User> invitees, User? inviter) {}

  /// A callback for when the newly invited member has declined the invitation for the [GroupChannel].
  void onUserDeclinedInvitation(
      GroupChannel channel, User invitee, User? inviter) {}

  /// A callback for when a new member has joined [GroupChannel].
  /// To use the updated member list, refer to [GroupChannel.members] and [GroupChannel.memberCount].
  void onUserJoined(GroupChannel channel, User user) {}

  /// A callback for when an existing member has left [GroupChannel].
  /// To use the updated member list and count, refer to [GroupChannel.members] and [GroupChannel.memberCount].
  void onUserLeft(GroupChannel channel, User user) {}

  /// A callback for when [GroupChannel] is hidden.
  void onChannelHidden(GroupChannel channel) {}

  /// Called when one or more broadcast channel's member counts are changed.
  void onChannelMemberCountChanged(List<GroupChannel> channels) {}

  /// Called when one or more vote is cast/canceled on a poll. The user should search for
  /// cached messages that contain this event's poll ([PollVoteEvent.pollId], [PollVoteEvent.messageId]) and
  /// call [Poll.applyPollVoteEvent] on those messages.
  void onPollVoted(GroupChannel channel, PollVoteEvent event) {}

  /// Called when a poll is updated.
  /// The user should search for cached messages
  /// that contain this event's poll ([PollUpdateEvent.pollId], [PollUpdateEvent.messageId]) and
  /// call [Poll.applyPollUpdateEvent] on those messages.
  void onPollUpdated(GroupChannel channel, PollUpdateEvent event) {}

  /// Called when a poll is deleted.
  void onPollDeleted(GroupChannel channel, int pollId) {}

  /// A callback for when pinned message is changed.
  void onPinnedMessageUpdated(GroupChannel channel) {}
}

/// The OpenChannel handler.
abstract class OpenChannelHandler extends BaseChannelHandler {
  /// A callback for when a [User] has entered [OpenChannel].
  /// To use the updated participant count, refer to [OpenChannel.participantCount].
  void onUserEntered(OpenChannel channel, User user) {}

  /// A callback for when a [User] has exited [OpenChannel].
  /// To use the updated participant count, refer to [OpenChannel.participantCount].
  void onUserExited(OpenChannel channel, User user) {}

  /// Called when one or more open channel's member counts are changed.
  void onChannelParticipantCountChanged(List<OpenChannel> channels) {}
}

/// The FeedChannel handler.
/// @since 4.1.0
abstract class FeedChannelHandler extends RootChannelHandler {
  /// A callback for when a message is received.
  /// @since 4.1.0
  void onMessageReceived(FeedChannel channel, NotificationMessage message);

  /// A callback for when channel property is changed.
  /// @since 4.1.0
  void onChannelChanged(FeedChannel channel) {}
}
