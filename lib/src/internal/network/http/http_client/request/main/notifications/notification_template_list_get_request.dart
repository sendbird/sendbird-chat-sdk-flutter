// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/chat/notification_template_list.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/notifications/notification_template_list_params.dart';

class NotificationTemplateListGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  NotificationTemplateListGetRequest(
    Chat chat,
    NotificationTemplateListParams params, {
    String? token,
  }) : super(chat: chat) {
    url = 'notifications/templates';
    queryParams['reverse'] = params.reverse;
    queryParams['limit'] = params.limit;
    queryParams['show_ui_template'] = true;
    queryParams['show_color_variables'] = true;
    queryParams['order'] = 'updated_at';

    if (params.keys != null && params.keys!.isNotEmpty) {
      queryParams['keys'] = params.keys;
    }

    if (token != null && token.isNotEmpty) {
      queryParams['token'] = token;
    }
  }

  @override
  Future<NotificationTemplateList> response(
    Map<String, dynamic> res,
  ) async {
    return NotificationTemplateList(
      templateList: res,
      hasMore: res['has_more'],
      token: res['next'],
    );
  }
}
