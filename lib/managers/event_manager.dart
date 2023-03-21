import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/channel/base/base_channel.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/channel/open/open_channel.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/events/poll_update_event.dart';
import 'package:sendbird_sdk/events/poll_vote_event.dart';
import 'package:sendbird_sdk/features/reaction/reaction_event.dart';
import 'package:sendbird_sdk/features/threading/thread_info_update_event.dart';
import 'package:sendbird_sdk/handlers/channel_event_handler.dart';
import 'package:sendbird_sdk/handlers/connection_event_handler.dart';
import 'package:sendbird_sdk/handlers/session_event_handler.dart';
import 'package:sendbird_sdk/handlers/user_event_handler.dart';
import 'package:sendbird_sdk/sdk/internal/sendbird_sdk_internal.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:sendbird_sdk/utils/logger.dart';

abstract class EventHandler {}

class EventManager {
  Map<String, ChannelEventHandler> _channelHandlers = {};
  Map<String, ConnectionEventHandler> _connectionHandlers = {};
  Map<String, UserEventHandler> _userHandlers = {};
  SessionEventHandler? _sessionHandler;

  SendbirdSdkInternal get sdk => SendbirdSdk().getInternal();

  void addChannelHandler(String identifier, ChannelEventHandler handler) {
    _channelHandlers[identifier] = handler;
  }

  void addConnectionHandler(String identifier, ConnectionEventHandler handler) {
    _connectionHandlers[identifier] = handler;
  }

  void addSessionHandler(SessionEventHandler handler) {
    _sessionHandler = handler;
  }

  void addUserHandler(String identifier, UserEventHandler handler) {
    _userHandlers[identifier] = handler;
  }

  void removeChannelHandler(String identifier) {
    _channelHandlers.remove(identifier);
  }

  void removeConnectionHandler(String identifier) {
    _connectionHandlers.remove(identifier);
  }

  void removeUserHandler(String identifier) {
    _userHandlers.remove(identifier);
  }

  void removeSessionHandler() {
    _sessionHandler = null;
  }

  ChannelEventHandler? getChannelHandler(String identifier) {
    return _channelHandlers[identifier];
  }

  ConnectionEventHandler? getConnectionHandler(String identifier) {
    return _connectionHandlers[identifier];
  }

  UserEventHandler? getUserHandler(String identifier) {
    return _userHandlers[identifier];
  }

  SessionEventHandler? getSessionHandler() {
    return _sessionHandler;
  }

  void cleanUp() {
    _channelHandlers = {};
    _connectionHandlers = {};
    _userHandlers = {};
    _sessionHandler = null;
  }

  void notifyMessageReceived(BaseChannel channel, BaseMessage message) {
    sdk.streamManager.msgReceived
        .add(ChannelMessageResponse(channel, message: message));

    _channelHandlers.values.forEach((element) {
      element.onMessageReceived(channel, message);
    });
  }

  void notifyMessageUpdate(BaseChannel channel, BaseMessage message) {
    sdk.streamManager.msgUpdated
        .add(ChannelMessageResponse(channel, message: message));

    _channelHandlers.values.forEach((element) {
      element.onMessageUpdated(channel, message);
    });
  }

  void notifyMessageDeleted(BaseChannel channel, int messageId) {
    sdk.streamManager.msgDeletd
        .add(ChannelMessageResponse(channel, deletedId: messageId));

    _channelHandlers.values.forEach((element) {
      element.onMessageDeleted(channel, messageId);
    });
  }

  void notifyMentionReceived(BaseChannel channel, BaseMessage message) {
    _channelHandlers.values.forEach((element) {
      element.onMentionReceived(channel, message);
    });
  }

  void notifyUserJoined(GroupChannel channel, User user) {
    _channelHandlers.values.forEach((element) {
      element.onUserJoined(channel, user);
    });
  }

  void notifyUserLeaved(GroupChannel channel, User user) {
    _channelHandlers.values.forEach((element) {
      element.onUserLeaved(channel, user);
    });
  }

