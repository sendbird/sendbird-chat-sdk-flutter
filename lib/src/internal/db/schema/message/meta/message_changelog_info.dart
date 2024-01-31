// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

class MessageChangeLogInfo {
  final String channelUrl;
  final String? lastMessageToken;
  final String? lastPollToken;

  MessageChangeLogInfo({
    required this.channelUrl,
    this.lastMessageToken,
    this.lastPollToken,
  });
}
