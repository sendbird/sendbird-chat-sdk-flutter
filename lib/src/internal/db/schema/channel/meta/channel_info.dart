// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

class ChannelInfo {
  String? lastChannelToken;
  bool isChannelBackSyncCompleted;

  ChannelInfo({
    this.lastChannelToken,
    this.isChannelBackSyncCompleted = false,
  });
}