  void notifyUserEntered(OpenChannel channel, User user) {
    _channelHandlers.values.forEach((element) {
      element.onUserEntered(channel, user);
    });
  }

  void notifyUserExited(OpenChannel channel, User user) {
    _channelHandlers.values.forEach((element) {
      element.onUserExited(channel, user);
    });
  }

  void notifyUserBanned(BaseChannel channel, User user) {
    _channelHandlers.values.forEach((element) {
      element.onUserBanned(channel, user);
    });
  }

  void notifyUserUnbanned(BaseChannel channel, User user) {
    _channelHandlers.values.forEach((element) {
      element.onUserUnbanned(channel, user);
    });
  }

  void notifyUserMuted(BaseChannel channel, User user) {
    _channelHandlers.values.forEach((element) {
      element.onUserMuted(channel, user);
    });
  }

  void notifyUserUnmuted(BaseChannel channel, User user) {
    _channelHandlers.values.forEach((element) {
      element.onUserUnmuted(channel, user);
    });
  }

  void notifyInvitationReceived(
    GroupChannel channel,
    List<User> invitees,
    User? inviter,
  ) {
    _channelHandlers.values.forEach((element) {
      element.onUserReceivedInvitation(channel, invitees, inviter);
    });
  }

  void notifyInvitationDeclied(
    GroupChannel channel,
    User invitee,
    User? inviter,
  ) {
    _channelHandlers.values.forEach((element) {
      element.onUserDeclinedInvitation(channel, invitee, inviter);
    });
  }

  void notifyChannelChanged(BaseChannel channel) {
    sdk.streamManager.channelChanged.add(channel);

    _channelHandlers.values.forEach((element) {
      element.onChannelChanged(channel);
    });
  }

  void notifyChannelDeleted(String channelUrl, ChannelType channelType) {
    _channelHandlers.values.forEach((element) {
      element.onChannelDeleted(channelUrl, channelType);
    });
  }

  void notifyChannelHidden(BaseChannel channel) {
    _channelHandlers.values.forEach((element) {
      element.onChannelHidden(channel);
    });
  }

  void notifyChannelFrozen(BaseChannel channel) {
    _channelHandlers.values.forEach((element) {
      element.onChannelFrozen(channel);
    });
  }

  void notifyChannelUnfrozen(BaseChannel channel) {
    _channelHandlers.values.forEach((element) {
      element.onChannelUnfrozen(channel);
    });
  }

  void notifyChannelTypingStatusUpdated(GroupChannel channel) {
    sdk.streamManager.typing.add(channel);

    _channelHandlers.values.forEach((element) {
      element.onTypingStatusUpdated(channel);
    });
  }

  void notifyChannelOperatorsUpdated(BaseChannel channel) {
    _channelHandlers.values.forEach((element) {
      element.onChannelOperatorsUpdated(channel);
    });
  }

  void notifyChannelThreadUpdated(
      GroupChannel channel, ThreadInfoUpdateEvent event) {
    _channelHandlers.values.forEach((element) {
      element.onThreadInfoUpdated(channel, event);
    });
  }

  void notifyChannelMemberCountChange(List<GroupChannel> channels) {
    _channelHandlers.values.forEach((element) {
      element.onChannelMemberCountChanged(channels);
    });
  }

  void notifyChannelParticiapntCountChanged(List<OpenChannel> channels) {
    _channelHandlers.values.forEach((element) {
      element.onChannelParticipantCountChanged(channels);
    });
  }

  void notifyChannelReadReceiptUpdated(GroupChannel channel) {
    sdk.streamManager.read.add(channel);

    _channelHandlers.values.forEach((element) {
      element.onReadReceiptUpdated(channel);
    });
  }

  void notifyDeliveryReceiptUpdated(GroupChannel channel) {
    sdk.streamManager.delivery.add(channel);

    _channelHandlers.values.forEach((element) {
      element.onDeliveryReceiptUpdated(channel);
    });
  }

