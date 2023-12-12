// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/channel/meta_data_cache.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_context/chat_context.dart';
import 'package:sendbird_chat_sdk/src/internal/main/connection_state/connected_state.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/delivery_status.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/read_status.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/reconnect_task.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/typing_status.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/unread_message_count_info.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/json_converter.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/command/command.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/event/channel_event.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/event/login_event.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/event/mcnt_event.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/event/message_event.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/event/session_event.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/event/user_event.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/feed_channel/feed_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/open_channel/open_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/notification_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/member.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/restricted_user.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/sendbird_error.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/unread_message_count.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/poll/poll_update_event.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/poll/poll_vote_event.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/reaction/reaction_event.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/thread/thread_info_updated_event.dart';

class CommandManager {
  final Map<String, Completer<Command?>> _completerMap = {};
  final Map<String, Timer> _ackTimerMap = {};

  final Chat _chat;

  CommandManager({required Chat chat}) : _chat = chat;

  static Command? parseCommandString(String commandString) {
    Command? command;
    try {
      final payloadData = commandString.substring(4);
      final payload = jsonDecode(payloadData);
      payload['cmd'] = commandString.substring(0, 4);
      command = Command.fromJson(payload);
      command.payload = payload;
    } catch (e) {
      sbLog.e(StackTrace.current, 'e: $e');
      command = null;
    }
    return command;
  }

  Future<void> updateSessionKey() async {
    try {
      final hasCallback = _chat.eventManager.getSessionHandler() != null;
      await _chat.commandManager.sendCommand(Command.buildLOGIUpdateSessionKey(
          hasCallback, _chat.chatContext.accessToken));
    } catch (e) {
      sbLog.e(StackTrace.current, 'e: $e');
      throw WebSocketFailedException(message: e.toString());
    }
  }

  void cleanUp() {
    _ackTimerMap.removeWhere((key, value) => true);
  }

  void clearCompleterMap({SendbirdException? e}) {
    _completerMap.forEach((key, value) {
      if (e != null) {
        value.completeError(e);
      } else {
        value.complete();
      }
    });
    _completerMap.removeWhere((key, value) => true);
  }

  Future<Command?> sendCommand(Command cmd) async {
    if (_chat.chatContext.currentUser == null) {
      // NOTE: some test cases execute async socket data
      throw ConnectionRequiredException();
    }

    sbLog.d(
        StackTrace.current, '\n-[cmd] ${cmd.cmd}\n-[payload] ${cmd.payload}');

    try {
      _chat.connectionManager.webSocketClient.send(cmd.encode());
    } catch (e) {
      sbLog.e(StackTrace.current, 'e: $e');
      _ackTimerMap.remove(cmd.requestId)?.cancel();
      rethrow;
    }

    final reqId = cmd.requestId;
    if (cmd.isAckRequired && reqId != null) {
      final timer = Timer(
          Duration(seconds: _chat.chatContext.options.webSocketTimeout), () {
        throw AckTimeoutException();
      });
      _ackTimerMap[reqId] = timer;

      final completer = Completer<Command>();
      _completerMap[reqId] = completer;
      return completer.future;
    } else {
      return null;
    }
  }

  Future<void> processCommand(Command cmd) async {
    if (cmd.payload['cmd'] == null || cmd.payload['cmd'] != 'PONG') {
      sbLog.d(StackTrace.current,
          '\n-[cmd] ${cmd.cmd}\n-[payload] ${jsonEncoder.convert(cmd.payload)}');
    }

    processUnreadMessageCountPayload(cmd.payload['unread_cnt']);

    if (cmd.requestId != null) {
      _ackTimerMap.remove(cmd.requestId)?.cancel();
      final completer = _completerMap.remove(cmd.requestId);

      if (cmd.isError || cmd.hasError) {
        if (cmd.errorCode == SendbirdError.accessTokenNotValid) {
          _chat.eventManager.notifyAccessTokenRequired();
        }
        completer?.completeError(SendbirdException(
          code: cmd.errorCode,
          message: cmd.errorMessage,
        ));
        return;
      } else {
        completer?.complete(cmd);
      }
    }

    if (cmd.isError || cmd.hasError) {
      await _processError(cmd);
    } else if (cmd.isLogin && cmd.requestId != null) {
      await _processSessionRefresh(cmd);
    } else if (cmd.isLogin) {
      await _processLogin(cmd);
    } else if (cmd.isSessionExpired) {
      await _processSessionExpired(cmd);
    } else if (cmd.isNewMessage) {
      await _processNewMessage(cmd);
    } else if (cmd.isUpdatedMessage) {
      await _processUpdateMessage(cmd);
    } else if (cmd.isMessageDeleted) {
      await _processDeleteMessage(cmd);
    } else if (cmd.isMemberCountChanged) {
      await _processMemberCountChange(cmd);
    } else if (cmd.isRead) {
      await _processRead(cmd);
    } else if (cmd.isDelivery) {
      await _processDelivery(cmd);
    } else if (cmd.isThread) {
      await _processThread(cmd);
    } else if (cmd.isReaction) {
      await _processReaction(cmd);
    } else if (cmd.isUserEvent) {
      await _processUserEvent(cmd);
    } else if (cmd.isSystemEvent) {
      await _processSystemEvent(cmd);
    } else if (cmd.isPollVoted) {
      await _processPollVoted(cmd);
    } else if (cmd.isPollUpdated) {
      await _processPollUpdated(cmd);
    } else {
      if (cmd.cmd != 'PONG') {
        sbLog.i(StackTrace.current, 'Pass command: ${cmd.cmd}');
      }
    }
  }

