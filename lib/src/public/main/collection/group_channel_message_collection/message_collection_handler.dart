// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/collection/group_channel_collection/group_channel_context.dart';
import 'package:sendbird_chat_sdk/src/public/main/collection/group_channel_message_collection/message_collection.dart';
import 'package:sendbird_chat_sdk/src/public/main/collection/group_channel_message_collection/message_context.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

/// An interface used in [MessageCollection].
abstract class MessageCollectionHandler {
  /// Called when one or more [BaseMessage] is added to this collection.
  ///
  /// [context] is a context of where this addition happened.
  /// [channel] is a channel this collection holds.
  /// [messages] are list of [BaseMessage] that have been added. All messages will have the same [SendingStatus].
  void onMessagesAdded(
    MessageContext context,
    GroupChannel channel,
    List<BaseMessage> messages,
  );

  /// Called when one or more [BaseMessage] is update in this collection.
  ///
  /// [context] is a context of where this update happened.
  /// [channel] is a channel this collection holds.
  /// [messages] are list of [BaseMessage] that have been updated. All messages will have the same [SendingStatus].
  void onMessagesUpdated(
    MessageContext context,
    GroupChannel channel,
    List<BaseMessage> messages,
  );

  /// Called when one or more [BaseMessage] is deleted from this collection.
  ///
  /// [context] is a context of where this deletion happened.
  /// [channel] is a channel this collection holds.
  /// [messages] are list of [BaseMessage] that have been deleted. All messages will have the same [SendingStatus].
  void onMessagesDeleted(
    MessageContext context,
    GroupChannel channel,
    List<BaseMessage> messages,
  );

  /// Called when there's a change in the channel this collection holds.
  ///
  /// [context] is a channel context of where the change in channel happened.
  /// [channel] is a channel this collection holds.
  void onChannelUpdated(
    GroupChannelContext context,
    GroupChannel channel,
  );

  /// Called when the channel this collection holds is deleted.
  ///
  /// [context] is a channel context of where the change in channel happened.
  /// [deletedChannelUrl] isUrl a channel URL of this channel which has been deleted.
  void onChannelDeleted(
    GroupChannelContext context,
    String deletedChannelUrl,
  );

  /// Called when the collection has detected a huge gap between current message list.
  /// When this called, you should call [MessageCollection.dispose] to remove current collection and create a new collection.
  void onHugeGapDetected();
}
