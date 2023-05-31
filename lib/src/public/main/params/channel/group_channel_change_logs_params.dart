// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';

/// Represents a group channel change logs params.
class GroupChannelChangeLogsParams {
  /// [GroupChannel] custom types filter.
  /// If this is null, the changelogs of all channels will be returned.
  List<String> customTypes = [];

  /// Determines whether to include empty channels or not (channels without messages).
  /// Defaults to true.
  bool includeEmpty = true;

  /// Determines whether to include frozen channels or not.
  /// Defaults to true.
  bool includeFrozen = true;

  Map<String, dynamic> toJson() {
    return {
      'custom_type': customTypes,
      'show_empty': includeEmpty,
      'show_frozen': includeFrozen,
    };
  }
}