  GroupChannel? _eitherGroupOrFeed(BaseChannel channel) {
    if (channel is GroupChannel) {
      return channel;
    } else if (channel is FeedChannel) {
      return channel.groupChannel;
    }
    return null;
  }

  bool _isGroupChannel(Command cmd) {
    return (cmd.payload['channel_type'] == 'group');
  }

  bool _isFeedChannel(Command cmd) {
    return (cmd.payload['channel_type'] == 'feed');
  }

  void processUnreadMessageCountPayload(
    Map<String, dynamic>? unreadMessageCountPayload,
  ) {
    if (unreadMessageCountPayload == null) return;
    final info = UnreadMessageCountInfo.fromJson(unreadMessageCountPayload);
    if (_chat.chatContext.unreadMessageCountInfo.ts > info.ts) return;

    final unreadMessageCountInfo = _chat.chatContext.unreadMessageCountInfo;
    final didChange = unreadMessageCountInfo.copyWith(info);
    if (didChange) {
      final unreadMessageCount = UnreadMessageCount(
        totalCountForGroupChannels: unreadMessageCountInfo.all,
        totalCountForFeedChannels: unreadMessageCountInfo.feed,
        totalCountByCustomType: unreadMessageCountInfo.customTypes,
      );

      _chat.eventManager.notifyTotalUnreadMessageCountChanged(
        unreadMessageCount,
      );
    }
  }

  Future<void> _processLogin(Command cmd) async {
    if (_chat.connectionManager.isConnecting() &&
        _chat.chatContext.loginCompleter == null) {
      sbLog.d(StackTrace.current, '(isConnecting() && loginCompleter == null)');
      return;
    }

    await processLoginPayload(fromWebSocket: true, loginPayload: cmd.payload);
  }

  Future<void> processLoginPayload({
    required bool fromWebSocket,
    required Map<String, dynamic> loginPayload,
  }) async {
    final event = LoginEvent.fromJson(loginPayload);
    event.user.set(_chat);

    final services = loginPayload['services'] as List<dynamic>?;
    _chat.chatContext.services.clear();
    if (services != null) {
      for (final service in services) {
        if (service == 'chat') {
          _chat.chatContext.services.add(Service.chat);
        } else if (service == 'feed') {
          _chat.chatContext.services.add(Service.feed);
        }
      }
    }

    _chat.chatContext
      ..currentUser = event.user
      ..currentUserId = event.user.userId
      ..sessionKey = event.sessionKey
      ..eKey = event.eKey
      ..appInfo = event.appInfo
      ..uploadSizeLimit = event.appInfo.uploadSizeLimit * 1024 * 1024
      ..maxUnreadCountOnSuperGroup = event.maxUnreadCountOnSuperGroup
      ..lastConnectedAt = event.loginTimestamp
      ..reconnectConfig = event.reconnectConfiguration;

    _chat.sessionManager.setSessionKey(event.sessionKey);

    if (fromWebSocket) {
      _chat.chatContext.reconnectTask =
          ReconnectTask(event.reconnectConfiguration);
      _chat.chatContext.setPingInterval(event.pingInterval);
      _chat.chatContext.setWatchdogInterval(event.watchdogInterval);

      final wasReconnecting = _chat.connectionManager.isReconnecting();
      if (wasReconnecting) {
        await _chat.eventDispatcher.onReconnected(event);
      } else {
        await _chat.eventDispatcher.onLogin(event);
      }

      _chat.chatContext.loginCompleter?.complete(event.user);
      _chat.chatContext.loginCompleter = null;

      _chat.connectionManager.changeState(ConnectedState(chat: _chat));
      await _enterEnteredOpenChannels();

      if (wasReconnecting) {
        _chat.eventManager.notifyReconnectSucceeded();
      } else {
        _chat.eventManager.notifyConnected(event.user.userId);
      }
    } else {
      await _chat.eventDispatcher.onLogin(event);
    }
  }

  Future<void> _enterEnteredOpenChannels() async {
    final enteredOpenChannelUrlCopied = {
      ..._chat.chatContext.enteredOpenChannelUrls
    };

    for (final openChannelUrl in enteredOpenChannelUrlCopied) {
      final openChannel =
          _chat.channelCache.find<OpenChannel>(channelKey: openChannelUrl);
      if (openChannel != null) {
        await openChannel.enter().then((value) {
          sbLog.i(
            StackTrace.current,
            'openChannel enter() => OK (name: ${openChannel.name})',
          );
        }).catchError((e) {
          sbLog.e(
            StackTrace.current,
            'openChannel enter() => Failed (e: $e, name: ${openChannel.name})',
          );

          _chat.channelCache.delete(channelKey: openChannelUrl);
          _chat.chatContext.enteredOpenChannelUrls.remove(openChannelUrl);
          sbLog.i(
            StackTrace.current,
            '[remove()] enteredOpenChannels: ${_chat.chatContext.enteredOpenChannelUrls.length}',
          );
        });
      }
    }
  }

