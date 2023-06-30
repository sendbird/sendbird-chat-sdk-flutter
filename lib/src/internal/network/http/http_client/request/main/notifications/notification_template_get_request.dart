// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/chat/notification_template.dart';

class NotificationTemplateGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  NotificationTemplateGetRequest(
    Chat chat, {
    required String key,
  }) : super(chat: chat) {
    url = 'notifications/templates/$key';
  }

  @override
  Future<NotificationTemplate> response(Map<String, dynamic> res) async {
    return NotificationTemplate(template: res);
  }
}
