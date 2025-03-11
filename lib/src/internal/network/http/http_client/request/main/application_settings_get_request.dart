// Copyright (c) 2025 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/application_settings.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';

class ApplicationSettingsGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  ApplicationSettingsGetRequest(
    Chat chat, {
    int? ts,
    String? token,
    int? limit,
  }) : super(chat: chat) {
    url = 'sdk/applications/settings';

    if (token != null) {
      queryParams['token'] = token;
    } else if (ts != null) {
      queryParams['ts'] = ts;
    }

    if (limit != null) {
      queryParams['limit'] = limit;
    }
  }

  @override
  Future<ApplicationSettings> response(Map<String, dynamic> res) async {
    return ApplicationSettings.fromJson(res);
  }
}
