import 'package:flutter/foundation.dart';

import 'channel_event_handler.dart';
import 'connection_event_handler.dart';
import 'session_event_handler.dart';
import 'user_event_handler.dart';

import '../channel/base_channel.dart';
import '../channel/group_channel.dart';
import '../channel/open_channel.dart';
import '../constant/enums.dart';
import '../events/reaction_event.dart';
import '../events/thread_info_update_event.dart';
import '../message/base_message.dart';
import '../models/responses.dart';
import '../models/error.dart';
import '../models/user.dart';
import '../sdk/sendbird_sdk_api.dart';
import '../sdk/sendbird_sdk_internal.dart';
import '../utils/logger.dart';

abstract class EventHandler {}

enum EventType { channel, connection, session, userEvent }

class EventManager {
  Map<String, ChannelEventHandler> _channelHandlers = {};
  Map<String, ConnectionEventHandler> _connectionHandlers = {};
  Map<String, UserEventHandler> _userHandlers = {};
  SessionEventHandler _sessionHandler;

  SendbirdSdkInternal get sdk => SendbirdSdk().getInternal();

  void addHandler(String identifier, EventHandler handler) {
    if (handler is ChannelEventHandler) {
      _channelHandlers[identifier] = handler;
    } else if (handler is ConnectionEventHandler) {
      _connectionHandlers[identifier] = handler;
    } else if (handler is SessionEventHandler) {
      _sessionHandler = handler;
    } else if (handler is UserEventHandler) {
      _userHandlers[identifier] = handler;
    }
  }

  void removeHandler(String identifier, EventType type) {
    switch (type) {
      case EventType.channel:
        _channelHandlers.remove(identifier);
        break;
      case EventType.connection:
        _connectionHandlers.remove(identifier);
        break;
      case EventType.session:
        _sessionHandler = null;
        // sessionManager.removeHandler(identifier);
        break;
      case EventType.userEvent:
        _userHandlers.remove(identifier);
        break;
      default:
        break;
    }
  }

  void removeAll(EventType type) {
    switch (type) {
      case EventType.channel:
        _channelHandlers = {};
        break;
      case EventType.connection:
        _connectionHandlers = {};
        break;
      case EventType.session:
        _sessionHandler = null;
        break;
      case EventType.userEvent:
        _userHandlers = {};
        break;
      default:
        break;
    }
  }

  EventHandler getHandler({
    String identifier,
    @required EventType type,
  }) {
    switch (type) {
      case EventType.channel:
        return _channelHandlers[identifier];
      case EventType.connection:
        return _connectionHandlers[identifier];
      case EventType.session:
        return _sessionHandler;
      case EventType.userEvent:
        return _userHandlers[identifier];
      default:
        return null;
    }
  }

  List<EventHandler> getHandlers(EventType type) {
    switch (type) {
      case EventType.channel:
        return _channelHandlers.values.toList();
      case EventType.connection:
        return _connectionHandlers.values.toList();
      case EventType.session:
        return [_sessionHandler];
      case EventType.userEvent:
        return _userHandlers.values.toList();
      default:
        return null;
    }
  }

  void cleanUp() {
    _channelHandlers = {};
    _connectionHandlers = {};
    _userHandlers = {};
    _sessionHandler = null;
  }

  void notifyMessageReceived(BaseChannel channel, BaseMessage message) {
    sdk.messageReceiveStreamController
        .add(ChannelMessageResponse(channel, message));

    _channelHandlers.values.forEach((element) {
      element.onMessageReceived(channel, message);
    });
  }

  void notifyMessageUpdate(BaseChannel channel, BaseMessage message) {
    sdk.messageUpdateStreamController
        .add(ChannelMessageResponse(channel, message));

    _channelHandlers.values.forEach((element) {
      element.onMessageUpdated(channel, message);
    });
  }

