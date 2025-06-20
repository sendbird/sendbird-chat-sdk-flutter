// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/main/collection/collection_event_source.dart';
import 'package:sendbird_chat_sdk/src/public/main/collection/group_channel_collection/base_channel_context.dart';
import 'package:sendbird_chat_sdk/src/public/main/collection/group_channel_collection/group_channel_collection_handler.dart';

/// The context of a group channel, used in [GroupChannelCollectionHandler].
class GroupChannelContext extends BaseChannelContext {
  GroupChannelContext({
    required CollectionEventSource collectionEventSource,
    dynamic eventDetail,
  }) : super(
          collectionEventSource: collectionEventSource,
          eventDetail: eventDetail,
        );
}
