// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

class MessageChangeLogInfo {
  final String channelUrl;
  String? lastMessageToken;
  String? lastPollToken;

  MessageChangeLogInfo({
    required this.channelUrl,
    this.lastMessageToken,
    this.lastPollToken,
  });
}
