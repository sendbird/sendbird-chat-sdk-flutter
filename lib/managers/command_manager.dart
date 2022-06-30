import 'dart:async';
import 'dart:convert';
import 'package:collection/collection.dart';

import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/constant/error_code.dart';
import 'package:sendbird_sdk/core/channel/base/base_channel.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel_internal.dart';
import 'package:sendbird_sdk/core/channel/open/open_channel.dart';
import 'package:sendbird_sdk/core/message/base_message_internal.dart';
import 'package:sendbird_sdk/core/models/command.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/member.dart';
import 'package:sendbird_sdk/core/models/reconnect_task.dart';
import 'package:sendbird_sdk/core/models/restricted_user.dart';
import 'package:sendbird_sdk/core/models/unread_count_info.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/events/channel_event.dart';
import 'package:sendbird_sdk/events/login_event.dart';
import 'package:sendbird_sdk/events/mcnt_event.dart';
import 'package:sendbird_sdk/events/message_event.dart';
import 'package:sendbird_sdk/events/poll_update_event.dart';
import 'package:sendbird_sdk/events/poll_vote_event.dart';
import 'package:sendbird_sdk/events/session_event.dart';
import 'package:sendbird_sdk/events/user_event.dart';
import 'package:sendbird_sdk/features/delivery/delivery_status.dart';
import 'package:sendbird_sdk/features/delivery/read_status.dart';
import 'package:sendbird_sdk/features/reaction/reaction_event.dart';
import 'package:sendbird_sdk/features/threading/thread_info_update_event.dart';
import 'package:sendbird_sdk/features/typing/typing_status.dart';
import 'package:sendbird_sdk/managers/connection_manager.dart';
import 'package:sendbird_sdk/request/abstract/ws_event.dart';
import 'package:sendbird_sdk/request/abstract/ws_request.dart';
import 'package:sendbird_sdk/sdk/internal/sendbird_sdk_accessor.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:sendbird_sdk/services/db/cache_service.dart';
import 'package:sendbird_sdk/services/db/cached_meta_data/cached_data_map.dart';
import 'package:sendbird_sdk/utils/async/async_operation.dart';
import 'package:sendbird_sdk/utils/async/async_queue.dart';
import 'package:sendbird_sdk/utils/logger.dart';
import 'package:sendbird_sdk/utils/parsers.dart';

class CommandManager with SdkAccessor {
  final Map<String, Timer> _ackTimers = {};
  final Map<String, Completer<Command?>> _completers = {};
  final Map<String, Completer<WsEvent>> _completers2 = {};
  final AsyncQueue _queue = AsyncQueue<Command>();

  void cleanUp() {
    _ackTimers.removeWhere((key, value) => true);
    _queue.cleanUp();
    clearCompleters();
  }

  void clearCompleters({Error? error}) {
    _completers.forEach((key, value) {
      if (error != null) {
        value.completeError(error);
      } else {
        value.complete();
      }
    });
    _completers.removeWhere((key, value) => true);
  }

  Future<WsEvent?> send(WsRequest request) async {
    if (appState.currentUser == null) {
      //NOTE: some test cases execute async socket data
      logger.e('sendCommand: connection is requred');
      throw ConnectionRequiredError();
    }

    try {
      await ConnectionManager.readyToExecuteWSRequest();
    } catch (e) {
      _ackTimers.remove(request.requestId)?.cancel();
      rethrow;
    }

    try {
      webSocket?.send(request.encoded);
    } catch (e) {
      _ackTimers.remove(request.requestId)?.cancel();
      rethrow;
    }

    final reqId = request.requestId;
    if (request.isAckRequired && reqId != null) {
      final timer = Timer(Duration(seconds: sdk.options.websocketTimeout), () {
        logger.e('sendCommand: did not receive ack in time');
        throw AckTimeoutError();
      });
      _ackTimers[reqId] = timer;

      final completer = Completer<WsEvent>();
      _completers2[reqId] = completer;
      return completer.future;
    } else {
      return null;
    }
  }

