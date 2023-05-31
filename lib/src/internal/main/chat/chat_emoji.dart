// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'chat.dart';

extension ChatEmoji on Chat {
  Future<EmojiContainer> getAllEmoji() async {
    sbLog.i(StackTrace.current);
    return await apiClient.send<EmojiContainer>(EmojiContainerGetRequest(this));
  }

  Future<Emoji> getEmoji(String key) async {
    sbLog.i(StackTrace.current);

    if (key.isEmpty) throw InvalidParameterException();
    return await apiClient.send<Emoji>(EmojiGetRequest(this, key));
  }

  Future<EmojiCategory> getEmojiCategory(int categoryId) async {
    sbLog.i(StackTrace.current);

    if (categoryId <= 0) throw InvalidParameterException();
    return await apiClient
        .send<EmojiCategory>(EmojiCategoryGetRequest(this, categoryId));
  }
}
