// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/main/collection/collection_event_source.dart';

/// The context of a base channel.
/// @since 4.0.3
class BaseChannelContext {
  final CollectionEventSource _collectionEventSource;

  /// The [CollectionEventSource] of current context.
  CollectionEventSource get collectionEventSource => _collectionEventSource;

  BaseChannelContext(CollectionEventSource collectionEventSource)
      : _collectionEventSource = collectionEventSource;
}
