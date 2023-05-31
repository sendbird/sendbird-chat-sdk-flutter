// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat/src/public/main/define/enums.dart';
import 'package:sendbird_chat/src/public/main/model/poll/poll_option.dart';

class PollOptionGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  PollOptionGetRequest(
    Chat chat, {
    required int pollId,
    required int pollOptionId,
    required String channelUrl,
    required ChannelType channelType,
  }) : super(chat: chat) {
    url = 'polls/$pollId/options/$pollOptionId';
    queryParams = {
      'channel_url': channelUrl,
      'channel_type': channelType.urlString,
    };
  }

  @override
  Future<PollOption> response(Map<String, dynamic> res) async {
    return PollOption.fromJson(res);
  }
}
