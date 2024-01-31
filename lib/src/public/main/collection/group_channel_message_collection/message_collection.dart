// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';

/// Message collection that handles message lists.
class MessageCollection extends BaseMessageCollection {
  /// The list of succeeded message list in this collection.
  @override
  final List<BaseMessage> messageList = [];

  /// The [GroupChannel] tracked by this [MessageCollection].
  GroupChannel get channel => baseChannel as GroupChannel;

  /// The message collection handler to be used for this [MessageCollection].
  MessageCollectionHandler get handler =>
      baseHandler as MessageCollectionHandler;

  /// Constructor for MessageCollection.
  ///
  /// [startingPoint] is the reference point for message retrieval in a chat view.
  /// This should be specified as a timestamp(ms) and the default value is max.
  MessageCollection({
    required GroupChannel channel,
    required MessageListParams params,
    required MessageCollectionHandler handler,
    int? startingPoint,
    Chat? chat,
  }) : super(
          channel: channel,
          params: params,
          handler: handler,
          startingPoint: startingPoint ?? SendbirdChat.maxInt,
          chat: chat ?? SendbirdChat().chat,
        ) {
    sbLog.i(StackTrace.current, 'MessageCollection()');

    //+ [DBManager]
    super.chat.dbManager.appendLocalCacheStat(
          useLocalCache: super.chat.chatContext.options.useCollectionCaching,
          useMessageCollection: true,
        );
    //- [DBManager]
  }

  /// Gets all failed messages of this MessageCollection
  /// @since 4.2.0
  Future<List<BaseMessage>> getFailedMessages() async {
    sbLog.i(StackTrace.current, 'getFailedMessages()');
    return await chat.dbManager.getFailedMessages(
      channelType: ChannelType.group,
      channelUrl: channel.channelUrl,
    );
  }

  /// Removes specific failed messages of this MessageCollection.
  /// @since 4.2.0
  Future<void> removeFailedMessages({
    required List<BaseMessage> messages,
  }) async {
    sbLog.i(StackTrace.current, 'removeFailedMessages()');
    await chat.dbManager.removeFailedMessages(
      channelType: ChannelType.group,
      channelUrl: channel.channelUrl,
      messages: messages,
    );
  }

  /// Removes all failed messages of this MessageCollection.
  /// @since 4.2.0
  Future<void> removeAllFailedMessages() async {
    sbLog.i(StackTrace.current, 'removeAllFailedMessages()');
    await chat.dbManager.removeAllFailedMessages(
      channelType: ChannelType.group,
      channelUrl: channel.channelUrl,
    );
  }
}
