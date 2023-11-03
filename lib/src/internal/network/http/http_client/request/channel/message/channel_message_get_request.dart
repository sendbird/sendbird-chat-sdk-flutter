// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/message_retrieval_params.dart';

class ChannelMessageGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  ChannelMessageGetRequest(
    Chat chat, {
    required ChannelType channelType,
    required String channelUrl,
    required int messageId,
    required MessageRetrievalParams params,
  }) : super(chat: chat) {
    url = '${channelType.urlString}/$channelUrl/messages/$messageId';

    queryParams = params.toJson();
    queryParams['include_poll_details'] = true;
  }

  @override
  Future<BaseMessage> response(Map<String, dynamic> res) async {
    return RootMessage.getMessageFromJsonWithChat(chat, res) as BaseMessage;
  }
}
