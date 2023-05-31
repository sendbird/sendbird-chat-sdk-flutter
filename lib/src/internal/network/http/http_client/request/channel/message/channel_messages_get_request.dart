// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat/src/public/core/message/base_message.dart';
import 'package:sendbird_chat/src/public/main/define/enums.dart';
import 'package:sendbird_chat/src/public/main/define/exceptions.dart';

class ChannelMessagesGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  ChannelType channelType;

  ChannelMessagesGetRequest(
    Chat chat, {
    required this.channelType,
    required String channelUrl,
    required Map<String, dynamic> params,
    int timestamp = -1,
    int messageId = 0,
    int parentMessageId = 0,
  }) : super(chat: chat) {
    if (messageId <= 0 && timestamp < 0) {
      throw InvalidParameterException();
    }

    url = '${channelType.urlString}/$channelUrl/messages';

    queryParams = params;
    queryParams['is_sdk'] = true;
    queryParams['include_poll_details'] = true;

    if (messageId > 0) {
      queryParams['message_id'] = messageId;
    } else {
      queryParams['message_ts'] = timestamp;
    }

    if (parentMessageId > 0) {
      queryParams['parent_message_id'] = parentMessageId;
    }
  }

  @override
  Future<List<BaseMessage>> response(Map<String, dynamic> res) async {
    final baseMessages = (res['messages'] as List)
        .map((e) => BaseMessage.getMessageFromJsonWithChat(chat, e,
            channelType: channelType))
        .toList();
    return List<BaseMessage>.from(baseMessages);
  }
}
