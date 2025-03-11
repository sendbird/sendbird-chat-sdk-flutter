// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'group_channel.dart';

/// GroupChannelOperation
extension GroupChannelOperation on GroupChannel {
  /// Invites `User`s top this channel.
  Future<void> invite(List<String> userIds) async {
    sbLog.i(StackTrace.current, 'userIds: $userIds');

    if (userIds.isEmpty) {
      throw InvalidParameterException();
    }

    await chat.apiClient.send(GroupChannelInviteRequest(
      chat,
      userIds: userIds,
      channelUrl: channelUrl,
    ));
  }

  /// Accepts the invitation sent to the current `User`.
  /// After the acceptance, the `User` will be joined to this `GroupChannel`.
  Future<void> acceptInvitation({String? accessCode}) async {
    sbLog.i(StackTrace.current, 'accessCode: $accessCode');

    await chat.apiClient.send(GroupChannelInvitationAcceptRequest(
      chat,
      channelUrl: channelUrl,
      accessCode: accessCode,
    ));
  }

  /// Declines the invitation sent to the current `User`.
  Future<void> declineInvitation() async {
    sbLog.i(StackTrace.current);

    await chat.apiClient.send(
        GroupChannelInvitationDeclineRequest(chat, channelUrl: channelUrl));
  }

  /// Joins this channel if this channel is public.
  Future<void> join({String? accessCode}) async {
    sbLog.i(StackTrace.current, 'accessCode: $accessCode');

    await chat.apiClient.send(GroupChannelJoinRequest(
      chat,
      channelUrl: channelUrl,
      accessCode: accessCode,
    ));
  }

  /// Leaves this channel.
  /// Set [shouldRemoveOperatorStatus] to true if you want to remove the operator status.
  Future<void> leave({bool? shouldRemoveOperatorStatus}) async {
    sbLog.i(StackTrace.current);

    await chat.apiClient.send(GroupChannelLeaveRequest(
      chat,
      channelUrl: channelUrl,
      shouldRemoveOperatorStatus: shouldRemoveOperatorStatus,
    ));
    invitedAt = 0;
    joinedAt = 0;
  }

  /// Resets the chat history of this channel for the current User.
  /// After this call, the messages created before the call will not be loaded.
  Future<void> resetMyHistory() async {
    sbLog.i(StackTrace.current);

    if (chat.commandManager.messageOffsetTsCompleterMap[channelUrl] != null) {
      return;
    }
    chat.commandManager.messageOffsetTsCompleterMap[channelUrl] =
        Completer<int?>();

    try {
      bool isOffsetChanged = false;

      final offset = await chat.apiClient
          .send(GroupChannelHistoryResetRequest(chat, channelUrl: channelUrl));

      if (offset != null && offset != messageOffsetTimestamp) {
        messageOffsetTimestamp = offset;
        isOffsetChanged = true;

        if (lastMessage?.message != null) {
          if (lastMessage!.createdAt <= messageOffsetTimestamp!) {
            lastMessage = null;
          }
        }

        saveToCache(chat);

        //+ [DBManager]
        if (chat.dbManager.isEnabled()) {
          await chat.dbManager.upsertGroupChannels([this]);
        }
        //- [DBManager]
      }

      if (isOffsetChanged) {
        await chat.collectionManager.updateMessageOffset(
          channelUrl: channelUrl,
          messageOffset: messageOffsetTimestamp!,
        );
      }
    } catch (_) {
      rethrow;
    } finally {
      if (chat.commandManager.messageOffsetTsCompleterMap[channelUrl] != null) {
        chat.commandManager.messageOffsetTsCompleterMap[channelUrl]!
            .complete(messageOffsetTimestamp);
        chat.commandManager.messageOffsetTsCompleterMap.remove(channelUrl);
      }
    }
  }
}
