// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

class ChannelReportRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  ChannelReportRequest(
    Chat chat, {
    required ChannelType channelType,
    required String channelUrl,
    required ReportCategory category,
    String? description,
  }) : super(chat: chat) {
    url = 'report/${channelType.urlString}/$channelUrl';
    body = {
      'reporting_user_id': chat.chatContext.currentUserId,
      'report_category': category.asString(),
      if (description != null) 'report_description': description
    };
  }
}
