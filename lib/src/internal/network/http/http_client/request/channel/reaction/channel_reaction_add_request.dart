// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/reaction/reaction_event.dart';

class ChannelReactionAddRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  ChannelReactionAddRequest(
    Chat chat, {
    required ChannelType channelType,
    required String channelUrl,
    required int messageId,
    required String key,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = '${channelType.urlString}/$channelUrl/messages/$messageId/reactions';
    body = {'reaction': key, 'user_id': userId};
  }

  @override
  Future<ReactionEvent> response(Map<String, dynamic> res) async {
    return ReactionEvent.fromJson(res);
  }
}