  Future<Command?> sendCommand(Command cmd) async {
    if (appState.currentUser == null) {
      //NOTE: some test cases execute async socket data
      logger.e('sendCommand: connection is requred');
      throw ConnectionRequiredError();
    }

    // if (!webSocket.isConnected()) {
    //   logger.e('sendCommand: Websocket connection is closed');
    //   throw WebSocketConnectionClosedError();
    // }

    try {
      await ConnectionManager.readyToExecuteWSRequest();
    } catch (e) {
      _ackTimers.remove(cmd.requestId)?.cancel();
      rethrow;
    }

    try {
      webSocket?.send(cmd.encode());
    } catch (e) {
      _ackTimers.remove(cmd.requestId)?.cancel();
      rethrow;
    }
    // } else {
    //   ackTimers[cmd.requestId].cancel();
    //   ackTimers.removeWhere((key, value) => key == cmd.requestId);
    //   throw WebSocketError();
    // }

    final reqId = cmd.requestId;
    logger.i('Command ${cmd.cmd} Payload ${cmd.payload}');
    if (cmd.isAckRequired && reqId != null) {
      final timer = Timer(Duration(seconds: sdk.options.websocketTimeout), () {
        logger.e('sendCommand: did not receive ack in time');
        throw AckTimeoutError();
      });
      _ackTimers[reqId] = timer;

      final completer = Completer<Command>();
      _completers[reqId] = completer;
      return completer.future;
    } else {
      return null;
    }
  }

  void processCommand(Command cmd) {
    final unreadCountPayload = cmd.payload['unread_cnt'];
    if (unreadCountPayload != null) {
      final info = UnreadCountInfo.fromJson(unreadCountPayload);
      _updateSubscribedUnreadCountInfo(info);
    }

    if (cmd.requestId != null) {
      _ackTimers.remove(cmd.requestId)?.cancel();
      final completer = _completers.remove(cmd.requestId);
      // final completer2 = _completers2.remove(cmd.requestId);

      if (cmd.isError || cmd.hasError) {
        if (cmd.errorCode == ErrorCode.accessTokenNotValid) {
          sdk.eventManager.notifySessionTokenRequired();
        }
        completer?.completeError(SBError(
          code: cmd.errorCode,
          message: cmd.errorMessage,
        ));
        // completer2?.completeError(SBError(
        //   code: cmd.errorCode,
        //   message: cmd.errorMessage,
        // ));
        return;
      } else {
        completer?.complete(cmd);
        // completer2?.complete(cmd.event);
      }
    }

    final cmdString = '-- Command: ${cmd.cmd}';
    final encoder = JsonEncoder.withIndent('  ');
    final payloadString = '-- Payload: ${encoder.convert(cmd.payload)}';
    logger.i('Processing Socket event\n$cmdString\n$payloadString');

    // cmd.event?.handleEvent();
    // final handler = cmd.event?.handleEvent;
    // if (handler != null) {
    //   _queue.enqueue(AsyncSimpleTask(handler));
    // }

    Future Function(Command)? fnc;
    if (cmd.isError || cmd.hasError) {
      fnc = _processError;
    } else if (cmd.isLogin && cmd.requestId != null) {
      fnc = _processSessionRefresh;
    } else if (cmd.isLogin) {
      fnc = _processLogin;
    } else if (cmd.isSessionExpired) {
      fnc = _processSessionExpired;
    } else if (cmd.isNewMessage) {
      fnc = _processNewMessage;
    } else if (cmd.isUpdatedMessage) {
      fnc = _processUpdateMessage;
    } else if (cmd.isDeletedMessage) {
      fnc = _processDeleteMessage;
    } else if (cmd.isMemberCountChange) {
      fnc = _processMemberCountChange;
    } else if (cmd.isRead) {
      fnc = _processRead;
    } else if (cmd.isDelivery) {
      fnc = _processDelivery;
    } else if (cmd.isThread) {
      fnc = _processThread;
    } else if (cmd.isReaction) {
      fnc = _processReaction;
    } else if (cmd.isUserEvent) {
      fnc = _processUserEvent;
    } else if (cmd.isSystemEvent) {
      fnc = _processSystemEvent;
    } else if (cmd.isUpdatedPoll) {
      fnc = _processUpdatePoll;
    } else if (cmd.isVote) {
      fnc = _processVote;
    } else {/*not handle command*/}

    if (fnc != null) {
      final op = AsyncTask<Command>(func: fnc, arg: cmd);

      _queue.enqueue(op);
    }
  }