  void notifyReactionUpdated(BaseChannel channel, ReactionEvent event) {
    _channelHandlers.values.forEach((element) {
      element.onReactionUpdated(channel, event);
    });
  }

  void notifyMetaDataChanged(BaseChannel channel, Map<String, dynamic> data) {
    _channelHandlers.values.forEach((element) {
      final created = Map<String, String>.from(data['created'] ?? {});
      final updated = Map<String, String>.from(data['updated'] ?? {});
      final deleted = List<String>.from(data['deleted'] ?? []);

      if (created.isNotEmpty) element.onMetaDataCreated(channel, created);
      if (updated.isNotEmpty) element.onMetaDataUpdated(channel, updated);
      if (deleted.isNotEmpty) element.onMetaDataDeleted(channel, deleted);
    });
  }

  void notifyMetaCountersChanged(
      BaseChannel channel, Map<String, dynamic> data) {
    _channelHandlers.values.forEach((element) {
      final created = Map<String, int>.from(data['created'] ?? {});
      final updated = Map<String, int>.from(data['updated'] ?? {});
      final deleted = List<String>.from(data['deleted'] ?? []);

      if (created.isNotEmpty) element.onMetaCountersCreated(channel, created);
      if (updated.isNotEmpty) element.onMetaCountersUpdated(channel, updated);
      if (deleted.isNotEmpty) element.onMetaCountersDeleted(channel, deleted);
    });
  }

  // session
  void notifySessionExpired() {
    logger.i('Notifying session expired');
    _sessionHandler?.onSessionExpired();
  }

  void notifySessionTokenRequired() {
    logger.i('Notifying session token required');
    _sessionHandler?.onSessionTokenRequired(
      sdk.sessionManager.successFunc,
      sdk.sessionManager.errorFunc,
    );
  }

  void notifySessionRefreshed() {
    logger.i('Notifying session refreshed $_sessionHandler');
    _sessionHandler?.onSessionRefreshed();
  }

  void notifySessionError(SBError error) {
    logger.i('Notifying session error $error');
    _sessionHandler?.onSessionError(error);
  }

  void notifySessionClosed() {
    logger.i('Notifying session closed');
    _sessionHandler?.onSessionClosed();
  }

  // UserEvent
  void notifyFriendsDiscovered(List<User> friends) {
    _userHandlers.values.forEach((element) {
      element.onFriendsDiscovered(friends);
    });
  }

  void notifyTotalUnreadMessageCountUpdated(
      int totalCount, Map<String, num> customTypesCount) {
    _userHandlers.values.forEach((element) {
      element.onTotalUnreadMessageCountUpdated(totalCount, customTypesCount);
    });
  }

  // Connection
  void notifyReconnectionStarted() {
    _connectionHandlers.values.forEach((element) {
      element.onReconnectionStarted();
    });
  }

  void notifyReconnectionSucceeded() {
    _connectionHandlers.values.forEach((element) {
      element.onReconnectionSucceeded();
    });
  }

  void notifyReconnectionFailed() {
    _connectionHandlers.values.forEach((element) {
      element.onReconnectionFailed();
    });
  }

  void notifyReconnectionCanceled() {
    _connectionHandlers.values.forEach((element) {
      element.onReconnectionCanceled();
    });
  }

  void notifyPollUpdated(PollUpdateEvent event) {
    _channelHandlers.values.forEach((element) {
      element.onPollUpdated(event);
    });
  }

  void notifyPollVoted(PollVoteEvent event) {
    _channelHandlers.values.forEach((element) {
      element.onPollVoted(event);
    });
  }

  void notifyPollDeleted(int pollId) {
    _channelHandlers.values.forEach((element) {
      element.onPollDeleted(pollId);
    });
  }

  void notifyPinUpdated(BaseChannel channel) {
    _channelHandlers.values.forEach((element) {
      element.onPinUpdated(channel);
    });
  }
}
