// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/chat/emoji.dart';

class EmojiCategoryGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  EmojiCategoryGetRequest(
    Chat chat,
    int categoryId,
  ) : super(chat: chat) {
    url = 'emoji_categories/$categoryId';
  }

  @override
  Future<EmojiCategory> response(Map<String, dynamic> res) async {
    return EmojiCategory.fromJson(res);
  }
}
