import 'dart:async';

import '../network/websocket_client.dart';
import '../../message/base_message_internal.dart';
import '../../channel/base_channel.dart';
import '../../channel/group_channel.dart';
import '../../channel/group_channel_internal.dart';
import '../../channel/open_channel.dart';
import '../../constant/enums.dart';
import '../../core/async/async_operation.dart';
import '../../core/async/async_queue.dart';
import '../../event/event_manager.dart';
import '../../features/delivery/delivery_status.dart';
import '../../features/read/read_status.dart';
import '../../features/reaction/reaction_event.dart';
import '../../features/thread/thread_info_update_event.dart';
import '../../features/typing/typing_status.dart';
import '../../models/channel_event.dart';
import '../../models/command.dart';
import '../../models/error.dart';
import '../../models/reconnect_task.dart';
import '../../models/state.dart';
import '../../models/unread_count_info.dart';
import '../../models/user_event.dart';
import '../../models/member.dart';
import '../../models/user.dart';
import '../../sdk/sendbird_sdk_api.dart';
import '../../sdk/sendbird_sdk_internal.dart';
import '../../services/db/cache_service.dart';
import '../../utils/logger.dart';
import '../../utils/parsers.dart';
import '../../utils/request_validator.dart';

class SdkAccessor {
  SendbirdSdkInternal get sdk => SendbirdSdk().getInternal();
  WebSocketClient get webSocket => sdk?.webSocket;
  SendbirdState get appState => sdk?.state;
  EventManager get eventManager => sdk?.eventManager;
}

class CommandManager with SdkAccessor {
  Map<String, Timer> ackTimers = {};
  Map<String, Completer<Command>> completers = {};

  AsyncQueue queue = AsyncQueue<Command>();

  void cleanUp() {
    ackTimers.removeWhere((key, value) => true);
    queue.cleanUp();
    clearCompleters();
  }

  void clearCompleters({Error error}) {
    completers.forEach((key, value) {
      if (error != null)
        value.completeError(error);
      else
        value.complete();
    });
    completers.removeWhere((key, value) => true);
  }

  Future<Command> sendCommand(Command cmd) async {
    if (appState.currentUser == null) {
      //NOTE: some test cases execute async socket data
      //even after test case was finished
      // print('[E] ${this.hashCode}');
      throw ConnectionRequiredError();
    }
    if (cmd == null) throw InvalidParameterError();
    if (!webSocket.isConnected()) throw ConnectionClosedError();

    if (cmd.isAckRequired) {
      final timer = Timer(Duration(seconds: sdk.options.websocketTimeout), () {
        throw WebSocketTimeoutError();
      });
      ackTimers[cmd.requestId] = timer;
    }

    if (await RequestValidator.readyToExecuteWsRequest()) {
      webSocket.send(cmd.encode());
    } else {
      ackTimers[cmd.requestId].cancel();
      ackTimers.removeWhere((key, value) => key == cmd.requestId);
      throw WebSocketError();
    }

    if (cmd.isAckRequired) {
      final completer = new Completer<Command>();
      completers[cmd.requestId] = completer;
      // print('waiting to completion ${completer.hashCode} to be finished');
      return completer.future;
    } else {
      return null;
    }
  }

  void processCommand(Command cmd) {
    _updateSubscribedUnreadCountInfo(cmd.unreadCountInfo);
    if (cmd.hasRequestId()) {
      ackTimers.remove(cmd.requestId)?.cancel();
      final completer = completers.remove(cmd.requestId);
      completer.complete(cmd);
    }

    Function(Command) fnc;
    if (cmd.isError)
      throw SBError(code: cmd.errorCode, message: cmd.errorMessage);
    else if (cmd.hasRequestId() && cmd.isLogin)
      fnc = _processSessionRefresh;
    else if (cmd.isLogin)
      fnc = _processLogin;
    else if (cmd.isSessionExpired)
      fnc = _processSessionExpired;
    else if (cmd.isNewMessage)
      fnc = _processNewMessage;
    else if (cmd.isUpdatedMessage)
      fnc = _processUpdateMessage;
    else if (cmd.isDeletedMessage)
      fnc = _processDeleteMessage;
    else if (cmd.isRead)
      fnc = _processRead;
    else if (cmd.isDelivery)
      fnc = _processDelivery;
    else if (cmd.isThread)
      fnc = _processThread;
    else if (cmd.isReaction)
      fnc = _processReaction;
    else if (cmd.isUserEvent)
      fnc = _processUserEvent;
    else if (cmd.isSystemEvent)
      fnc = _processSystemEvent;
    else {/*not handle command*/}

    if (fnc != null) {
      final op = AsyncOperation<Command>(fnc: fnc, arg: cmd);
      queue.enqueue(op);
    }
  }

