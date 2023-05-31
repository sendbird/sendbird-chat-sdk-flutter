// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'open_channel.dart';

/// OpenChannelOperation
extension OpenChannelOperation on OpenChannel {
  /// Enters this channel.
  /// The current `User` becomes a participant of this channel.
  Future<void> enter() async {
    sbLog.i(StackTrace.current);

    final cmd = Command.buildEnterChannel(this);
    final result = await chat.commandManager.sendCommand(cmd);
    participantCount = result?.payload['participant_count'];

    chat.chatContext.enteredOpenChannelUrls.add(channelUrl);
    sbLog.i(
      StackTrace.current,
      '[add()] enteredOpenChannels: ${chat.chatContext.enteredOpenChannelUrls.length}',
    );
  }

  /// Exits from this channel.
  /// The current `User` is no longer a participant of this channel.
  Future<void> exit() async {
    sbLog.i(StackTrace.current);

    final cmd = Command.buildExitChannel(this);
    final result = await chat.commandManager.sendCommand(cmd);
    participantCount = result?.payload['participant_count'] ?? 0;

    removeFromCache(chat);
    chat.chatContext.enteredOpenChannelUrls.remove(channelUrl);
    sbLog.i(
      StackTrace.current,
      '[remove()] enteredOpenChannels: ${chat.chatContext.enteredOpenChannelUrls.length}',
    );
  }
}
