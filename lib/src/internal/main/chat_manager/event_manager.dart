// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat_manager/session_manager.dart';
import 'package:sendbird_chat/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat/src/public/core/channel/open_channel/open_channel.dart';
import 'package:sendbird_chat/src/public/core/message/base_message.dart';
import 'package:sendbird_chat/src/public/core/user/restricted_user.dart';
import 'package:sendbird_chat/src/public/core/user/user.dart';
import 'package:sendbird_chat/src/public/main/define/enums.dart';
import 'package:sendbird_chat/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat/src/public/main/handler/channel_handler.dart';
import 'package:sendbird_chat/src/public/main/handler/connection_handler.dart';
import 'package:sendbird_chat/src/public/main/handler/session_handler.dart';
import 'package:sendbird_chat/src/public/main/handler/user_event_handler.dart';
import 'package:sendbird_chat/src/public/main/model/poll/poll_update_event.dart';
import 'package:sendbird_chat/src/public/main/model/poll/poll_vote_event.dart';
import 'package:sendbird_chat/src/public/main/model/reaction/reaction_event.dart';
import 'package:sendbird_chat/src/public/main/model/thread/thread_info_updated_event.dart';

class EventManager {
  final Map<String, BaseChannelHandler> _channelHandlers = {};
  final Map<String, ConnectionHandler> _connectionHandlers = {};
  final Map<String, UserEventHandler> _userHandlers = {};

  final Set<String> _internalChannelHandlerIdentifiers = {};

  SessionHandler? _sessionHandler;
  final AccessTokenRequester _accessTokenRequester;

  EventManager({required SessionManager sessionManager})
      : _accessTokenRequester = sessionManager.accessTokenRequester;

  void addChannelHandler(String identifier, BaseChannelHandler handler) {
    _channelHandlers[identifier] = handler;
  }

  void addInternalChannelHandler(
      String identifier, BaseChannelHandler handler) {
    _internalChannelHandlerIdentifiers.add(identifier);
    addChannelHandler(identifier, handler);
  }

  BaseChannelHandler? getChannelHandler(String identifier) {
    if (_internalChannelHandlerIdentifiers.contains(identifier)) {
      return null;
    }
    return _channelHandlers[identifier];
  }

  void removeChannelHandler(String identifier) {
    if (_internalChannelHandlerIdentifiers.contains(identifier)) {
      return;
    }
    _channelHandlers.remove(identifier);
  }

  void removeAllChannelHandlers() {
    final keys = _channelHandlers.keys.toList();
    for (final identifier in keys) {
      if (_internalChannelHandlerIdentifiers.contains(identifier)) {
        continue;
      }
      _channelHandlers.remove(identifier);
    }
  }

  void addConnectionHandler(String identifier, ConnectionHandler handler) {
    _connectionHandlers[identifier] = handler;
  }

  ConnectionHandler? getConnectionHandler(String identifier) {
    return _connectionHandlers[identifier];
  }

  void removeConnectionHandler(String identifier) {
    _connectionHandlers.remove(identifier);
  }

  void removeAllConnectionHandlers() {
    _connectionHandlers.clear();
  }

  void addUserEventHandler(String identifier, UserEventHandler handler) {
    _userHandlers[identifier] = handler;
  }

  UserEventHandler? getUserEventHandler(String identifier) {
    return _userHandlers[identifier];
  }

  void removeUserEventHandler(String identifier) {
    _userHandlers.remove(identifier);
  }

  void removeAllUserEventHandlers() {
    _userHandlers.clear();
  }

  void setSessionHandler(SessionHandler handler) {
    _sessionHandler = handler;
  }

  SessionHandler? getSessionHandler() {
    return _sessionHandler;
  }

  void removeSessionHandler() {
    _sessionHandler = null;
  }

  // BaseChannelHandler
  void notifyMessageReceived(BaseChannel channel, BaseMessage message) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[message] ${message.message}');

