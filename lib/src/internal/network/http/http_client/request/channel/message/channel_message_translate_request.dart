// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat/src/public/core/message/user_message.dart';
import 'package:sendbird_chat/src/public/main/define/enums.dart';

class ChannelMessageTranslateRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  ChannelMessageTranslateRequest(
    Chat chat, {
    required ChannelType channelType,
    required String channelUrl,
    required int messageId,
    required List<String> targetLanguages,
  }) : super(chat: chat) {
    url =
        '${channelType.urlString}/$channelUrl/messages/$messageId/translation';
    body = {'target_langs': targetLanguages};
  }

  @override
  Future<UserMessage> response(Map<String, dynamic> res) async {
    return UserMessage.fromJsonWithChat(chat, res);
  }
}
