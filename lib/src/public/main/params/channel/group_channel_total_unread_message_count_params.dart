// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

/// Represents a group channel total unread message count params.
class GroupChannelTotalUnreadMessageCountParams {
  /// The channel custom types.
  List<String> channelCustomTypes = [];

  /// The super channel filter.
  SuperChannelFilter superChannelFilter = SuperChannelFilter.all;
}
