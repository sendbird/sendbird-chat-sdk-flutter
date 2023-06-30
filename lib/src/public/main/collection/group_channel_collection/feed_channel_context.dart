// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/main/collection/collection_event_source.dart';
import 'package:sendbird_chat_sdk/src/public/main/collection/group_channel_collection/base_channel_context.dart';
import 'package:sendbird_chat_sdk/src/public/main/collection/group_channel_message_collection/notification_collection_handler.dart';

/// The context of a feed channel, used in [NotificationCollectionHandler].
/// @since 4.0.3
class FeedChannelContext extends BaseChannelContext {
  /// Constructor
  /// @since 4.0.3
  FeedChannelContext(CollectionEventSource collectionEventSource)
      : super(collectionEventSource);
}
