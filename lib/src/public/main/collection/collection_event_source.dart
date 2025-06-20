// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

/// Indicates the source of an event.
/// [isFromEvent] is true only when it comes from the socket.
enum CollectionEventSource {
  // Channel (isFromEvent = false)
  channelCacheLoadMore(false), // loadMore()
  channelLoadMore(false), // loadMore()
  channelChangeLogs(false), // onReconnectSucceeded()
  channelRefreshed(false), // onReconnectSucceeded()

  // Channel (isFromEvent = true)
  eventMentionReceived(true), // onChannelUpdated()
  eventChannelChanged(true), // onChannelUpdated()
  eventChannelDeleted(true), // onChannelDeleted()
  eventUserMuted(true), // onChannelUpdated()
  eventUserUnmuted(true), // onChannelUpdated()
  eventUserBanned(true), // onLeaveChannel()
  eventUserUnbanned(true), // onChannelUpdated()
  eventChannelFrozen(true), // onChannelUpdated()
  eventChannelUnfrozen(true), // onChannelUpdated()
  eventChannelMetaDataCreated(true), // onChannelUpdated()
  eventChannelMetaDataUpdated(true), // onChannelUpdated()
  eventChannelMetaDataDeleted(true), // onChannelUpdated()
  eventChannelMetaCountersCreated(true), // onChannelUpdated()
  eventChannelMetaCountersUpdated(true), // onChannelUpdated()
  eventChannelMetaCountersDeleted(true), // onChannelUpdated()
  eventOperatorUpdated(true), // onChannelUpdated()
  @Deprecated('Use [eventUserMarkedRead] and [eventUserMarkedUnread] instead.')
  eventReadStatusUpdated(true), // onChannelUpdated()
  /// eventDetail: List<String> userIds
  /// @since 4.4.0
  eventUserMarkedRead(true), // onChannelUpdated()
  /// eventDetail: List<String> userIds
  /// @since 4.4.0
  eventUserMarkedUnread(true), // onChannelUpdated()
  eventDeliveryStatusUpdated(true), // onChannelUpdated()
  eventTypingStatusUpdated(true), // onChannelUpdated()
  eventUserReceivedInvitation(true), // onChannelUpdated()
  eventUserDeclinedInvitation(true), // onLeaveChannel()
  eventUserJoined(true), // onChannelUpdated()
  eventUserLeft(true), // onLeaveChannel()
  eventChannelHidden(true), // onChannelUpdated()
  eventChannelMemberCountChanged(true), // onChannelsUpdated()
  eventPinnedMessageUpdated(true), // onChannelUpdated()

  // Message (isFromEvent = false)
  messageCacheInitialize(false), // initialize()
  messageCacheLoadPrevious(false), // loadPrevious()
  messageCacheLoadNext(false), // loadNext()
  messageInitialize(false), // initialize()
  messageLoadPrevious(false), // loadPrevious()
  messageLoadNext(false), // loadNext()
  messageChangeLogs(false), // onReconnectSucceeded()
  pollChangeLogs(false), // onReconnectSucceeded()
  messageFill(false), // onReconnectSucceeded()
  localMessagePendingCreated(false), // sendUserMessage(), sendFileMessage()
  localMessageFailed(false), // sendUserMessage(), sendFileMessage()
  localMessageCanceled(false), // sendFileMessage()
  localMessageResendStarted(false), // resendUserMessage(), resendFileMessage()

  // Message (isFromEvent = true)
  eventMessageSent(true), // onMessageAdded()
  eventMessageReceived(true), // onMessageAdded()
  eventMessageUpdated(true), // onMessageUpdated()
  eventMessageDeleted(true), // onMessageDeleted()
  eventReactionUpdated(true), // onMessageUpdated()
  eventThreadInfoUpdated(true), // onMessageUpdated()
  eventPollVoted(true), // onMessageUpdated()
  eventPollUpdated(true), // onMessageUpdated()
  ;

  const CollectionEventSource(this.isFromEvent);

  /// Whether this source came from the real-time event.
  final bool isFromEvent;
}