  Future<void> _processUpdatePoll(Command cmd) async {
    final event = PollUpdateEvent.fromJson(cmd.payload);
    eventManager.notifyPollUpdated(event);
  }

  Future<void> _processVote(Command cmd) async {
    final event = PollVoteEvent.fromJson(cmd.payload);
    eventManager.notifyPollVoted(event);
  }

  void _updateSubscribedUnreadCountInfo(UnreadCountInfo? info) {
    if (info == null) return;
    if (sdk.state.unreadCountInfo.ts > info.ts) return;

    final unreadCount = sdk.state.unreadCountInfo;
    if (unreadCount.all != info.all) {
      sdk.streamManager.unread.add(info.all);
    }

    final didChange = unreadCount.copyWith(info);
    if (didChange) {
      eventManager.notifyTotalUnreadMessageCountUpdated(
        unreadCount.all,
        unreadCount.customTypes,
      );
    }
  }

  Future<void> _processLogin(Command cmd) async {
    final event = LoginEvent.fromJson(cmd.payload);

    sdk.webSocket?.setInterval(event.pingInterval);
    sdk.webSocket?.setWatchdogInterval(event.watchdogInterval);

    final user = event.user;
    final wasReconnecting = sdk.state.reconnecting;

    //Update AppInfo in state
    sdk.state
      ..appInfo = event.appInfo
      ..maxUnreadCountOnSuperGroup = event.maxUnreadCountOnSuperGroup
      ..reconnectConfig = event.reconnectConfiguration
      ..reconnectTask = ReconnectTask(event.reconnectConfiguration)
      ..currentUser = user
      ..userId = user.userId
      ..sessionKey = event.sessionKey
      ..lastConnectedAt = event.loginTimestamp
      ..uploadSizeLimit = event.appInfo.uploadSizeLimit
      ..connected = true
      ..connecting = false
      ..reconnecting = false;

    sdk.api.currentUserId = user.userId;
    sdk.api.initialize(uploadSizeLimit: event.appInfo.uploadSizeLimit);

    sdk.sessionManager
      ..setUserId(user.userId)
      ..setEKey(event.ekey)
      ..setSessionKey(event.sessionKey);

    if (wasReconnecting) {
      eventManager.notifyReconnectionSucceeded();

      //enter previously cached open channel
      final channels = sdk.cache.findAll<OpenChannel>();
      channels?.forEach((channel) async {
        channel.enter().then((value) {}).catchError((error) {
          sdk.cache.delete(channelKey: channel.channelUrl);
        });
      });
    }

    sdk.loginCompleter?.complete(user);
  }

  Future<void> _processSessionExpired(Command cmd) async {
    sdk.sessionManager.setSessionKey(null);
    sdk.state.sessionKey = null;
    if (cmd.payload['reason'] == ErrorCode.sessionTokenRevoked) {
      eventManager.notifySessionClosed();
      await sdk.logout();
    }
    // If session token is expired, then log out
    else if (cmd.payload['expires_in'] != null
        ? cmd.payload['expires_in'] < 0
        : false) {
      await sdk.logout();
    } else {
      await sdk.sessionManager.updateSession();
    }
  }

