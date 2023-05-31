// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat/src/public/main/model/chat/emoji.dart';

class EmojiGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  EmojiGetRequest(
    Chat chat,
    String key,
  ) : super(chat: chat) {
    url = 'emojis/$key';
  }

  @override
  Future<Emoji> response(Map<String, dynamic> res) async {
    return Emoji.fromJson(res);
  }
}