  void _updateSubscribedUnreadCountInfo(UnreadCountInfo info) {
    if (info == null) return;
    if (sdk.state.unreadCountInfo.ts > info.ts) return;

    final unreadCount = sdk.state.unreadCountInfo;
    if (unreadCount.all != info.all) {
      sdk.totalUnreadCountController.add(info.all);
    }

    final didChange = unreadCount.copyWith(info);
    if (didChange) {
      eventManager.notifyUpdateTotalUnreadMessageCount(
        unreadCount.all,
        unreadCount.customTypes,
      );
    }
  }

  Future<void> _processLogin(Command cmd) async {
    final sdk = SendbirdSdk().getInternal();

    if (cmd.hasError) {
      throw SBError(code: cmd.errorCode, message: cmd.errorMessage);
    }

    sdk.webSocket.setInterval(cmd.pingInterval);
    sdk.webSocket.setWatchdogInterval(cmd.watchdogInterval);

    final user = cmd.user;

    //Update AppInfo in state
    sdk.state
      ..appInfo = cmd.appInfo
      ..maxUnreadCountOnSuperGroup = cmd.maxUnreadCountOnSuperGroup
      ..reconnectConfig = cmd.reconnectConfiguration
      ..reconnectTask = ReconnectTask(cmd.reconnectConfiguration)
      ..currentUser = user
      ..userId = user.userId
      ..connected = true
      ..connecting = false
      ..lastConnectedAt = cmd.loginTimestamp;

    sdk.sessionManager
      ..setUserId(user.userId)
      ..setEKey(cmd.ekey)
      ..setSessionKey(cmd.sessionKey)
      ..setSessionExpiresIn(cmd.expiresIn)
      ..isOpened = true;

    sdk.api.userId = user.userId;
    sdk.api.initialize(sessionKey: cmd.sessionKey);

    if (sdk.state.reconnecting) {
      eventManager.notifyReconnectionSucceeded();

      //if reconnecting on error
      //notify network reconnected
      //else
      //process all waiting connection callback handler

      //enter previously cached open channel
      final channels = sdk.cache.findAll<OpenChannel>();
      channels.forEach((channel) async {
        channel.enter().then((value) {}).catchError((error) {
          sdk.cache.delete(channelKey: channel.channelUrl);
        });
      });
    } else {
      //start reachability module
      //notify logi completion
    }

    sdk.loginCompleter.complete(user);
  }

  Future<void> _processSessionExpired(Command cmd) async {
    await sdk.sessionManager.updateSession();
  }

  Future<void> _processNewMessage(Command cmd) async {
    try {
      final message = await parseMessage(cmd);
      if (cmd.hasRequestId()) {
        //if sent by api then added id to cache -> done
        if (message.channelType == ChannelType.group) {
          sendCommand(Command.buildMessageMACK(
            message.channelUrl,
            message.messageId,
          ));
        }
      }

      final channel = await BaseChannel.getBaseChannel(
        message.channelType,
        message.channelUrl,
      );

      if (!cmd.hasRequestId()) {
        eventManager.notifyMessageReceived(channel, message);
      }

      if (channel is GroupChannel) {
        if (channel.hiddenState == GroupChannelHiddenState.allowAutoUnhide) {
          channel.isHidden = false;
          channel.hiddenState = GroupChannelHiddenState.unhidden;
        }

        channel.updateMember(cmd.sender);

        var shouldCallChannelChanged = false;
        if (channel.shouldUpdateLastMessage(message, cmd.sender)) {
          shouldCallChannelChanged = true;
          channel.lastMessage = message;
        }

        if (channel.fromCache && channel.updateUnreadCount(message)) {
          shouldCallChannelChanged = true;
        }

        if (shouldCallChannelChanged) {
          eventManager.notifyChannelChanged(channel);
        }
      }

      final currentUser = appState.currentUser;
      if (message.mentioned(user: currentUser, byOtherUser: message.sender)) {
        eventManager.notifyMentionReceived(channel, message);
      }
    } catch (e) {
      logger.w("Abort processing ${cmd.cmd} " + e.toString());
    }
  }