  Future<void> _processNewMessage(Command cmd) async {
    final event = MessageEvent.fromJson(cmd.payload);

    try {
      final message = await parseMessage(cmd);
      if (message == null) throw UnrecognizedMessageTypeError();

      if (event.requestId != null) {
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

      var shouldCallChannelChanged = false;

      if (channel is GroupChannel) {
        if (channel.hiddenState == GroupChannelHiddenState.allowAutoUnhide) {
          channel.isHidden = false;
          channel.hiddenState = GroupChannelHiddenState.unhidden;
        }

        channel.updateMember(event.sender);

        if (channel.shouldUpdateLastMessage(message, message.sender)) {
          shouldCallChannelChanged = true;
          channel.lastMessage = message;
        }

        if (channel.fromCache && channel.updateUnreadCount(message)) {
          shouldCallChannelChanged = true;
        }
      }

      if (event.requestId == null) {
        eventManager.notifyMessageReceived(channel, message);
      }

      final currentUser = appState.currentUser;
      if (message.mentioned(user: currentUser, byOtherUser: message.sender)) {
        eventManager.notifyMentionReceived(channel, message);
      }

      if (shouldCallChannelChanged) {
        eventManager.notifyChannelChanged(channel);
      }
    } catch (e) {
      logger.w('Aborted ${cmd.cmd} ' + e.toString());
    }
  }

  Future<void> _processUpdateMessage(Command cmd) async {
    final event = MessageEvent.fromJson(cmd.payload);

    try {
      final message = await parseMessage(cmd);
      if (message == null) throw UnrecognizedMessageTypeError();

      final currentUser = appState.currentUser;
      if (currentUser == null) return;
      final channel = await BaseChannel.getBaseChannel(
        message.channelType,
        message.channelUrl,
      );

      if (channel is OpenChannel) {
        eventManager.notifyMessageUpdate(channel, message);
      } else if (channel is GroupChannel) {
        var shouldCallChannelChanged = false;
        var shouldCallMentionReceived = false;

        if (channel.shouldUpdateLastMessage(message, message.sender)) {
          shouldCallChannelChanged = true;
          channel.lastMessage = message;
        }

        final timestamp = channel.myReadReceipt();

        if (message.hasUpdatedLaterThan(timestamp) &&
            event.sender?.isCurrentUser == false &&
            !message.isSilent) {
          if (event.hasChangedMentionType() == MentionType.channel &&
              event.previousMentionedContains(currentUser)) {
            if (channel.fromCache) channel.increaseUnreadMentionCount();
            shouldCallChannelChanged = true;
            shouldCallMentionReceived = true;
          } else if (event.hasChangedMentionType() == MentionType.users &&
              !event.previousMentionedContains(currentUser) &&
              event.mentionedContains(currentUser)) {
            if (channel.fromCache) channel.increaseUnreadMentionCount();
            shouldCallChannelChanged = true;
            shouldCallMentionReceived = true;
          }
        }

        eventManager.notifyMessageUpdate(channel, message);

        if (shouldCallMentionReceived) {
          eventManager.notifyMentionReceived(channel, message);
        }

        if (shouldCallChannelChanged) {
          eventManager.notifyChannelChanged(channel);
        }
      }
    } catch (e) {
      logger.w('Aborted ${cmd.cmd} ' + e.toString());
    }
  }

  Future<void> _processDeleteMessage(Command cmd) async {
    final event = MessageEvent.fromJson(cmd.payload);

    try {
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
      );
      eventManager.notifyMessageDeleted(channel, event.messageId);
    } catch (e) {
      logger.w('Aborted ${cmd.cmd} ' + e.toString());
    }
  }

  //only for open channel and broadcast channel
  Future<void> _processMemberCountChange(Command cmd) async {
    final event = MCNTEvent.fromJson(cmd.payload);

    final groupChannels = <GroupChannel>[];
    final openChannels = <OpenChannel>[];

    event.groupChannels.forEach((e) {
      final channel = sdk.cache.find<GroupChannel>(channelKey: e.channelUrl);
      if (channel != null) {
        channel.joinedMemberCount = e.joinedMemberCount;
        channel.memberCount = e.memberCount;
        groupChannels.add(channel);
      }
    });

    event.openChannels.forEach((e) {
      final channel = sdk.cache.find<OpenChannel>(channelKey: e.channelUrl);
      if (channel != null) {
        channel.participantCount = e.participantCount;
        openChannels.add(channel);
      }
    });

    if (groupChannels.isNotEmpty) {
      eventManager.notifyChannelMemberCountChange(groupChannels);
    }
    if (openChannels.isNotEmpty) {
      eventManager.notifyChannelParticiapntCountChanged(openChannels);
    }
  }

