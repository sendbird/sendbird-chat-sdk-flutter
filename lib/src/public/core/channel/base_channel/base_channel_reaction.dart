// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'base_channel.dart';

/// BaseChannelReactions
extension BaseChannelReactions on BaseChannel {
  /// Adds `Reaction`.
  Future<ReactionEvent> addReaction(BaseMessage message, String key) async {
    sbLog.i(StackTrace.current, 'messageId: ${message.messageId}, key: $key');

    if (message.channelUrl != channelUrl) {
      throw InvalidParameterException();
    }

    if (key.isEmpty) {
      throw InvalidParameterException();
    }

    final res = await chat.apiClient.send<ReactionEvent>(
      ChannelReactionAddRequest(
        chat,
        channelType: message.channelType,
        channelUrl: message.channelUrl,
        messageId: message.messageId,
        key: key,
      ),
    );

    res.messageId = message.messageId;
    return res;
  }

  /// Deletes `Reaction`.
  Future<ReactionEvent> deleteReaction(BaseMessage message, String key) async {
    sbLog.i(StackTrace.current, 'messageId: ${message.messageId}, key: $key');

    if (message.channelUrl != channelUrl) {
      throw InvalidParameterException();
    }

    if (key.isEmpty) {
      throw InvalidParameterException();
    }

    final res = await chat.apiClient.send<ReactionEvent>(
      ChannelReactionDeleteRequest(
        chat,
        channelType: message.channelType,
        channelUrl: message.channelUrl,
        messageId: message.messageId,
        key: key,
      ),
    );

    res.messageId = message.messageId;
    return res;
  }
}