  Future<void> _processUpdateMessage(Command cmd) async {
    try {
      final message = await parseMessage(cmd);
      final currentUser = appState.currentUser;
      final channel = await BaseChannel.getBaseChannel(
        message.channelType,
        message.channelUrl,
      );
      if (channel is OpenChannel) {
        eventManager.notifyMessageUpdate(channel, message);
      } else if (channel is GroupChannel) {
        var shouldCallChannelChanged = false;
        var shouldCallMentionReceived = false;

        if (channel.shouldUpdateLastMessage(message, cmd.sender)) {
          shouldCallChannelChanged = true;
          channel.lastMessage = message;
        }

        final timestamp = channel.myReadReceipt();

        if (message.hasUpdatedLaterThan(timestamp) &&
            !cmd.sender.isCurrentUser &&
            !message.isSilent) {
          if (cmd.hasChangedMentionType() == MentionType.channel &&
              cmd.previousMentionedContains(currentUser)) {
            if (channel.fromCache) channel.increaseUnreadMentionCount();
            shouldCallChannelChanged = true;
            shouldCallMentionReceived = true;
          } else if (cmd.hasChangedMentionType() == MentionType.users &&
              !cmd.previousMentionedContains(currentUser) &&
              cmd.mentionedContains(currentUser)) {
            if (channel.fromCache) channel.increaseUnreadMentionCount();
            shouldCallChannelChanged = true;
            shouldCallMentionReceived = true;
          }
        }

        eventManager.notifyMessageUpdate(channel, message);

        if (shouldCallChannelChanged)
          eventManager.notifyChannelChanged(channel);
        if (shouldCallMentionReceived)
          eventManager.notifyMentionReceived(channel, message);
      }
    } catch (e) {}
  }

  Future<void> _processDeleteMessage(Command cmd) async {
    try {
      final channel = await BaseChannel.getBaseChannel(
        cmd.channelType,
        cmd.channelUrl,
      );
      eventManager.notifyMessageDeleted(channel, cmd.messageId);
    } catch (e) {}
  }

  Future<void> _processRead(Command cmd) async {
    try {
      ReadStatus status = ReadStatus.fromJson(cmd.payload);
      final channel = await GroupChannel.getChannel(cmd.channelUrl);

      final isCurrentUser = status.userId == sdk.state.userId;
      if (isCurrentUser) {
        channel.myLastRead = status.timestamp;
      } else {
        eventManager.notifyChannelReadReceiptUpdated(channel);
      }

      if (isCurrentUser && channel.fromCache) {
        channel.clearUnreadCount();
      }

      if (isCurrentUser &&
          (channel.unreadMessageCount > 0 || channel.unreadMentionCount > 0)) {
        eventManager.notifyChannelChanged(channel);
      }

      status.saveToCache();
    } catch (e) {}
  }

  Future<void> _processDelivery(Command cmd) async {
    try {
      DeliveryStatus status = DeliveryStatus.fromJson(cmd.payload);

      final channel = await GroupChannel.getChannel(cmd.channelUrl);
      final currUserId = appState.currentUser.userId;
      bool shouldCallDelivery = true;
      if (status.updatedDeliveryReceipt.length == 1 &&
          status.updatedDeliveryReceipt[currUserId] != null) {
        //not to call
        shouldCallDelivery = false;
      }

      if (shouldCallDelivery) {
        eventManager.notifyDeliveryReceiptUpdated(channel);
      }

      status.saveToCache();
    } catch (e) {}
  }

  Future<void> _processThread(Command cmd) async {
    try {
      ThreadInfoUpdateEvent event = ThreadInfoUpdateEvent.fromJson(cmd.payload);
      final channel = await GroupChannel.getChannel(cmd.channelUrl);
      eventManager.notifyChannelThreadUpdated(channel, event);
    } catch (e) {
      logger.w("Abort processing ${cmd.cmd} " + e.toString());
    }
  }

  Future<void> _processReaction(Command cmd) async {
    try {
      ReactionEvent event = ReactionEvent.fromJson(cmd.payload);
      final channel = await BaseChannel.getBaseChannel(
        cmd.channelType,
        cmd.channelUrl,
      );
      eventManager.notifyReactionUpdated(channel, event);
    } catch (e) {
      logger.w("Abort processing ${cmd.cmd} " + e.toString());
    }
  }

  Future<void> _processSessionRefresh(Command cmd) async {
    sdk.sessionManager.setSessionKey(cmd.sessionKey);
    sdk.sessionManager.setSessionExpiresIn(cmd.expiresIn);
  }

  Future<void> _processError(Command cmd) async {
    logger.e("Socket error " + cmd.errorMessage);
  }

