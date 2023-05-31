// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat/src/public/main/define/enums.dart';
import 'package:sendbird_chat/src/public/main/model/poll/poll.dart';

class PollGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  PollGetRequest(
    Chat chat, {
    required int pollId,
    required String channelUrl,
    required ChannelType channelType,
  }) : super(chat: chat) {
    url = 'polls/$pollId';

    queryParams = {
      'channel_url': channelUrl,
      'channel_type': channelType.urlString,
    };
  }

  @override
  Future<Poll> response(Map<String, dynamic> res) async {
    return Poll.fromJson(res);
  }
}