  Future<void> _processRead(Command cmd) async {
    try {
      final status = ReadStatus.fromJson(cmd.payload);
      status.saveToCache();

      final channel = await GroupChannel.getChannel(status.channelUrl);

      final isCurrentUser = status.userId == sdk.state.userId;
      final hasUnreadCount =
          (channel.unreadMessageCount > 0 || channel.unreadMentionCount > 0);
      if (isCurrentUser) {
        channel.myLastRead = status.timestamp;
        if (channel.fromCache) channel.clearUnreadCount();
        if (hasUnreadCount) eventManager.notifyChannelChanged(channel);
      } else {
        eventManager.notifyChannelReadReceiptUpdated(channel);
      }
    } catch (e) {
      logger.w('Aborted ${cmd.cmd} ' + e.toString());
    }
  }

  Future<void> _processDelivery(Command cmd) async {
    try {
      final status = DeliveryStatus.fromJson(cmd.payload);

      final channel = await GroupChannel.getChannel(status.channelUrl);
      final currUserId = appState.userId;
      var shouldCallDelivery = true;
      if (status.updatedDeliveryReceipt.length == 1 &&
          status.updatedDeliveryReceipt[currUserId] != null) {
        //not to call
        shouldCallDelivery = false;
      }

      if (shouldCallDelivery) {
        eventManager.notifyDeliveryReceiptUpdated(channel);
      }

      status.saveToCache();
    } catch (e) {
      logger.e('Aborted ${cmd.cmd} ' + e.toString());
    }
  }

  Future<void> _processThread(Command cmd) async {
    try {
      final event = ThreadInfoUpdateEvent.fromJson(cmd.payload);
      final channel = await GroupChannel.getChannel(event.channelUrl);
      eventManager.notifyChannelThreadUpdated(channel, event);
    } catch (e) {
      logger.w('Aborted ${cmd.cmd} ' + e.toString());
    }
  }