  Future<void> _processSessionExpired(Command cmd) async {
    _chat.sessionManager.setSessionKey(null);

    if (cmd.payload['reason'] == SendbirdError.accessTokenRevoked) {
      await _chat.connectionManager.disconnect(logout: true);
      _chat.eventManager.notifySessionClosed();
    } else if (cmd.payload['expires_in'] != null
        ? cmd.payload['expires_in'] < 0
        : false) {
      // If session token is expired, then log out
      await _chat.connectionManager.disconnect(logout: true);
    } else {
      await _chat.sessionManager.updateSessionKey();
    }
  }

  Future<void> _processNewMessage(Command cmd) async {
    final event = MessageEvent.fromJson(cmd.payload);
    event.sender?.set(_chat);
    event.mentionedUsers?.forEach((element) {
      element.set(_chat);
    });

    try {
      final message = RootMessage.getMessageFromJsonWithChat(
        _chat,
        cmd.payload,
        commandType: cmd.cmd,
      );

      if (event.requestId != null) {
        // If sent by api then added id to cache -> done
        if (message.channelType == ChannelType.group) {
          dynamic messageId = message.getMessageId();
          if (messageId is int) {
            sendCommand(Command.buildMessageMACK(
              message.channelUrl,
              messageId,
            ));
          }
        }
      }

      bool shouldCallChannelChanged = false;

      if (message.channelType == ChannelType.group) {
        final cachedChannel = _chat.channelCache
            .find<GroupChannel>(channelKey: message.channelUrl);
        if (cachedChannel == null || cachedChannel.dirty) {
          shouldCallChannelChanged = true;
        }
      }

      final channel = await BaseChannel.getBaseChannel(
        message.channelType,
        message.channelUrl,
        chat: _chat,
      );

      final GroupChannel? groupChannel = _eitherGroupOrFeed(channel);
      if (groupChannel != null) {
        if (groupChannel.hiddenState ==
            GroupChannelHiddenState.allowAutoUnhide) {
          groupChannel.isHidden = false;
          groupChannel.hiddenState = GroupChannelHiddenState.unhidden;
        }

        groupChannel.updateMember(event.sender);

        if (channel is GroupChannel && message is BaseMessage) {
          if (groupChannel.shouldUpdateLastMessage(message, message.sender)) {
            shouldCallChannelChanged = true;
            groupChannel.lastMessage = message;
          }
        } else if (channel is FeedChannel && message is NotificationMessage) {
          if (channel.shouldUpdateLastMessage(message)) {
            shouldCallChannelChanged = true;
            channel.lastMessage = message;
          }
        }

        if (groupChannel.fromCache && groupChannel.updateUnreadCount(message)) {
          shouldCallChannelChanged = true;
        }
      }

      if (event.requestId == null) {
        _chat.eventManager.notifyMessageReceived(channel, message);
      }

      if (channel is GroupChannel && message is BaseMessage) {
        final currentUser = _chat.chatContext.currentUser;
        if (message.mentioned(user: currentUser, byOtherUser: message.sender)) {
          _chat.eventManager.notifyMentionReceived(channel, message);
        }
      }

      if (shouldCallChannelChanged) {
        _chat.eventManager.notifyChannelChanged(channel);
      }
    } catch (e) {
      sbLog.e(StackTrace.current, 'cmd: ${cmd.cmd}, e: $e');
    }
  }

  Future<void> _processUpdateMessage(Command cmd) async {
    final event = MessageEvent.fromJson(cmd.payload);
    event.sender?.set(_chat);
    event.mentionedUsers?.forEach((element) {
      element.set(_chat);
    });

    try {
      final message = RootMessage.getMessageFromJsonWithChat(
        _chat,
        cmd.payload,
        commandType: cmd.cmd,
      );

      final currentUser = _chat.chatContext.currentUser;
      if (currentUser == null) return;

      final channel = await BaseChannel.getBaseChannel(
        message.channelType,
        message.channelUrl,
        chat: _chat,
      );

      if (channel is OpenChannel) {
        _chat.eventManager.notifyMessageUpdate(channel, message);
      } else {
        final GroupChannel? groupChannel = _eitherGroupOrFeed(channel);
        if (groupChannel != null) {
          bool shouldCallChannelChanged = false;
          bool shouldCallMentionReceived = false;

          if (message is BaseMessage) {
            if (groupChannel.shouldUpdateLastMessage(message, message.sender)) {
              shouldCallChannelChanged = true;
              groupChannel.lastMessage = message;
            }

            final timestamp = groupChannel.myReadReceipt();

            if (message.hasUpdatedLaterThan(timestamp) &&
                event.sender?.isCurrentUser == false &&
                !message.isSilent) {
              if (event.hasChangedMentionType() == MentionType.channel &&
                  event.previousMentionedContains(currentUser)) {
                if (groupChannel.fromCache) {
                  groupChannel.increaseUnreadMentionCount();
                }
                shouldCallChannelChanged = true;
                shouldCallMentionReceived = true;
              } else if (event.hasChangedMentionType() == MentionType.users &&
                  !event.previousMentionedContains(currentUser) &&
                  event.mentionedContains(currentUser)) {
                if (groupChannel.fromCache) {
                  groupChannel.increaseUnreadMentionCount();
                }
                shouldCallChannelChanged = true;
                shouldCallMentionReceived = true;
              }
            }
          }

          _chat.eventManager.notifyMessageUpdate(channel, message);

          if (shouldCallMentionReceived) {
            _chat.eventManager.notifyMentionReceived(channel, message);
          }

          if (shouldCallChannelChanged) {
            _chat.eventManager.notifyChannelChanged(channel);
          }
        }
      }
    } catch (e) {
      sbLog.e(StackTrace.current, 'cmd: ${cmd.cmd}, e: $e');
    }
  }

