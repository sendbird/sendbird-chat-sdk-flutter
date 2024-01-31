// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'chat.dart';

extension ChatCaching on Chat {
  Future<int?> getCachedDataSize() async {
    return await dbManager.getDBFileSize();
  }

  Future<void> clearCachedData() async {
    await dbManager.clear();
  }

  Future<void> clearCachedMessages(String channelUrl) async {
    await dbManager.deleteGroupChannels([channelUrl]);
    await dbManager.deleteFeedChannels([channelUrl]);
  }
}
