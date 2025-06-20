// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/main/collection/collection_event_source.dart';

/// The context of a base channel.
/// @since 4.0.3
class BaseChannelContext {
  final CollectionEventSource _collectionEventSource;
  final dynamic _eventDetail;

  /// The [CollectionEventSource] of current context.
  CollectionEventSource get collectionEventSource => _collectionEventSource;

  /// The detail of the event, which can be any type.
  /// @since 4.4.0
  dynamic get eventDetail => _eventDetail;

  BaseChannelContext({
    required CollectionEventSource collectionEventSource,
    dynamic eventDetail,
  })  : _collectionEventSource = collectionEventSource,
        _eventDetail = eventDetail;
}
