// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';

class PollListGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  PollListGetRequest(
    Chat chat, {
    required int limit,
    required String channelUrl,
    required ChannelType channelType,
    String? token,
  }) : super(chat: chat) {
    url = 'polls';

    queryParams = {
      'channel_url': channelUrl,
      'token': token,
      'limit': limit,
      'channel_type': channelType.urlString,
    };

    queryParams.removeWhere((key, value) => value == null);
  }

  @override
  Future<PollListQueryResponse> response(Map<String, dynamic> res) async {
    return PollListQueryResponse.fromJson(res);
  }
}
