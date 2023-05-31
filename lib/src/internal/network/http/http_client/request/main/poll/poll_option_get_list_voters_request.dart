// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';

class PollOptionGetListVotersRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  PollOptionGetListVotersRequest(
    Chat chat, {
    required int limit,
    required int pollId,
    required int pollOptionId,
    required String channelUrl,
    required ChannelType channelType,
    String? token,
  }) : super(chat: chat) {
    url = 'polls/$pollId/options/$pollOptionId/voters';
    queryParams = {
      'token': token,
      'channel_url': channelUrl,
      'limit': limit,
      'channel_type': channelType.urlString,
    };

    queryParams.removeWhere((key, value) => value == null);
  }

  @override
  Future<PollVoterListQueryResponse> response(Map<String, dynamic> res) async {
    final response = PollVoterListQueryResponse.fromJson(res);
    for (final element in response.voters) {
      element.set(chat);
    }
    return response;
  }
}
