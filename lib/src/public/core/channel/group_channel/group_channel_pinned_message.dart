// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'group_channel.dart';

/// GroupChannelPinnedMessage
extension GroupChannelPinnedMessage on GroupChannel {
  /// Pins a message to the channel.
  /// [messageId] is id of a message to pin.
  Future<void> pinMessage(int messageId) async {
    if (messageId <= 0) throw InvalidParameterException();

    sbLog.i(StackTrace.current, 'messageId: $messageId');

    await chat.apiClient.send(
      PinCreateRequest(
        chat,
        channelType: ChannelType.group,
        channelUrl: channelUrl,
        messageId: messageId,
      ),
    );
  }

  /// Removes the message from the channel's pinned messages.
  /// [messageId] is id of a message to unpin.
  Future<void> unpinMessage(int messageId) async {
    if (messageId <= 0) throw InvalidParameterException();

    sbLog.i(StackTrace.current, 'messageId: $messageId');

    await chat.apiClient.send(
      PinDeleteRequest(
        chat,
        channelType: ChannelType.group,
        channelUrl: channelUrl,
        messageId: messageId,
      ),
    );
  }
}
