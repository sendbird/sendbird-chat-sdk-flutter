// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/chat/emoji.dart';

class EmojiContainerGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  EmojiContainerGetRequest(
    Chat chat,
  ) : super(chat: chat) {
    url = 'emoji_categories';
  }

  @override
  Future<EmojiContainer> response(Map<String, dynamic> res) async {
    return EmojiContainer.fromJson(res);
  }
}