  Future<void> _processReaction(Command cmd) async {
    try {
      final event = ReactionEvent.fromJson(cmd.payload);
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
      );
      eventManager.notifyReactionUpdated(channel, event);
    } catch (e) {
      logger.w('Aborted ${cmd.cmd} ' + e.toString());
    }
  }

  Future<void> _processSessionRefresh(Command cmd) async {
    final event = SessionEvent.fromJson(cmd.payload);
    sdk.sessionManager.setSessionKey(event.sessionKey);
    eventManager.notifySessionRefreshed();
  }

  Future<void> _processError(Command cmd) async {
    logger.e('Error ${cmd.cmd} ' + (cmd.errorMessage ?? ''));
    if (cmd.errorCode == ErrorCode.sessionKeyExpired) {
      sdk.sessionManager.setSessionKey(null);
      sdk.state.sessionKey = null;
      sdk.state.reconnecting = false;
      sdk.setForceReconnect = true;
      await sdk.sessionManager.updateSession();
    } else if (cmd.errorCode == ErrorCode.sessionTokenRevoked) {
      sdk.state.reconnecting = false;
      eventManager.notifySessionClosed();
    } else if (cmd.errorCode == ErrorCode.accessTokenNotValid) {
      sdk.state.reconnecting = false;
      eventManager.notifySessionError(InvalidAccessTokenError());
    } else {
      sdk.state.reconnecting = false;
      throw WebSocketError(code: cmd.errorCode, message: cmd.errorMessage);
    }
  }

  // System
  Future<void> _processSystemEvent(Command cmd) async {
    final event = ChannelEvent.fromJson(cmd.payload);

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
      default:
        break;
    }
  }

  Future<void> _processTyping(ChannelEvent event, bool start) async {
    try {
      final user = User.fromJson(event.data);
      final channel = await GroupChannel.getChannel(event.channelUrl);
      final status = TypingStatus(
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
    } catch (e) {
      logger.w('Aborted ${event.category.toString()} ' + e.toString());
    }
  }

  Future<void> _processBan(ChannelEvent event, bool banned) async {
    try {
      final user = banned
          ? RestrictedUser.fromJson(event.data)
          : User.fromJson(event.data);
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
            channel.removeMember(event.user?.userId);
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
      } else {
        eventManager.notifyUserUnbanned(channel, user);
      }
    } catch (e) {
      logger.w('Aborted ${event.category.toString()} ' + e.toString());
    }
  }

  Future<void> _processMute(ChannelEvent event, bool muted) async {
    try {
      final user = muted
          ? RestrictedUser.fromJson(event.data)
          : User.fromJson(event.data);
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
      );
      if (channel is GroupChannel) {
        if (user.isCurrentUser) {
          channel.myMutedState = muted ? MuteState.muted : MuteState.unmuted;
        }

        final member =
            channel.members.firstWhereOrNull((e) => e.userId == user.userId);
        member?.restrictionInfo =
            muted ? RestrictionInfo.fromJson(event.data) : null;
        member?.isMuted = muted;
      }

      if (muted) {
        eventManager.notifyUserMuted(channel, user);
      } else {
        eventManager.notifyUserUnmuted(channel, user);
      }
    } catch (e) {
      logger.w('Aborted ${event.category.toString()} ' + e.toString());
    }
  }

  Future<void> _processChannelJoin(ChannelEvent event, bool joined) async {
    try {
      final channel = await GroupChannel.getChannel(event.channelUrl);
      if (channel.isSuper) {
        channel.updateMemberCounts(event);
      }

      final members = event.joinedMembers;

      if (joined) {
        for (final member in members) {
          if (!channel.isSuper) {
            channel.addMember(member);
          }

          if (member.isCurrentUser) {
            channel.myMemberState = MemberState.joined;
          }
          eventManager.notifyUserJoined(channel, member);
          eventManager.notifyChannelMemberCountChange([channel]);
        }
      } else {
        final member = Member.fromJson(event.data);
        if (!channel.isSuper) {
          channel.removeMember(member.userId);
        }

        channel.updateTypingStatus(member, typing: false);

        if (member.isCurrentUser) {
          channel.myMemberState = MemberState.none;
          channel.invitedAt = 0;
          channel.joinedAt = 0;
          channel.clearUnreadCount();
          if (!channel.isPublic) {
            channel.removeFromCache();
          }
        }
        eventManager.notifyUserLeaved(channel, member);
        eventManager.notifyChannelMemberCountChange([channel]);
      }
    } catch (e) {
      logger.w('Aborted ${event.category.toString()} ' + e.toString());
    }
  }

  Future<void> _processChannelInvite(ChannelEvent event) async {
    try {
      final channel = await GroupChannel.getChannel(event.channelUrl);
      final invitees = event.invitees;
      final inviter = event.inviter;

      if (channel.isSuper) {
        channel.updateMemberCounts(event);
      } else if (inviter != null) {
        channel.addMember(inviter);
      }

      for (final member in invitees) {
        if (!channel.isSuper) {
          channel.addMember(member);
        }

        if (member.isCurrentUser) {
          channel.myMemberState = MemberState.invited;

          if (channel.hiddenState == GroupChannelHiddenState.allowAutoUnhide) {
            channel.isHidden = false;
            channel.hiddenState = GroupChannelHiddenState.unhidden;
          }

          channel.invitedAt = event.invitedAt;
        }
      }

      eventManager.notifyInvitationReceived(
        channel,
        invitees,
        inviter,
      );
    } catch (e) {
      logger.w('Aborted ${event.category.toString()} ' + e.toString());
    }
  }

  Future<void> _processChannelDeclineInvitation(ChannelEvent event) async {
    try {
      final channel = await GroupChannel.getChannel(event.channelUrl);
      if (channel.isSuper) {
        channel.updateMemberCounts(event);
      } else {
        channel.removeMember(event.invitee?.userId);
      }

      if (event.invitee?.isCurrentUser == true) {
        channel.myMemberState = MemberState.none;
        channel.invitedAt = 0;

        if (!channel.isPublic) {
          channel.removeFromCache();
        }
      }

      eventManager.notifyInvitationDeclied(
        channel,
        event.invitee!,
        event.inviter,
      );
    } catch (e) {
      logger.w('Aborted ${event.category.toString()} ' + e.toString());
    }
  }

  Future<void> _processChannelEnter(ChannelEvent event, bool entered) async {
    try {
      final channel = await OpenChannel.getChannel(event.channelUrl);
      final user = event.user;
      if (user == null) throw MalformedError();

      channel.participantCount = event.participantCount;

      if (entered) {
        eventManager.notifyUserEntered(channel, user);
        eventManager.notifyChannelParticiapntCountChanged([channel]);
      } else {
        eventManager.notifyUserExited(channel, user);
        eventManager.notifyChannelParticiapntCountChanged([channel]);
      }
    } catch (e) {
      logger.w('Aborted ${event.category.toString()} ' + e.toString());
    }
  }

  Future<void> _processChannelFrozen(ChannelEvent event, bool frozen) async {
    try {
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
      );
      channel.isFrozen = frozen;

      if (frozen) {
        eventManager.notifyChannelFrozen(channel);
      } else {
        eventManager.notifyChannelUnfrozen(channel);
      }
    } catch (e) {
      logger.w('Aborted ${event.category.toString()} ' + e.toString());
    }
  }

  Future<void> _processChannelHidden(
    ChannelEvent event,
    int? messageOffset,
    bool hidden,
  ) async {
    try {
      final channel = await GroupChannel.getChannel(event.channelUrl);
      if (hidden) {
        channel.messageOffsetTimestamp = messageOffset;

        if (event.hidePreviousMessage) {
          channel.clearUnreadCount();
        }
      }

      channel.isHidden = hidden;
      channel.hiddenState = event.hiddenState;

      if (hidden) {
        eventManager.notifyChannelHidden(channel);
      } else {
        eventManager.notifyChannelChanged(channel);
      }
    } catch (e) {
      logger.w('Aborted ${event.category.toString()} ' + e.toString());
    }
  }

  Future<void> _processChannelMetaData(ChannelEvent event) async {
    try {
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
      );

      final cachedMetaData =
          sdk.cache.find<CachedDataMap<String>>(channelKey: event.channelUrl) ??
              CachedDataMap(
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
      cachedMetaData.saveToCache();

      eventManager.notifyMetaDataChanged(channel, event.data);
    } catch (e) {
      logger.w('Aborted ${event.category.toString()} ' + e.toString());
    }
  }

  Future<void> _processChannelMetaCounter(ChannelEvent event) async {
    try {
      final channel = await BaseChannel.getBaseChannel(
        event.channelType,
        event.channelUrl,
      );
      eventManager.notifyMetaCountersChanged(channel, event.data);
    } catch (e) {
      logger.e('Aborted ${event.category.toString()} ' + e.toString());
    }
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
    } catch (e) {
      logger.w('Aborted ${event.category.toString()} ' + e.toString());
    }
  }

  Future<void> _processChannelPropChanged(ChannelEvent event) async {
    try {
      final channel = await BaseChannel.refreshChannel(
        event.channelType,
        event.channelUrl,
      );
      if (channel is GroupChannel) {
        if (!channel.canChangeUnreadMessageCount) {
          channel.unreadMessageCount = 0;
        }
        if (!channel.canChangeUnreadMentionCount) {
          channel.unreadMentionCount = 0;
        }
      }
      channel.saveToCache();
      eventManager.notifyChannelChanged(channel);
    } catch (e) {
      logger.w('Aborted ${event.category.toString()} ' + e.toString());
    }
  }

  Future<void> _processChannelDelete(ChannelEvent event) async {
    sdk.cache.delete(channelKey: event.channelUrl);
    eventManager.notifyChannelDeleted(
      event.channelUrl,
      event.channelType,
    );
  }

  Future<void> _processUserEvent(Command cmd) async {
    final event = UserEvent.fromJson(cmd.payload);
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
    channels?.forEach((e) => e.setBlockedByMe(
          targetId: event.blockee.userId,
          blocked: true,
        ));
  }

  void _processUnblock(UserEvent event) {
    final sdk = SendbirdSdk().getInternal();
    final channels = sdk.cache.findAll<GroupChannel>();
    channels?.forEach((e) => e.setBlockedByMe(
          targetId: event.blockee.userId,
          blocked: false,
        ));
  }

  void _processFriendDiscovery(UserEvent event) {
    // CallbackProcessor.shared().notifyDiscoveredFriend(event.friendDiscoveries);
  }
}
