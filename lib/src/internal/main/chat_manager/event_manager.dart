// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/session_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/feed_channel/feed_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/open_channel/open_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/notification_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/restricted_user.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/handler/channel_handler.dart';
import 'package:sendbird_chat_sdk/src/public/main/handler/connection_handler.dart';
import 'package:sendbird_chat_sdk/src/public/main/handler/session_handler.dart';
import 'package:sendbird_chat_sdk/src/public/main/handler/user_event_handler.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/unread_message_count.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/poll/poll_update_event.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/poll/poll_vote_event.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/reaction/reaction_event.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/thread/thread_info_updated_event.dart';

class EventManager {
  final Map<String, RootChannelHandler> _channelHandlers = {};
  final Map<String, ConnectionHandler> _connectionHandlers = {};
  final Map<String, UserEventHandler> _userHandlers = {};

  final Set<String> _internalChannelHandlerIdentifiers = {};

  SessionHandler? _sessionHandler;
  final AccessTokenRequester _accessTokenRequester;

  EventManager({required SessionManager sessionManager})
      : _accessTokenRequester = sessionManager.accessTokenRequester;

  void addChannelHandler(String identifier, RootChannelHandler handler) {
    if (handler is BaseChannelHandler) {
      _channelHandlers[identifier] = handler;
    } else if (handler is FeedChannelHandler) {
      _channelHandlers[identifier] = handler;
    }
  }

  void addInternalChannelHandler(
      String identifier, RootChannelHandler handler) {
    _internalChannelHandlerIdentifiers.add(identifier);
    if (handler is BaseChannelHandler) {
      addChannelHandler(identifier, handler);
    } else if (handler is FeedChannelHandler) {
      addChannelHandler(identifier, handler);
    }
  }

  BaseChannelHandler? getChannelHandler(String identifier) {
    if (_internalChannelHandlerIdentifiers.contains(identifier)) {
      return null;
    }
    return _channelHandlers[identifier] as BaseChannelHandler?;
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
  void notifyMessageReceived(BaseChannel channel, RootMessage message) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[message] ${(message is BaseMessage) ? message.message : ''}');

    for (final e in _channelHandlers.values) {
      if (e is BaseChannelHandler && message is BaseMessage) {
        e.onMessageReceived(channel, message);
      } else if (e is FeedChannelHandler &&
          channel is FeedChannel &&
          message is NotificationMessage) {
        e.onMessageReceived(channel, message);
      }
    }
  }

  void notifyMessageUpdate(BaseChannel channel, RootMessage message) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[message] ${(message is BaseMessage) ? message.message : ''}');

