// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/core/channel/feed_channel/feed_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/collection/group_channel_collection/feed_channel_context.dart';
import 'package:sendbird_chat_sdk/src/public/main/collection/group_channel_message_collection/base_message_collection_handler.dart';
import 'package:sendbird_chat_sdk/src/public/main/collection/group_channel_message_collection/message_collection.dart';
import 'package:sendbird_chat_sdk/src/public/main/collection/group_channel_message_collection/notification_collection.dart';
import 'package:sendbird_chat_sdk/src/public/main/collection/group_channel_message_collection/notification_context.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

/// A handler used in [NotificationCollection].
/// @since 4.0.3
abstract class NotificationCollectionHandler
    extends BaseMessageCollectionHandler {
  /// Called when one or more [BaseMessage] is added to this collection.
  ///
  /// [context] is a context of where this addition happened.
  /// [channel] is a channel this collection holds.
  /// [messages] are list of [BaseMessage] that have been added. All messages will have the same [SendingStatus].
  /// @since 4.0.3
  void onMessagesAdded(
    NotificationContext context,
    FeedChannel channel,
    List<BaseMessage> messages,
  );

  /// Called when one or more [BaseMessage] is update in this collection.
  ///
  /// [context] is a context of where this update happened.
  /// [channel] is a channel this collection holds.
  /// [messages] are list of [BaseMessage] that have been updated. All messages will have the same [SendingStatus].
  /// @since 4.0.3
  void onMessagesUpdated(
    NotificationContext context,
    FeedChannel channel,
    List<BaseMessage> messages,
  );

  /// Called when one or more [BaseMessage] is deleted from this collection.
  ///
  /// [context] is a context of where this deletion happened.
  /// [channel] is a channel this collection holds.
  /// [messages] are list of [BaseMessage] that have been deleted. All messages will have the same [SendingStatus].
  /// @since 4.0.3
  void onMessagesDeleted(
    NotificationContext context,
    FeedChannel channel,
    List<BaseMessage> messages,
  );

  /// Called when there's a change in the channel this collection holds.
  ///
  /// [context] is a channel context of where the change in channel happened.
  /// [channel] is a channel this collection holds.
  /// @since 4.0.3
  void onChannelUpdated(
    FeedChannelContext context,
    FeedChannel channel,
  );

  /// Called when the channel this collection holds is deleted.
  ///
  /// [context] is a channel context of where the change in channel happened.
  /// [deletedChannelUrl] isUrl a channel URL of this channel which has been deleted.
  /// @since 4.0.3
  void onChannelDeleted(
    FeedChannelContext context,
    String deletedChannelUrl,
  );

  /// Called when the collection has detected a huge gap between current message list.
  /// When this called, you should call [MessageCollection.dispose] to remove current collection and create a new collection.
  /// @since 4.0.3
  void onHugeGapDetected();
}
