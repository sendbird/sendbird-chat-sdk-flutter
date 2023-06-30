// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';

/// The UnreadMessageCount class for [SendbirdChat.getTotalUnreadMessageCount].
/// @since 4.0.3
class UnreadMessageCount {
  /// The total count of unread message count in all of group channels.
  final int totalCountForGroupChannels;

  /// The total count of unread message count in all of feed channels.
  final int totalCountForFeedChannels;

  /// Gets the number of unread message with subscribed custom type.
  Map<String, int> totalCountByCustomType;

  UnreadMessageCount({
    required this.totalCountForGroupChannels,
    required this.totalCountForFeedChannels,
    required this.totalCountByCustomType,
  });
}
