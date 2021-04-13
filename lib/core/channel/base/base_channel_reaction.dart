part of 'base_channel.dart';

/// Set of functionality related to reaction feature
extension Reactions on BaseChannel {
  /// Adds reaction [key] to given [message]
  ///
  /// [ChannelEventHandler.onReactionUpdated] callback will be invoked with
  /// event after completion, and you should apply the event to the message by
  /// calling [BaseMessage.applyReactionEvent]
  Future<ReactionEvent> addReaction(BaseMessage message, String key) async {
    if (message == null || message.channelUrl != channelUrl) {
      throw InvalidParameterError();
    }

    if (key == null || key.isEmpty) {
      throw InvalidParameterError();
    }

    final res = await _sdk.api.addReaction(
      channelType: message.channelType,
      channelUrl: message.channelUrl,
      messageId: message.messageId,
      key: key,
    );

    res.messageId = message.messageId;
    return res;
  }

  /// Deletes reaction [key] from [message]
  ///
  /// [ChannelEventHandler.onReactionUpdated] callback will be invoked with
  /// event after completion, and you should apply the event to the message by
  /// calling [BaseMessage.applyReactionEvent]
  Future<ReactionEvent> deleteReaction(BaseMessage message, String key) async {
    if (message == null || message.channelUrl != channelUrl) {
      throw InvalidParameterError();
    }

    if (key == null || key.isEmpty) {
      throw InvalidParameterError();
    }

    final res = await _sdk.api.deleteReaction(
      channelType: message.channelType,
      channelUrl: message.channelUrl,
      messageId: message.messageId,
      key: key,
    );

    res.messageId = message.messageId;
    return res;
  }
}