  Future<void> _processDeleteMessage(Command cmd) async {
    final event = MessageEvent.fromJson(cmd.payload);
    event.sender?.set(_chat);
    event.mentionedUsers?.forEach((element) {
      element.set(_chat);
    });

    try {
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
        chat: _chat,
      );
      _chat.eventManager.notifyMessageDeleted(channel, event.messageId);
    } catch (e) {
      sbLog.e(StackTrace.current, 'cmd: ${cmd.cmd}, e: $e');
    }
  }

  // only for open channel and broadcast channel
  Future<void> _processMemberCountChange(Command cmd) async {
    final event = MCNTEvent.fromJsonWithChat(_chat, cmd.payload);

    final groupChannels = <GroupChannel>[];
    final openChannels = <OpenChannel>[];

    for (final groupChannel in event.groupChannels) {
      final channel = _chat.channelCache
          .find<GroupChannel>(channelKey: groupChannel.channelUrl);
      if (channel != null) {
        channel.joinedMemberCount = groupChannel.joinedMemberCount;
        channel.memberCount = groupChannel.memberCount;
        groupChannels.add(channel);
      }
    }

    for (final openChannel in event.openChannels) {
      final channel = _chat.channelCache
          .find<OpenChannel>(channelKey: openChannel.channelUrl);
      if (channel != null) {
        channel.participantCount = openChannel.participantCount;
        openChannels.add(channel);
      }
    }

    if (groupChannels.isNotEmpty) {
      _chat.eventManager.notifyChannelMemberCountChanged(groupChannels);
    }
    if (openChannels.isNotEmpty) {
      _chat.eventManager.notifyChannelParticipantCountChanged(openChannels);
    }
  }

  Future<void> _processRead(Command cmd) async {
    try {
      final status = ReadStatus.fromJson(cmd.payload);
      status.saveToCache(_chat);

      final channel = await BaseChannel.getBaseChannel(
        status.channelType,
        status.channelUrl,
        chat: _chat,
      );

      final GroupChannel? groupChannel = _eitherGroupOrFeed(channel);
      if (groupChannel != null) {
        final isCurrentUser = status.userId == _chat.chatContext.currentUserId;
        final hasUnreadCount = (groupChannel.unreadMessageCount > 0 ||
            groupChannel.unreadMentionCount > 0);
        if (isCurrentUser) {
          groupChannel.myLastRead = status.timestamp;
          if (groupChannel.fromCache) groupChannel.clearUnreadCount();
          if (hasUnreadCount) _chat.eventManager.notifyChannelChanged(channel);
        } else {
          _chat.eventManager.notifyReadStatusUpdated(channel);
        }
      }
    } catch (e) {
      sbLog.e(StackTrace.current, 'cmd: ${cmd.cmd}, e: $e');
    }
  }

  Future<void> _processDelivery(Command cmd) async {
    try {
      final status = DeliveryStatus.fromJson(cmd.payload);

      final GroupChannel groupChannel =
          await GroupChannel.getChannel(status.channelUrl);
      final currentUserId = _chat.chatContext.currentUserId;
      var shouldCallDelivery = true;
      if (status.updatedDeliveryStatus.length == 1 &&
          status.updatedDeliveryStatus[currentUserId] != null) {
        shouldCallDelivery = false;
      }

      status.saveToCache(_chat);

      if (shouldCallDelivery) {
        _chat.eventManager.notifyDeliveryStatusUpdated(groupChannel);
      }
    } catch (e) {
      sbLog.e(StackTrace.current, 'cmd: ${cmd.cmd}, e: $e');
    }
  }

  Future<void> _processThread(Command cmd) async {
    try {
      final event = ThreadInfoUpdateEvent.fromJson(cmd.payload);
      for (var element in event.threadInfo.mostRepliesUsers) {
        element.set(_chat);
      }

      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
        chat: _chat,
      );

      final GroupChannel? groupChannel = _eitherGroupOrFeed(channel);
      if (groupChannel != null) {
        _chat.eventManager.notifyThreadInfoUpdated(groupChannel, event);
      }
    } catch (e) {
      sbLog.e(StackTrace.current, 'cmd: ${cmd.cmd}, e: $e');
    }
  }

  Future<void> _processReaction(Command cmd) async {
    try {
      final event = ReactionEvent.fromJson(cmd.payload);

      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
        chat: _chat,
      );

      _chat.eventManager.notifyReactionUpdated(channel, event);
    } catch (e) {
      sbLog.e(StackTrace.current, 'cmd: ${cmd.cmd}, e: $e');
    }
  }

  Future<void> _processSessionRefresh(Command cmd) async {
    sbLog.d(StackTrace.current);

    final event = SessionEvent.fromJson(cmd.payload);

    await _chat.sessionManager.setSessionKey(event.sessionKey);
    _chat.eventManager.notifySessionRefreshed();
  }

  Future<void> _processError(Command cmd) async {
    sbLog.e(StackTrace.current,
        'cmd: ${cmd.cmd}, errorMessage: ${cmd.errorMessage ?? ''}');

    if (cmd.errorCode == SendbirdError.sessionKeyExpired) {
      await _chat.connectionManager.disconnect(logout: true);
      await _chat.sessionManager.updateSessionKey();
    } else if (cmd.errorCode == SendbirdError.accessTokenRevoked) {
      if (_chat.chatContext.loginCompleter != null &&
          !_chat.chatContext.loginCompleter!.isCompleted) {
        _chat.chatContext.loginCompleter
            ?.completeError(AccessTokenRevokedException());
      }

      await _chat.connectionManager.disconnect(logout: true);
      _chat.eventManager.notifySessionClosed();
    } else if (cmd.errorCode == SendbirdError.accessTokenNotValid) {
      if (_chat.chatContext.loginCompleter != null &&
          !_chat.chatContext.loginCompleter!.isCompleted) {
        _chat.chatContext.loginCompleter
            ?.completeError(InvalidAccessTokenException());
      }

      await _chat.connectionManager.disconnect(logout: true);
      _chat.eventManager.notifySessionError(InvalidAccessTokenException());
    } else {
      await _chat.connectionManager.disconnect(logout: true);
      throw WebSocketFailedException(
          code: cmd.errorCode, message: cmd.errorMessage);
    }
  }

  Future<void> _processSystemEvent(Command cmd) async {
    final event = ChannelEvent.fromJsonWithChat(_chat, cmd.payload);

    switch (event.category) {
      case ChannelEventCategory.typingStart:
        await _processTyping(event, true);
        break;
      case ChannelEventCategory.typingEnd:
        await _processTyping(event, false);
        break;
      case ChannelEventCategory.ban:
        await _processBan(event, true);
        break;
      case ChannelEventCategory.unban:
        await _processBan(event, false);
        break;
      case ChannelEventCategory.mute:
        await _processMute(event, true);
        break;
      case ChannelEventCategory.unmute:
        await _processMute(event, false);
        break;
      case ChannelEventCategory.frozen:
        await _processChannelFrozen(event, true);
        break;
      case ChannelEventCategory.unfrozen:
        await _processChannelFrozen(event, false);
        break;
      case ChannelEventCategory.invite:
        await _processChannelInvite(event);
        break;
      case ChannelEventCategory.declineInvite:
        await _processChannelDeclineInvitation(event);
        break;
      case ChannelEventCategory.join:
        await _processChannelJoin(event, true);
        break;
      case ChannelEventCategory.leave:
        await _processChannelJoin(event, false);
        break;
      case ChannelEventCategory.enter:
        await _processChannelEnter(event, true);
        break;
      case ChannelEventCategory.exit:
        await _processChannelEnter(event, false);
        break;
      case ChannelEventCategory.hidden:
        await _processChannelHidden(event, event.messageOffset, true);
        break;
      case ChannelEventCategory.unhidden:
        await _processChannelHidden(event, 0, false);
        break;
      case ChannelEventCategory.deleted:
        await _processChannelDelete(event);
        break;
      case ChannelEventCategory.metaDataChanged:
        await _processChannelMetaData(event);
        break;
      case ChannelEventCategory.metaCounterChanged:
        await _processChannelMetaCounter(event);
        break;
      case ChannelEventCategory.propChanged:
        await _processChannelPropChanged(event);
        break;
      case ChannelEventCategory.updateOperators:
        await _processChannelOperators(event);
        break;
      case ChannelEventCategory.pinnedMessage:
        await _processChannelPinnedMessage(event);
        break;
      default:
        break;
    }
  }

  Future<void> _processTyping(ChannelEvent event, bool start) async {
    try {
      final user = User.fromJsonWithChat(_chat, event.data);

      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
        chat: _chat,
      );

      final GroupChannel? groupChannel = _eitherGroupOrFeed(channel);
      if (groupChannel != null) {
        final status = TypingStatus(
          channelType: ChannelType.group,
          channelUrl: event.channelUrl,
          user: user,
          timestamp: DateTime.now().millisecondsSinceEpoch,
        );

        if (start) {
          status.saveToCache(_chat);
        } else {
          status.removeFromCache(_chat);
        }

        _chat.eventManager.notifyChannelTypingStatusUpdated(groupChannel);
      }
    } catch (e) {
      sbLog.e(StackTrace.current, 'eventCategory: ${event.category}, e: $e');
    }
  }

  Future<void> _processBan(ChannelEvent event, bool banned) async {
    try {
      final user = banned
          ? RestrictedUser.fromJsonWithChat(_chat, event.data)
          : User.fromJsonWithChat(_chat, event.data);

      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
        chat: _chat,
      );

      if (banned) {
        if (channel is OpenChannel && user.isCurrentUser) {
          channel.removeFromCache(_chat);
        } else {
          final GroupChannel? groupChannel = _eitherGroupOrFeed(channel);
          if (groupChannel != null) {
            if (groupChannel.isSuper) {
              // has to be checked by ts
              groupChannel.updateMemberCounts(event);
            } else {
              groupChannel.removeMember(event.user?.userId);
            }

            if (user.isCurrentUser) {
              groupChannel.myMemberState = MemberState.none;
              groupChannel.invitedAt = 0;
              groupChannel.clearUnreadCount();
              if (!groupChannel.isPublic) {
                channel.removeFromCache(_chat);
              }
            }
          }
        }
        _chat.eventManager.notifyUserBanned(channel, user as RestrictedUser);
      } else {
        _chat.eventManager.notifyUserUnbanned(channel, user);
      }
    } catch (e) {
      sbLog.e(StackTrace.current, 'eventCategory: ${event.category}, e: $e');
    }
  }

  Future<void> _processMute(ChannelEvent event, bool muted) async {
    try {
      final user = muted
          ? RestrictedUser.fromJsonWithChat(_chat, event.data)
          : User.fromJsonWithChat(_chat, event.data);

      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
        chat: _chat,
      );

      final GroupChannel? groupChannel = _eitherGroupOrFeed(channel);
      if (groupChannel != null) {
        if (user.isCurrentUser) {
          groupChannel.myMutedState =
              muted ? MuteState.muted : MuteState.unmuted;
        }

        final member = groupChannel.members
            .firstWhereOrNull((e) => e.userId == user.userId);
        member?.restrictionInfo =
            muted ? RestrictionInfo.fromJson(event.data) : null;
        member?.isMuted = muted;
      }

      if (muted) {
        _chat.eventManager.notifyUserMuted(channel, user as RestrictedUser);
      } else {
        _chat.eventManager.notifyUserUnmuted(channel, user);
      }
    } catch (e) {
      sbLog.e(StackTrace.current, 'eventCategory: ${event.category}, e: $e');
    }
  }

  Future<void> _processChannelJoin(ChannelEvent event, bool joined) async {
    try {
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
        chat: _chat,
      );

      final GroupChannel? groupChannel = _eitherGroupOrFeed(channel);
      if (groupChannel != null) {
        if (joined) {
          if (groupChannel.isSuper) {
            groupChannel.updateMemberCounts(event);
          }

          final members = event.joinedMembers;

          for (final member in members) {
            if (!groupChannel.isSuper) {
              groupChannel.addMember(member);
            }

            if (member.isCurrentUser) {
              groupChannel.myMemberState = MemberState.joined;
            }
            _chat.eventManager.notifyUserJoined(groupChannel, member);
            _chat.eventManager.notifyChannelMemberCountChanged([groupChannel]);
          }
        } else {
          final groupChannel =
              GroupChannel.getChannelFromCache(event.channelUrl);

          if (groupChannel != null) {
            if (groupChannel.isSuper) {
              groupChannel.updateMemberCounts(event);
            }

            final member = Member.fromJsonWithChat(_chat, event.data);
            if (!groupChannel.isSuper) {
              groupChannel.removeMember(member.userId);
            }

            groupChannel.updateTypingStatus(member, typing: false);

            if (member.isCurrentUser) {
              groupChannel.myMemberState = MemberState.none;
              groupChannel.invitedAt = 0;
              groupChannel.joinedAt = 0;
              groupChannel.clearUnreadCount();
              if (!groupChannel.isPublic) {
                groupChannel.removeFromCache(_chat);
              }
            }
            _chat.eventManager.notifyUserLeft(groupChannel, member);
            _chat.eventManager.notifyChannelMemberCountChanged([groupChannel]);
          }
        }
      }
    } catch (e) {
      sbLog.e(StackTrace.current, 'eventCategory: ${event.category}, e: $e');
    }
  }

  Future<void> _processChannelInvite(ChannelEvent event) async {
    try {
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
        chat: _chat,
      );

      final GroupChannel? groupChannel = _eitherGroupOrFeed(channel);
      if (groupChannel != null) {
        final invitees = event.invitees;
        final inviter = event.inviter;

        if (groupChannel.isSuper) {
          groupChannel.updateMemberCounts(event);
        } else if (inviter != null) {
          groupChannel.addMember(inviter);
        }

        for (final member in invitees) {
          if (!groupChannel.isSuper) {
            groupChannel.addMember(member);
          }

          if (member.isCurrentUser) {
            if (groupChannel.myMemberState != MemberState.joined) {
              groupChannel.myMemberState = MemberState.invited;
            }

            if (groupChannel.hiddenState ==
                GroupChannelHiddenState.allowAutoUnhide) {
              groupChannel.isHidden = false;
              groupChannel.hiddenState = GroupChannelHiddenState.unhidden;
            }

            groupChannel.invitedAt = event.invitedAt;
          }
        }

        _chat.eventManager.notifyUserReceivedInvitation(
          groupChannel,
          invitees,
          inviter,
        );
      }
    } catch (e) {
      sbLog.e(StackTrace.current, 'eventCategory: ${event.category}, e: $e');
    }
  }

  Future<void> _processChannelDeclineInvitation(ChannelEvent event) async {
    try {
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
        chat: _chat,
      );

      final GroupChannel? groupChannel = _eitherGroupOrFeed(channel);
      if (groupChannel != null) {
        if (groupChannel.isSuper) {
          groupChannel.updateMemberCounts(event);
        } else {
          groupChannel.removeMember(event.invitee?.userId);
        }

        if (event.invitee?.isCurrentUser == true) {
          groupChannel.myMemberState = MemberState.none;
          groupChannel.invitedAt = 0;

          if (!groupChannel.isPublic) {
            groupChannel.removeFromCache(_chat);
          }
        }

        _chat.eventManager.notifyUserDeclinedInvitation(
          groupChannel,
          event.invitee!,
          event.inviter,
        );
      }
    } catch (e) {
      sbLog.e(StackTrace.current, 'eventCategory: ${event.category}, e: $e');
    }
  }

  Future<void> _processChannelEnter(ChannelEvent event, bool entered) async {
    try {
      if (event.channelType == ChannelType.open) {
        final channel = await OpenChannel.getChannel(event.channelUrl);
        final user = event.user;
        if (user == null) throw MalformedDataException();

        channel.participantCount = event.participantCount;

        if (entered) {
          _chat.eventManager.notifyUserEntered(channel, user);
          _chat.eventManager.notifyChannelParticipantCountChanged([channel]);
        } else {
          _chat.eventManager.notifyUserExited(channel, user);
          _chat.eventManager.notifyChannelParticipantCountChanged([channel]);
        }
      }
    } catch (e) {
      sbLog.e(StackTrace.current, 'eventCategory: ${event.category}, e: $e');
    }
  }

  Future<void> _processChannelFrozen(ChannelEvent event, bool frozen) async {
    try {
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
        chat: _chat,
      );

      channel.isFrozen = frozen;

      if (frozen) {
        _chat.eventManager.notifyChannelFrozen(channel);
      } else {
        _chat.eventManager.notifyChannelUnfrozen(channel);
      }
    } catch (e) {
      sbLog.e(StackTrace.current, 'eventCategory: ${event.category}, e: $e');
    }
  }

  Future<void> _processChannelHidden(
    ChannelEvent event,
    int? messageOffset,
    bool hidden,
  ) async {
    try {
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
        chat: _chat,
      );

      final GroupChannel? groupChannel = _eitherGroupOrFeed(channel);
      if (groupChannel != null) {
        if (hidden) {
          groupChannel.messageOffsetTimestamp = messageOffset;

          if (event.hidePreviousMessage) {
            groupChannel.clearUnreadCount();
          }
        }

        groupChannel.isHidden = hidden;
        groupChannel.hiddenState = event.hiddenState;

        if (hidden) {
          _chat.eventManager.notifyChannelHidden(groupChannel);
        } else {
          _chat.eventManager.notifyChannelChanged(channel);
        }
      }
    } catch (e) {
      sbLog.e(StackTrace.current, 'eventCategory: ${event.category}, e: $e');
    }
  }

  Future<void> _processChannelMetaData(ChannelEvent event) async {
    try {
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
        chat: _chat,
      );

      final cachedMetaData = _chat.channelCache
              .find<MetaDataCache<String>>(channelKey: event.channelUrl) ??
          MetaDataCache(
            channelType: event.channelType,
            channelUrl: event.channelUrl,
            timestamp: event.ts,
          );

      final created = Map<String, String>.from(event.data['created'] ?? {});
      final updated = Map<String, String>.from(event.data['updated'] ?? {});
      final deleted = List<String>.from(event.data['deleted'] ?? []);

      cachedMetaData.addMap(created, event.ts);
      cachedMetaData.addMap(updated, event.ts);
      cachedMetaData.removeWithKeys(deleted, event.ts);
      cachedMetaData.saveToCache(_chat);

      _chat.eventManager.notifyMetaDataChanged(channel, event.data);
    } catch (e) {
      sbLog.e(StackTrace.current, 'eventCategory: ${event.category}, e: $e');
    }
  }

  Future<void> _processChannelMetaCounter(ChannelEvent event) async {
    try {
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
        chat: _chat,
      );

      _chat.eventManager.notifyMetaCountersChanged(channel, event.data);
    } catch (e) {
      sbLog.e(StackTrace.current, 'eventCategory: ${event.category}, e: $e');
    }
  }

  Future<void> _processChannelOperators(ChannelEvent event) async {
    try {
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
        chat: _chat,
      );

      if (channel is OpenChannel) {
        channel.operators = event.operators;
      } else {
        final GroupChannel? groupChannel = _eitherGroupOrFeed(channel);
        if (groupChannel != null) {
          for (final member in groupChannel.members) {
            final isOperator = event.operators
                .where((e) => e.userId == member.userId)
                .isNotEmpty;
            member.role = isOperator ? Role.operator : Role.none;
            if (member.isCurrentUser) {
              groupChannel.myRole = isOperator ? Role.operator : Role.none;
            }
          }
        }
      }

      _chat.eventManager.notifyOperatorUpdated(channel);
    } catch (e) {
      sbLog.e(StackTrace.current, 'eventCategory: ${event.category}, e: $e');
    }
  }

  Future<void> _processChannelPropChanged(ChannelEvent event) async {
    try {
      final channel = await BaseChannel.refreshChannel(
        event.channelType,
        event.channelUrl,
        chat: _chat,
      );

      final GroupChannel? groupChannel = _eitherGroupOrFeed(channel);
      if (groupChannel != null) {
        if (!groupChannel.canChangeUnreadMessageCount) {
          groupChannel.unreadMessageCount = 0;
        }
        if (!groupChannel.canChangeUnreadMentionCount) {
          groupChannel.unreadMentionCount = 0;
        }
      }

      channel.saveToCache(_chat);
      _chat.eventManager.notifyChannelChanged(channel);
    } catch (e) {
      sbLog.e(StackTrace.current, 'eventCategory: ${event.category}, e: $e');
    }
  }

  Future<void> _processChannelDelete(ChannelEvent event) async {
    _chat.channelCache.delete(channelKey: event.channelUrl);

    _chat.eventManager.notifyChannelDeleted(
      event.channelUrl,
      event.channelType,
    );
  }

  Future<void> _processChannelPinnedMessage(ChannelEvent event) async {
    try {
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
        chat: _chat,
      );

      final GroupChannel? groupChannel = _eitherGroupOrFeed(channel);
      if (groupChannel != null) {
        if (event.data.isEmpty) {
          groupChannel.pinnedMessageIds = [];
          groupChannel.lastPinnedMessage = null;
        } else if ((event.ts ?? 0) >
            event.data['latest_pinned_message']['updated_at']) {
          groupChannel.pinnedMessageIds =
              event.data["pinned_message_ids"].cast<int>();
          groupChannel.lastPinnedMessage =
              RootMessage.fromJson(event.data["latest_pinned_message"])
                  as BaseMessage;
        }

        groupChannel.pinnedMessageUpdatedAt = event.ts ?? 0;
        _chat.eventManager.notifyPinnedMessageUpdated(groupChannel);
      }
    } catch (e) {
      sbLog.e(StackTrace.current, 'eventCategory: ${event.category}, e: $e');
    }
  }

  Future<void> _processUserEvent(Command cmd) async {
    final event = UserEvent.fromJsonWithChat(_chat, cmd.payload);
    switch (event.category) {
      case UserEventCategory.userBlock:
        _processBlock(event);
        break;
      case UserEventCategory.userUnblock:
        _processUnblock(event);
        break;
      case UserEventCategory.friendDiscovered:
        _processFriendDiscovery(event);
        break;
      default:
        break;
    }
  }

  void _processBlock(UserEvent event) {
    final channels = _chat.channelCache.findAll<BaseChannel>();
    channels?.forEach((channel) {
      final GroupChannel? groupChannel = _eitherGroupOrFeed(channel);
      if (groupChannel != null) {
        groupChannel.setBlockedByMe(
          targetId: event.blockee.userId,
          blocked: true,
        );
      }
    });
  }

  void _processUnblock(UserEvent event) {
    final channels = _chat.channelCache.findAll<BaseChannel>();
    channels?.forEach((channel) {
      final GroupChannel? groupChannel = _eitherGroupOrFeed(channel);
      if (groupChannel != null) {
        groupChannel.setBlockedByMe(
          targetId: event.blockee.userId,
          blocked: false,
        );
      }
    });
  }

  void _processFriendDiscovery(UserEvent event) {
    _chat.eventManager.notifyFriendsDiscovered(event.friendDiscoveries);
  }

  Future<void> _processPollVoted(Command cmd) async {
    if (_isFeedChannel(cmd)) return;

    if (_isGroupChannel(cmd)) {
      final channel = await GroupChannel.getChannel(cmd.payload['channel_url']);

      final event = PollVoteEvent.fromJson(cmd.payload);
      _chat.eventManager.notifyPollVoted(channel, event);
    }
  }

  Future<void> _processPollUpdated(Command cmd) async {
    if (_isFeedChannel(cmd)) return;

    if (_isGroupChannel(cmd)) {
      final channel = await GroupChannel.getChannel(cmd.payload['channel_url']);

      if (cmd.payload['poll']['status'] == 'removed') {
        _chat.eventManager
            .notifyPollDeleted(channel, cmd.payload['poll']['id']);
      } else {
        final event = PollUpdateEvent.fromJson(cmd.payload);
        _chat.eventManager.notifyPollUpdated(channel, event);
      }
    }
  }
}
