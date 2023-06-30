// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';

/// Notification collection that handles message lists.
/// @since 4.0.3
class NotificationCollection extends BaseMessageCollection {
  /// The [FeedChannel] tracked by this [NotificationCollection].
  /// @since 4.0.3
  FeedChannel get channel => baseChannel as FeedChannel;

  /// The notification collection handler to be used for this [NotificationCollection].
  /// @since 4.0.3
  NotificationCollectionHandler get handler =>
      baseHandler as NotificationCollectionHandler;

  /// Constructor for NotificationCollection.
  ///
  /// [startingPoint] is the reference point for message retrieval in a chat view.
  /// This should be specified as a timestamp(ms) and the default value is max.
  /// @since 4.0.3
  NotificationCollection({
    required FeedChannel channel,
    required MessageListParams params,
    required NotificationCollectionHandler handler,
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
