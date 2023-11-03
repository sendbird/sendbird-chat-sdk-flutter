// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
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
          startingPoint: startingPoint ?? IntMax.max,
          chat: chat ?? SendbirdChat().chat,
        ) {
    sbLog.i(StackTrace.current, 'MessageCollection()');
  }
}