  void notifyMessageDeleted(BaseChannel channel, int messageId) {
    //delete controller
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
    User inviter,
  ) {
    _channelHandlers.values.forEach((element) {
      element.onUserReceivedInvitation(channel, invitees, inviter);
    });
  }

  void notifyInvitationDeclied(
    GroupChannel channel,
    User invitee,
    User inviter,
  ) {
    _channelHandlers.values.forEach((element) {
      element.onUserDeclinedInvitation(channel, invitee, inviter);
    });
  }

  void notifyChannelChanged(BaseChannel channel) {
    sdk.channelChangedStreamController.add(channel);

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
    sdk.usersTypingStreamController.add(channel);

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
    sdk.readStreamController.add(channel);

    _channelHandlers.values.forEach((element) {
      element.onReadReceiptUpdated(channel);
    });
  }

  void notifyDeliveryReceiptUpdated(GroupChannel channel) {
    sdk.deliveryStreamController.add(channel);

    _channelHandlers.values.forEach((element) {
      element.onDeliveryReceiptUpdated(channel);
    });
  }

  void notifyReactionUpdated(BaseChannel channel, ReactionEvent event) {
    _channelHandlers.values.forEach((element) {
      element.onReactionUpdated(channel, event);
    });
  }

  void notifyChannelMetaDataChanged(
      BaseChannel channel, Map<String, dynamic> data) {
    _channelHandlers.values.forEach((element) {
      final created = Map<String, String>.from(data["created"] ?? {});
      final updated = Map<String, String>.from(data["updated"] ?? {});
      final deleted = List<String>.from(data["deleted"] ?? []);

      if (created.isNotEmpty)
        element.onChannelMetaDataCreated(channel, created);
      if (updated.isNotEmpty)
        element.onChannelMetaDataUpdated(channel, updated);
      if (deleted.isNotEmpty)
        element.onChannelMetaDataDeleted(channel, deleted);
    });
  }

  void notifyChannelMetaCountersChanged(
      BaseChannel channel, Map<String, dynamic> data) {
    _channelHandlers.values.forEach((element) {
      final created = Map<String, int>.from(data["created"] ?? {});
      final updated = Map<String, int>.from(data["updated"] ?? {});
      final deleted = List<String>.from(data["deleted"] ?? []);

      if (created.isNotEmpty)
        element.onChannelMetaCountersCreated(channel, created);
      if (updated.isNotEmpty)
        element.onChannelMetaCountersUpdated(channel, updated);
      if (deleted.isNotEmpty)
        element.onChannelMetaCountersDeleted(channel, deleted);
    });
  }

  // session
  void notifySessionExpired() {
    logger.i('[Sendbird] Notifying session expired');
    _sessionHandler?.onSessionExpired();
  }

  void notifySessionTokenRequired() {
    logger.i('[Sendbird] Notifying session token required');
    _sessionHandler?.onSessionTokenRequired(
      sdk.sessionManager.successFunc,
      sdk.sessionManager.errorFunc,
    );
  }

  void notifySessionRefreshed() {
    logger.i('[Sendbird] Notifying session refreshed $_sessionHandler');
    _sessionHandler?.onSessionRefreshed();
  }

  void notifySessionError(SBError error) {
    logger.i('[Sendbird] Notifying session error ${error.code}');
    _sessionHandler?.onSessionError(error);
  }

  void notifySessionClosed() {
    logger.i('[Sendbird] Notifying session closed');
    _sessionHandler.onSessionClosed();
  }

  // UserEvent
  void notifyDiscoveredFriend(List<User> friends) {
    _userHandlers.values.forEach((element) {
      element.onDiscoverFriends(friends);
    });
  }

  void notifyUpdateTotalUnreadMessageCount(
      int totalCount, Map<String, num> customTypesCount) {
    _userHandlers.values.forEach((element) {
      element.onUpdateTotalUnreadMessageCount(totalCount, customTypesCount);
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
      element.onReconnectionCancelled();
    });
  }
}