    for (final e in _channelHandlers.values) {
      if (e is BaseChannelHandler && message is BaseMessage) {
        e.onMessageUpdated(channel, message);
      }
    }
  }

  void notifyMessageDeleted(BaseChannel channel, int messageId) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[messageId] $messageId');

    for (final e in _channelHandlers.values) {
      if (e is BaseChannelHandler) {
        e.onMessageDeleted(channel, messageId);
      }
    }
  }

  void notifyMentionReceived(BaseChannel channel, RootMessage message) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[message] ${(message is BaseMessage) ? message.message : ''}');

    for (final e in _channelHandlers.values) {
      if (e is BaseChannelHandler && message is BaseMessage) {
        e.onMentionReceived(channel, message);
      }
    }
  }

  void notifyChannelChanged(BaseChannel channel) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    for (final e in _channelHandlers.values) {
      if (e is BaseChannelHandler) {
        e.onChannelChanged(channel);
      } else if (e is FeedChannelHandler && channel is FeedChannel) {
        e.onChannelChanged(channel);
      }
    }
  }

  void notifyChannelDeleted(String channelUrl, ChannelType channelType) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] $channelUrl\n-[channelType] $channelType');

    for (final e in _channelHandlers.values) {
      if (e is BaseChannelHandler) {
        e.onChannelDeleted(channelUrl, channelType);
      }
    }
  }

  void notifyReactionUpdated(BaseChannel channel, ReactionEvent event) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    if (channel is FeedChannel) return;

    for (final e in _channelHandlers.values) {
      if (e is BaseChannelHandler) {
        e.onReactionUpdated(channel, event);
      }
    }
  }

  void notifyUserMuted(BaseChannel channel, RestrictedUser restrictedUser) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[userId] ${restrictedUser.userId}');

    if (channel is FeedChannel) return;

    for (final e in _channelHandlers.values) {
      if (e is BaseChannelHandler) {
        e.onUserMuted(channel, restrictedUser);
      }
    }
  }

  void notifyUserUnmuted(BaseChannel channel, User user) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[userId] ${user.userId}');

    if (channel is FeedChannel) return;

    for (final e in _channelHandlers.values) {
      if (e is BaseChannelHandler) {
        e.onUserUnmuted(channel, user);
      }
    }
  }

  void notifyUserBanned(BaseChannel channel, RestrictedUser restrictedUser) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[userId] ${restrictedUser.userId}');

    if (channel is FeedChannel) return;

    for (final e in _channelHandlers.values) {
      if (e is BaseChannelHandler) {
        e.onUserBanned(channel, restrictedUser);
      }
    }
  }

  void notifyUserUnbanned(BaseChannel channel, User user) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[userId] ${user.userId}');

    if (channel is FeedChannel) return;

    for (final e in _channelHandlers.values) {
      if (e is BaseChannelHandler) {
        e.onUserUnbanned(channel, user);
      }
    }
  }

  void notifyChannelFrozen(BaseChannel channel) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    if (channel is FeedChannel) return;

    for (final e in _channelHandlers.values) {
      if (e is BaseChannelHandler) {
        e.onChannelFrozen(channel);
      }
    }
  }

  void notifyChannelUnfrozen(BaseChannel channel) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    if (channel is FeedChannel) return;

    for (final e in _channelHandlers.values) {
      if (e is BaseChannelHandler) {
        e.onChannelUnfrozen(channel);
      }
    }
  }

  void notifyMetaDataChanged(BaseChannel channel, Map<String, dynamic> data) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[metaData] $data');

    if (channel is FeedChannel) return;

    for (final e in _channelHandlers.values) {
      final created = Map<String, String>.from(data['created'] ?? {});
      final updated = Map<String, String>.from(data['updated'] ?? {});
      final deleted = List<String>.from(data['deleted'] ?? []);

      if (e is BaseChannelHandler) {
        if (created.isNotEmpty) e.onMetaDataCreated(channel, created);
        if (updated.isNotEmpty) e.onMetaDataUpdated(channel, updated);
        if (deleted.isNotEmpty) e.onMetaDataDeleted(channel, deleted);
      }
    }
  }

  void notifyMetaCountersChanged(
      BaseChannel channel, Map<String, dynamic> data) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[metaData] $data');

    if (channel is FeedChannel) return;

    for (final e in _channelHandlers.values) {
      final created = Map<String, int>.from(data['created'] ?? {});
      final updated = Map<String, int>.from(data['updated'] ?? {});
      final deleted = List<String>.from(data['deleted'] ?? []);

      if (e is BaseChannelHandler) {
        if (created.isNotEmpty) e.onMetaCountersCreated(channel, created);
        if (updated.isNotEmpty) e.onMetaCountersUpdated(channel, updated);
        if (deleted.isNotEmpty) e.onMetaCountersDeleted(channel, deleted);
      }
    }
  }

  void notifyOperatorUpdated(BaseChannel channel) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    if (channel is FeedChannel) return;

    for (final e in _channelHandlers.values) {
      if (e is BaseChannelHandler) {
        e.onOperatorUpdated(channel);
      }
    }
  }

  void notifyThreadInfoUpdated(
      GroupChannel channel, ThreadInfoUpdateEvent event) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    if (channel is FeedChannel) return;

    for (final e in _channelHandlers.values) {
      if (e is BaseChannelHandler) {
        e.onThreadInfoUpdated(channel, event);
      }
    }
  }

  // GroupChannelHandler
  void notifyReadStatusUpdated(BaseChannel channel) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    for (final e in _channelHandlers.values) {
      if (e is GroupChannelHandler && channel is GroupChannel) {
        e.onReadStatusUpdated(channel);
      }
      // else if (e is FeedChannelHandler && channel is FeedChannel) {
      //   e.onReadStatusUpdated(channel);
      // }
    }
  }

  void notifyDeliveryStatusUpdated(GroupChannel channel) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    for (final e in _channelHandlers.values) {
      if (e is GroupChannelHandler) {
        e.onDeliveryStatusUpdated(channel);
      }
    }
  }

  void notifyChannelTypingStatusUpdated(GroupChannel channel) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    for (final e in _channelHandlers.values) {
      if (e is GroupChannelHandler) {
        e.onTypingStatusUpdated(channel);
      }
    }
  }

  void notifyUserReceivedInvitation(
      GroupChannel channel, List<User> invitees, User? inviter) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[invitees] ${invitees.map((e) => e.userId)}, \n-[inviter] ${inviter?.userId}');

    for (final e in _channelHandlers.values) {
      if (e is GroupChannelHandler) {
        e.onUserReceivedInvitation(channel, invitees, inviter);
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

    for (final e in _channelHandlers.values) {
      if (e is GroupChannelHandler) {
        e.onUserDeclinedInvitation(channel, invitee, inviter);
      }
    }
  }

  void notifyUserJoined(GroupChannel channel, User user) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[userId] ${user.userId}');

    for (final e in _channelHandlers.values) {
      if (e is GroupChannelHandler) {
        e.onUserJoined(channel, user);
      }
    }
  }

  void notifyUserLeft(GroupChannel channel, User user) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[userId] ${user.userId}');

    for (final e in _channelHandlers.values) {
      if (e is GroupChannelHandler) {
        e.onUserLeft(channel, user);
      }
    }
  }

  void notifyChannelHidden(GroupChannel channel) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    for (final e in _channelHandlers.values) {
      if (e is GroupChannelHandler) {
        e.onChannelHidden(channel);
      }
    }
  }

  void notifyChannelMemberCountChanged(List<GroupChannel> channels) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrls] ${channels.map((e) => e.channelUrl)}');

    for (final e in _channelHandlers.values) {
      if (e is GroupChannelHandler) {
        e.onChannelMemberCountChanged(channels);
      }
    }
  }

  void notifyPollVoted(GroupChannel channel, PollVoteEvent event) {
    sbLog.i(StackTrace.current, '\n-[pollId] ${event.pollId}');

    for (final e in _channelHandlers.values) {
      if (e is GroupChannelHandler) {
        e.onPollVoted(channel, event);
      }
    }
  }

  void notifyPollUpdated(GroupChannel channel, PollUpdateEvent event) {
    sbLog.i(StackTrace.current, '\n-[pollId] ${event.pollId}');

    for (final e in _channelHandlers.values) {
      if (e is GroupChannelHandler) {
        e.onPollUpdated(channel, event);
      }
    }
  }

  void notifyPollDeleted(GroupChannel channel, int pollId) {
    sbLog.i(StackTrace.current, '\n-[pollId] $pollId');

    for (final e in _channelHandlers.values) {
      if (e is GroupChannelHandler) {
        e.onPollDeleted(channel, pollId);
      }
    }
  }

  void notifyPinnedMessageUpdated(GroupChannel channel) {
    sbLog.i(StackTrace.current, '\n-[channelUrl] ${channel.channelUrl}');

    for (final e in _channelHandlers.values) {
      if (e is GroupChannelHandler) {
        e.onPinnedMessageUpdated(channel);
      }
    }
  }

  // OpenChannelHandler
  void notifyUserEntered(OpenChannel channel, User user) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[userId] ${user.userId}');

    for (final e in _channelHandlers.values) {
      if (e is OpenChannelHandler) {
        e.onUserEntered(channel, user);
      }
    }
  }

  void notifyUserExited(OpenChannel channel, User user) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrl] ${channel.channelUrl}\n-[userId] ${user.userId}');

    for (final e in _channelHandlers.values) {
      if (e is OpenChannelHandler) {
        e.onUserExited(channel, user);
      }
    }
  }

  void notifyChannelParticipantCountChanged(List<OpenChannel> channels) {
    sbLog.i(StackTrace.current,
        '\n-[channelUrls] ${channels.map((e) => e.channelUrl)}');

    for (final e in _channelHandlers.values) {
      if (e is OpenChannelHandler) {
        e.onChannelParticipantCountChanged(channels);
      }
    }
  }

  // ConnectionHandler
  void notifyConnected(String userId) {
    sbLog.i(StackTrace.current, 'userId: $userId');

    for (final e in _connectionHandlers.values) {
      e.onConnected(userId);
    }
  }

  void notifyDisconnected(String userId) {
    sbLog.i(StackTrace.current, 'userId: $userId');

    for (final e in _connectionHandlers.values) {
      e.onDisconnected(userId);
    }
  }

  void notifyReconnectStarted() {
    sbLog.i(StackTrace.current);

    for (final e in _connectionHandlers.values) {
      e.onReconnectStarted();
    }
  }

  void notifyReconnectSucceeded() {
    sbLog.i(StackTrace.current);

    for (final e in _connectionHandlers.values) {
      e.onReconnectSucceeded();
    }
  }

  void notifyReconnectFailed() {
    sbLog.i(StackTrace.current);

    for (final e in _connectionHandlers.values) {
      e.onReconnectFailed();
    }
  }

  // UserEventHandler
  void notifyTotalUnreadMessageCountChanged(
      UnreadMessageCount unreadMessageCount) {
    sbLog.i(StackTrace.current,
        '\n-[groupChannelUnreadMessageCount] ${unreadMessageCount.totalCountForGroupChannels}\n-[feedChannelUnreadMessageCount] ${unreadMessageCount.totalCountForFeedChannels}\n-[totalCountByCustomType] ${unreadMessageCount.totalCountByCustomType}');

    for (final e in _userHandlers.values) {
      e.onTotalUnreadMessageCountChanged(unreadMessageCount);
    }
  }

  void notifyFriendsDiscovered(List<User> friends) {
    sbLog.i(StackTrace.current, '\n-[friends] ${friends.map((e) => e.userId)}');

    for (final e in _userHandlers.values) {
      e.onFriendsDiscovered(friends);
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
