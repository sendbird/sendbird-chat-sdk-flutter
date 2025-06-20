// Copyright (c) 2025 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';

class UIKitConfigurationGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  UIKitConfigurationGetRequest(
    Chat chat,
  ) : super(chat: chat) {
    url = 'sdk/ui_kit/configuration';
  }

  @override
  Future<Map<String, dynamic>> response(Map<String, dynamic> res) async {
    return res;
  }
}
