// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/main/collection/group_channel_collection/group_channel_context.dart';
import 'package:sendbird_chat_sdk/src/public/main/collection/group_channel_collection/group_channel_collection.dart';

/// An interface used in [GroupChannelCollection].
abstract class GroupChannelCollectionHandler {
  /// Called when there are newly added [GroupChannel]s.
  ///
  /// [context] is a [GroupChannelContext] of where this change happened.
  /// [channels] are affected [GroupChannel] lists.
  void onChannelsAdded(
    GroupChannelContext context,
    List<GroupChannel> channels,
  );

  /// Called when there's an update in one or more of the [GroupChannel]s the
  /// [GroupChannelCollection] holds.
  ///
  /// [context] is a [GroupChannelContext] of where this change happened.
  /// [channels] are affected [GroupChannel] lists.
  void onChannelsUpdated(
    GroupChannelContext context,
    List<GroupChannel> channels,
  );

  /// Called when one or more of the [GroupChannel]s the [GroupChannelCollection]
  /// holds has been deleted.
  ///
  /// [context] is a [GroupChannelContext] of where this deletion happened.
  /// [deletedChannelUrls] are deleted [GroupChannel]'s url lists.
  void onChannelsDeleted(
    GroupChannelContext context,
    List<String> deletedChannelUrls,
  );
}
