// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/base_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';

class UploadStatRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  static const statUrl = 'sdk/statistics';

  UploadStatRequest(
    Chat chat, {
    required String deviceId,
    required List<BaseStat> stats,
  }) : super(chat: chat) {
    url = statUrl;
    body = {
      'device_id': deviceId,
      'log_entries': stats.map((stat) => stat.toJson()).toList(),
    };
    userId = null;
  }
}
