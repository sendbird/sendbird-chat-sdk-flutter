// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/main/collection/collection_event_source.dart';
import 'package:sendbird_chat_sdk/src/public/main/collection/group_channel_message_collection/base_message_context.dart';
import 'package:sendbird_chat_sdk/src/public/main/collection/group_channel_message_collection/message_collection_handler.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

/// The context of a message, used in [MessageCollectionHandler].
class MessageContext extends BaseMessageContext {
  MessageContext(
      CollectionEventSource collectionEventSource, SendingStatus sendingStatus)
      : super(collectionEventSource, sendingStatus);
}
