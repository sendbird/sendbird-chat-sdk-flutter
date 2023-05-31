// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/public/main/collection/collection_event_source.dart';
import 'package:sendbird_chat/src/public/main/collection/group_channel_collection/group_channel_collection_handler.dart';

/// The context of a channel, used in [GroupChannelCollectionHandler].
class GroupChannelContext {
  final CollectionEventSource _collectionEventSource;

  /// The [CollectionEventSource] of current context.
  CollectionEventSource get collectionEventSource => _collectionEventSource;

  GroupChannelContext(CollectionEventSource collectionEventSource)
      : _collectionEventSource = collectionEventSource;
}
