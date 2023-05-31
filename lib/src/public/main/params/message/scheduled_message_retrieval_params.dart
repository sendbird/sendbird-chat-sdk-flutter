// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

/// Represents a params for retrieving a single scheduled message.
class ScheduledMessageRetrievalParams {
  /// The channel url.
  final String channelUrl;

  /// The scheduled message ID.
  final int scheduledMessageId;

  ScheduledMessageRetrievalParams({
    required this.channelUrl,
    required this.scheduledMessageId,
  });
}
