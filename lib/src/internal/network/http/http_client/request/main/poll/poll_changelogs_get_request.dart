// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/poll/poll_change_logs.dart';

class PollChangelogsGetRequest extends ApiRequest {
  static const pollChangeLogsLimit = 100; // Check

  @override
  HttpMethod get method => HttpMethod.get;

  PollChangelogsGetRequest(
    Chat chat, {
    required ChannelType channelType,
    required String channelUrl,
    String? token,
    int? ts,
    int limit = pollChangeLogsLimit,
  }) : super(chat: chat) {
    url = "${channelType.urlString}/$channelUrl/polls/changelogs";
    queryParams = {
      'token': token,
      'change_ts': ts,
      'limit': limit,
    };
    queryParams.removeWhere((key, value) => value == null);
  }

  @override
  Future<PollChangeLogs> response(Map<String, dynamic> res) async {
    return PollChangeLogs.fromJson(res);
  }
}
