// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';

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
    bool checkingHasNext = false,
  }) : super(chat: chat) {
    if (messageId <= 0 && timestamp < 0) {
      throw InvalidParameterException();
    }

    url = '${channelType.urlString}/$channelUrl/messages';

    queryParams = params;
    queryParams['is_sdk'] = true;
    queryParams['include_poll_details'] = true;
    queryParams['checking_has_next'] = checkingHasNext;

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
  Future<ChannelMessagesGetResponse> response(Map<String, dynamic> res) async {
    final messages = (res['messages'] as List)
        .map((e) => RootMessage.getMessageFromJsonWithChat(chat, e,
            channelType: channelType))
        .toList();
    final hasNext = res['has_next'] as bool?;

    return ChannelMessagesGetResponse(
      messages: messages,
      hasNext: hasNext,
    );
  }
}

class ChannelMessagesGetResponse {
  final List<RootMessage> messages;
  final bool? hasNext;

  ChannelMessagesGetResponse({
    required this.messages,
    this.hasNext,
  });
}
