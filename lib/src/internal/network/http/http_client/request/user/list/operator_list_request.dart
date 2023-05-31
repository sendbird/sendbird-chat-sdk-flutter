// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat/src/public/main/define/enums.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/response/responses.dart';

class OperatorListRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  OperatorListRequest(
    Chat chat, {
    required int limit,
    required ChannelType channelType,
    required String channelUrl,
    String? token,
  }) : super(chat: chat) {
    url = '${channelType.urlString}/$channelUrl/operators';
    queryParams = {
      'limit': limit.toString(),
      if (token != null) 'token': token,
    };
  }

  @override
  Future<OperatorListQueryResponse> response(Map<String, dynamic> res) async {
    final response = OperatorListQueryResponse.fromJson(res);
    for (final element in response.operators) {
      element.set(chat);
    }
    return response;
  }
}