    for (final element in _channelHandlers.values) {
      element.onMessageReceived(channel, message);
    }
  }

  void notifyMessageUpdate(BaseChannel channel, BaseMessage message) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[message] ${message.message}');

    for (final element in _channelHandlers.values) {
      element.onMessageUpdated(channel, message);
    }
  }

  void notifyMessageDeleted(BaseChannel channel, int messageId) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[messageId] $messageId');

    for (final element in _channelHandlers.values) {
      element.onMessageDeleted(channel, messageId);
    }
  }

  void notifyMentionReceived(BaseChannel channel, BaseMessage message) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[message] ${message.message}');

    for (final element in _channelHandlers.values) {
      element.onMentionReceived(channel, message);
    }
  }

  void notifyChannelChanged(BaseChannel channel) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    for (final element in _channelHandlers.values) {
      element.onChannelChanged(channel);
    }
  }

  void notifyChannelDeleted(String channelUrl, ChannelType channelType) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] $channelUrl\n-[channelType] $channelType');

    for (final element in _channelHandlers.values) {
      element.onChannelDeleted(channelUrl, channelType);
    }
  }

  void notifyReactionUpdated(BaseChannel channel, ReactionEvent event) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    for (final element in _channelHandlers.values) {
      element.onReactionUpdated(channel, event);
    }
  }

  void notifyUserMuted(BaseChannel channel, RestrictedUser restrictedUser) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[userId] ${restrictedUser.userId}');

    for (final element in _channelHandlers.values) {
      element.onUserMuted(channel, restrictedUser);
    }
  }

  void notifyUserUnmuted(BaseChannel channel, User user) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[userId] ${user.userId}');

    for (final element in _channelHandlers.values) {
      element.onUserUnmuted(channel, user);
    }
  }

  void notifyUserBanned(BaseChannel channel, RestrictedUser restrictedUser) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[userId] ${restrictedUser.userId}');

    for (final element in _channelHandlers.values) {
      element.onUserBanned(channel, restrictedUser);
    }
  }

  void notifyUserUnbanned(BaseChannel channel, User user) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[userId] ${user.userId}');

    for (final element in _channelHandlers.values) {
      element.onUserUnbanned(channel, user);
    }
  }

  void notifyChannelFrozen(BaseChannel channel) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    for (final element in _channelHandlers.values) {
      element.onChannelFrozen(channel);
    }
  }

  void notifyChannelUnfrozen(BaseChannel channel) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    for (final element in _channelHandlers.values) {
      element.onChannelUnfrozen(channel);
    }
  }

  void notifyMetaDataChanged(BaseChannel channel, Map<String, dynamic> data) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[metaData] $data');

    for (final element in _channelHandlers.values) {
      final created = Map<String, String>.from(data['created'] ?? {});
      final updated = Map<String, String>.from(data['updated'] ?? {});
      final deleted = List<String>.from(data['deleted'] ?? []);

      if (created.isNotEmpty) element.onMetaDataCreated(channel, created);
      if (updated.isNotEmpty) element.onMetaDataUpdated(channel, updated);
      if (deleted.isNotEmpty) element.onMetaDataDeleted(channel, deleted);
    }
  }

  void notifyMetaCountersChanged(
      BaseChannel channel, Map<String, dynamic> data) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[metaData] $data');

    for (final element in _channelHandlers.values) {
      final created = Map<String, int>.from(data['created'] ?? {});
      final updated = Map<String, int>.from(data['updated'] ?? {});
      final deleted = List<String>.from(data['deleted'] ?? []);

      if (created.isNotEmpty) element.onMetaCountersCreated(channel, created);
      if (updated.isNotEmpty) element.onMetaCountersUpdated(channel, updated);
      if (deleted.isNotEmpty) element.onMetaCountersDeleted(channel, deleted);
    }
  }

  void notifyOperatorUpdated(BaseChannel channel) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    for (final element in _channelHandlers.values) {
      element.onOperatorUpdated(channel);
    }
  }

  void notifyThreadInfoUpdated(
      GroupChannel channel, ThreadInfoUpdateEvent event) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    for (final element in _channelHandlers.values) {
      element.onThreadInfoUpdated(channel, event);
    }
  }

  // GroupChannelHandler
  void notifyReadStatusUpdated(GroupChannel channel) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    for (final element in _channelHandlers.values) {
      if (element is GroupChannelHandler) {
        element.onReadStatusUpdated(channel);
      }
    }
  }

  void notifyDeliveryStatusUpdated(GroupChannel channel) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    for (final element in _channelHandlers.values) {
      if (element is GroupChannelHandler) {
        element.onDeliveryStatusUpdated(channel);
      }
    }
  }

  void notifyChannelTypingStatusUpdated(GroupChannel channel) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    for (final element in _channelHandlers.values) {
      if (element is GroupChannelHandler) {
        element.onTypingStatusUpdated(channel);
      }
    }
  }

  void notifyUserReceivedInvitation(
      GroupChannel channel, List<User> invitees, User? inviter) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[invitees] ${invitees.map((e) => e.userId)}, \n-[inviter] ${inviter?.userId}');

    for (final element in _channelHandlers.values) {
      if (element is GroupChannelHandler) {
        element.onUserReceivedInvitation(channel, invitees, inviter);
      }
    }
  }

  void notifyUserDeclinedInvitation(
    GroupChannel channel,
    User invitee,
    User? inviter,
  ) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[invitee] ${invitee.userId}, \n-[inviter] ${inviter?.userId}');

    for (final element in _channelHandlers.values) {
      if (element is GroupChannelHandler) {
        element.onUserDeclinedInvitation(channel, invitee, inviter);
      }
    }
  }

  void notifyUserJoined(GroupChannel channel, User user) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[userId] ${user.userId}');

    for (final element in _channelHandlers.values) {
      if (element is GroupChannelHandler) {
        element.onUserJoined(channel, user);
      }
    }
  }

  void notifyUserLeft(GroupChannel channel, User user) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[userId] ${user.userId}');

    for (final element in _channelHandlers.values) {
      if (element is GroupChannelHandler) {
        element.onUserLeft(channel, user);
      }
    }
  }

  void notifyChannelHidden(GroupChannel channel) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    for (final element in _channelHandlers.values) {
      if (element is GroupChannelHandler) {
        element.onChannelHidden(channel);
      }
    }
  }

  void notifyChannelMemberCountChanged(List<GroupChannel> channels) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrls] ${channels.map((e) => e.channelUrl)}');

    for (final element in _channelHandlers.values) {
      if (element is GroupChannelHandler) {
        element.onChannelMemberCountChanged(channels);
      }
    }
  }

  void notifyPollVoted(GroupChannel channel, PollVoteEvent event) {
    sbLog.i(StackTrace.current, '\n-[pollId] ${event.pollId}');

    for (final element in _channelHandlers.values) {
      if (element is GroupChannelHandler) {
        element.onPollVoted(channel, event);
      }
    }
  }

  void notifyPollUpdated(GroupChannel channel, PollUpdateEvent event) {
    sbLog.i(StackTrace.current, '\n-[pollId] ${event.pollId}');

    for (final element in _channelHandlers.values) {
      if (element is GroupChannelHandler) {
        element.onPollUpdated(channel, event);
      }
    }
  }

  void notifyPollDeleted(GroupChannel channel, int pollId) {
    sbLog.i(StackTrace.current, '\n-[pollId] $pollId');

    for (final element in _channelHandlers.values) {
      if (element is GroupChannelHandler) {
        element.onPollDeleted(channel, pollId);
      }
    }
  }

  void notifyPinnedMessageUpdated(GroupChannel channel) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    for (final element in _channelHandlers.values) {
      if (element is GroupChannelHandler) {
        element.onPinnedMessageUpdated(channel);
      }
    }
  }

  // OpenChannelHandler
  void notifyUserEntered(OpenChannel channel, User user) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[userId] ${user.userId}');

    for (final element in _channelHandlers.values) {
      if (element is OpenChannelHandler) {
        element.onUserEntered(channel, user);
      }
    }
  }

  void notifyUserExited(OpenChannel channel, User user) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[userId] ${user.userId}');

    for (final element in _channelHandlers.values) {
      if (element is OpenChannelHandler) {
        element.onUserExited(channel, user);
      }
    }
  }

  void notifyChannelParticipantCountChanged(List<OpenChannel> channels) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrls] ${channels.map((e) => e.channelUrl)}');

    for (final element in _channelHandlers.values) {
      if (element is OpenChannelHandler) {
        element.onChannelParticipantCountChanged(channels);
      }
    }
  }

  // ConnectionHandler
  void notifyConnected(String userId) {
    sbLog.i(StackTrace.current, 'userId: $userId');

    for (final element in _connectionHandlers.values) {
      element.onConnected(userId);
    }
  }

  void notifyDisconnected(String userId) {
    sbLog.i(StackTrace.current, 'userId: $userId');

    for (final element in _connectionHandlers.values) {
      element.onDisconnected(userId);
    }
  }

  void notifyReconnectStarted() {
    sbLog.i(StackTrace.current);

    for (final element in _connectionHandlers.values) {
      element.onReconnectStarted();
    }
  }

  void notifyReconnectSucceeded() {
    sbLog.i(StackTrace.current);

    for (final element in _connectionHandlers.values) {
      element.onReconnectSucceeded();
    }
  }

  void notifyReconnectFailed() {
    sbLog.i(StackTrace.current);

    for (final element in _connectionHandlers.values) {
      element.onReconnectFailed();
    }
  }

  // UserEventHandler
  void notifyTotalUnreadMessageCountUpdated(
      int totalCount, Map<String, int> customTypesCount) {
    sbLog.i(StackTrace.current,
        '\n-[totalCount] $totalCount\n-[customTypesCount] $customTypesCount');

    for (final element in _userHandlers.values) {
      element.onTotalUnreadMessageCountUpdated(totalCount, customTypesCount);
    }
  }

  void notifyFriendsDiscovered(List<User> friends) {
    sbLog.i(StackTrace.current, '\n-[friends] ${friends.map((e) => e.userId)}');

    for (final element in _userHandlers.values) {
      element.onFriendsDiscovered(friends);
    }
  }

  // SessionHandler
  void notifyAccessTokenRequired() {
    sbLog.i(StackTrace.current);
    _sessionHandler?.onAccessTokenRequired(_accessTokenRequester);
  }

  void notifySessionClosed() {
    sbLog.i(StackTrace.current);
    _sessionHandler?.onSessionClosed();
  }

  void notifySessionRefreshed() {
    sbLog.i(StackTrace.current);
    _sessionHandler?.onSessionRefreshed();
  }

  void notifySessionError(SendbirdException error) {
    sbLog.i(StackTrace.current, '\n-[error] $error');
    _sessionHandler?.onSessionError(error);
  }
}
