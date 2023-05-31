// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/message_change_logs.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/message_change_logs_params.dart';

class ChannelMessageChangeLogGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  ChannelMessageChangeLogGetRequest(
    Chat chat, {
    required ChannelType channelType,
    required String channelUrl,
    required MessageChangeLogParams params,
    String? token,
    int? timestamp,
  }) : super(chat: chat) {
    url = '${channelType.urlString}/$channelUrl/messages/changelogs';

    queryParams = params.toJson();
    queryParams['include_poll_details'] = true;

    if (token != null) {
      queryParams['token'] = token;
    } else {
      queryParams['change_ts'] = timestamp;
    }
  }

  @override
  Future<MessageChangeLogs> response(Map<String, dynamic> res) async {
    final response = MessageChangeLogs.fromJson(res);
    for (final element in response.updatedMessages) {
      element.set(chat);
    }
    return response;
  }
}
