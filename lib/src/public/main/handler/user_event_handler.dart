// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/public/core/user/user.dart';
import 'package:sendbird_chat/src/public/main/chat/sendbird_chat.dart';

/// User event handler.
/// To add or remove this handler,
/// refer to [SendbirdChat.addUserEventHandler] and [SendbirdChat.removeUserEventHandler].
abstract class UserEventHandler {
  /// The friends discovered event.
  void onFriendsDiscovered(List<User> friends);

  /// Gets the subscribed total number of unread message of all `GroupChannel`s the current user has joined,
  /// and number of unread message of `GroupChannel` for all subscribed custom type.
  void onTotalUnreadMessageCountUpdated(
    int totalCount,
    Map<String, int> customTypesCount,
  ) {}
}
