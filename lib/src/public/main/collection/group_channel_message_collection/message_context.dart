// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/public/main/collection/collection_event_source.dart';
import 'package:sendbird_chat/src/public/main/collection/group_channel_message_collection/message_collection_handler.dart';
import 'package:sendbird_chat/src/public/main/define/enums.dart';

/// The context of a message, used in [MessageCollectionHandler].
class MessageContext {
  final CollectionEventSource _collectionEventSource;
  final SendingStatus _sendingStatus; // TODO: Remove (?)

  /// The [CollectionEventSource] of current context.
  CollectionEventSource get collectionEventSource => _collectionEventSource;

  /// The [sendingStatus] of the messages that's sent out from [MessageCollectionHandler] with this context.
  SendingStatus get sendingStatus => _sendingStatus;

  MessageContext(
      CollectionEventSource collectionEventSource, SendingStatus sendingStatus)
      : _collectionEventSource = collectionEventSource,
        _sendingStatus = sendingStatus;
}
