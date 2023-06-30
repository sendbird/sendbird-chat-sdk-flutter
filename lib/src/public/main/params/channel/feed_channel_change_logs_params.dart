// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

/// Represents a feed channel change logs params.
/// @since 4.0.3
class FeedChannelChangeLogsParams {
  /// Determines whether to include empty channels or not (channels without messages).
  /// Defaults to true.
  /// @since 4.0.3
  bool includeEmpty = true;

  Map<String, dynamic> toJson() {
    return {
      'show_empty': includeEmpty,
    };
  }
}
