// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/core/channel/feed_channel/feed_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/unread_message_count.dart';

/// User event handler.
/// To add or remove this handler,
/// refer to [SendbirdChat.addUserEventHandler] and [SendbirdChat.removeUserEventHandler].
abstract class UserEventHandler {
  /// The friends discovered event.
  void onFriendsDiscovered(List<User> friends);

  /// Gets the subscribed total number of unread message of all [GroupChannel]s and [FeedChannel]s the current user has joined,
  /// and number of unread message of [GroupChannel] for all subscribed custom type.
  /// @since 4.0.3
  void onTotalUnreadMessageCountChanged(
    UnreadMessageCount unreadMessageCount,
  ) {}
}