  // System
  Future<void> _processSystemEvent(Command cmd) async {
    ChannelEvent event = ChannelEvent.fromJson(cmd.payload);

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
        await _processChannelHidden(event, cmd.messageOffset, true);
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
      default:
        break;
    }
  }

  Future<void> _processTyping(ChannelEvent event, bool start) async {
    try {
      User user = User.fromJson(event.data);
      final channel = await GroupChannel.getChannel(event.channelUrl);
      TypingStatus status = TypingStatus(
        channelType: ChannelType.group,
        channelUrl: event.channelUrl,
        user: user,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );

      if (start) {
        status.saveToCache();
      } else {
        status.removeFromCache();
      }

      eventManager.notifyChannelTypingStatusUpdated(channel);
      status.saveToCache();
    } catch (e) {}
  }

  Future<void> _processBan(ChannelEvent event, bool banned) async {
    try {
      User user = User.fromJson(event.data);
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
      );
      if (banned) {
        if (channel is OpenChannel && user.isCurrentUser) {
          channel.removeFromCache();
        } else if (channel is GroupChannel) {
          if (channel.isSuper) {
            //has to be checked by ts
            channel.updateMemberCounts(event);
          } else {
            channel.removeMember(event.user.userId);
          }

          if (user.isCurrentUser) {
            channel.myMemberState = MemberState.none;
            channel.invitedAt = 0;
            channel.clearUnreadCount();
            if (!channel.isPublic) {
              channel.removeFromCache();
            }
          }
        }
        eventManager.notifyUserBanned(channel, user);
      } else
        eventManager.notifyUserUnbanned(channel, user);
    } catch (e) {}
  }

  Future<void> _processMute(ChannelEvent event, bool muted) async {
    try {
      User user = User.fromJson(event.data);
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
      );
      if (channel is GroupChannel) {
        if (user.isCurrentUser) {
          channel.myMutedState = muted ? MuteState.muted : MuteState.unmuted;
        }

        Member member =
            channel.members.firstWhere((e) => e.userId == user.userId);
        member?.isMuted = muted;
      }

      if (muted)
        eventManager.notifyUserMuted(channel, user);
      else
        eventManager.notifyUserUnmuted(channel, user);
    } catch (e) {}
  }

  Future<void> _processChannelJoin(ChannelEvent event, bool joined) async {
    try {
      final channel = await GroupChannel.getChannel(event.channelUrl);
      if (channel.isSuper) {
        channel.updateMemberCounts(event);
      }

      if (joined) {
        for (Member member in event.users) {
          if (!channel.isSuper) {
            channel.addMember(member);
          }

          if (member.isCurrentUser) {
            channel.myMemberState = MemberState.joined;
          }
          eventManager.notifyUserJoined(channel, member);
        }
      } else {
        Member member = Member.fromJson(event.data);
        if (!channel.isSuper) {
          channel.removeMember(member.userId);
        }

        channel.updateTypingStatus(member, typing: false);

        if (member.isCurrentUser) {
          channel.myMemberState = MemberState.none;
          channel.invitedAt = 0;
          channel.clearUnreadCount();
          if (!channel.isPublic) {
            channel.removeFromCache();
          }
        }
        eventManager.notifyUserLeaved(channel, member);
      }
    } catch (e) {}
  }

  Future<void> _processChannelInvite(ChannelEvent event) async {
    try {
      final channel = await GroupChannel.getChannel(event.channelUrl);
      if (channel.isSuper) {
        channel.updateMemberCounts(event);
      } else if (event.inviter != null) {
        channel.addMember(event.inviter);
      }

      for (Member member in event.invitees) {
        if (!channel.isSuper) {
          channel.addMember(member);
        }

        if (member.isCurrentUser) {
          if (channel.myMemberState != MemberState.joined) {
            channel.myMemberState = MemberState.invited;
          }

          if (channel.hiddenState == GroupChannelHiddenState.allowAutoUnhide) {
            channel.isHidden = false;
            channel.hiddenState = GroupChannelHiddenState.unhidden;
          }

          channel.invitedAt = event.invitedAt;
        }
      }

      eventManager.notifyInvitationReceived(
        channel,
        event.invitees,
        event.inviter,
      );
    } catch (e) {}
  }

  Future<void> _processChannelDeclineInvitation(ChannelEvent event) async {
    try {
      final channel = await GroupChannel.getChannel(event.channelUrl);
      if (channel.isSuper) {
        channel.updateMemberCounts(event);
      } else {
        channel.removeMember(event.invitee.userId);
      }

      if (event.invitee != null && event.invitee.isCurrentUser) {
        channel.myMemberState = MemberState.none;
        channel.invitedAt = 0;

        if (!channel.isPublic) {
          channel.removeFromCache();
        }
      }

      eventManager.notifyInvitationDeclied(
        channel,
        event.invitee,
        event.inviter,
      );
    } catch (e) {}
  }

  Future<void> _processChannelEnter(ChannelEvent event, bool entered) async {
    try {
      final channel = await OpenChannel.getChannel(event.channelUrl);
      channel.participantCount = event.participantCount;

      if (entered)
        eventManager.notifyUserEntered(channel, event.user);
      else
        eventManager.notifyUserExited(channel, event.user);
    } catch (e) {}
  }

  Future<void> _processChannelFrozen(ChannelEvent event, bool frozen) async {
    try {
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
      );
      channel.isFrozen = frozen;

      if (frozen)
        eventManager.notifyChannelFrozen(channel);
      else
        eventManager.notifyChannelUnfrozen(channel);
    } catch (e) {}
  }

  Future<void> _processChannelHidden(
    ChannelEvent event,
    int actionOffset,
    bool hidden,
  ) async {
    try {
      final channel = await GroupChannel.getChannel(event.channelUrl);
      if (hidden) {
        channel.messageOffsetTimestamp = actionOffset;

        if (event.hidePreviousMessage) {
          channel.clearUnreadCount();
        }
      }

      channel.isHidden = hidden;
      channel.hiddenState = event.hiddenState;

      if (hidden)
        eventManager.notifyChannelHidden(channel);
      else
        eventManager.notifyChannelChanged(channel);
    } catch (e) {}
  }

  Future<void> _processChannelMetaData(ChannelEvent event) async {
    try {
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
      );
      eventManager.notifyChannelMetaDataChanged(channel, event.data);
    } catch (e) {}
  }

  Future<void> _processChannelMetaCounter(ChannelEvent event) async {
    try {
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
      );
      eventManager.notifyChannelMetaCountersChanged(channel, event.data);
    } catch (e) {}
  }

  Future<void> _processChannelOperators(ChannelEvent event) async {
    try {
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
      );
      if (channel is OpenChannel) {
        channel.operators = event.operators;
      } else if (channel is GroupChannel) {
        channel.members.forEach((member) {
          final isOperator = event.operators
              .where((e) => e.userId == member.userId)
              .isNotEmpty;
          member.role = isOperator ? Role.chat_operator : Role.none;
          if (member.isCurrentUser) {
            channel.myRole = isOperator ? Role.chat_operator : Role.none;
          }
        });
      }
      eventManager.notifyChannelOperatorsUpdated(channel);
    } catch (e) {}
  }

  Future<void> _processChannelPropChanged(ChannelEvent event) async {
    try {
      final channel = await BaseChannel.refreshChannel(
        event.channelType,
        event.channelUrl,
      );
      if (channel is GroupChannel) {
        if (!channel.canChangeUnreadMessageCount)
          channel.unreadMessageCount = 0;
        if (!channel.canChangeUnreadMentionCount)
          channel.unreadMentionCount = 0;
      }
      channel.saveToCache();
      eventManager.notifyChannelChanged(channel);
    } catch (e) {}
  }

  Future<void> _processChannelDelete(ChannelEvent event) async {
    sdk.cache.delete(channelKey: event.channelUrl);
    eventManager.notifyChannelDeleted(
      event.channelUrl,
      event.channelType,
    );
  }

  Future<void> _processUserEvent(Command cmd) async {
    UserEvent event = UserEvent.fromJson(cmd.payload);
    switch (event.category) {
      case UserEventCategory.block:
        _processBlock(event);
        break;
      case UserEventCategory.unblock:
        _processUnblock(event);
        break;
      case UserEventCategory.friendDiscoveryReady:
        _processFriendDiscovery(event);
        break;
      default:
        break;
    }
  }

  void _processBlock(UserEvent event) {
    final sdk = SendbirdSdk().getInternal();
    final channels = sdk.cache.findAll<GroupChannel>();
    channels.forEach((e) => e.setBlockedByMe(
          targetId: event.blockee.userId,
          blocked: true,
        ));
  }

  void _processUnblock(UserEvent event) {
    final sdk = SendbirdSdk().getInternal();
    final channels = sdk.cache.findAll<GroupChannel>();
    channels.forEach((e) => e.setBlockedByMe(
          targetId: event.blockee.userId,
          blocked: false,
        ));
  }

  void _processFriendDiscovery(UserEvent event) {
    // CallbackProcessor.shared().notifyDiscoveredFriend(event.friendDiscoveries);
  }
}
