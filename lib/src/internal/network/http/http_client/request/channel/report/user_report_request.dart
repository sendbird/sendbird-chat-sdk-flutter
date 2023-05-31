// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

class UserReportRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  UserReportRequest(
    Chat chat, {
    required String targetId,
    required ChannelType channelType,
    required String channelUrl,
    required ReportCategory category,
    String? reporterId,
    String? description,
  }) : super(chat: chat) {
    url = 'report/users/$targetId';
    body = {
      'channel_type': channelType.urlString,
      'channel_url': channelUrl,
      'report_category': category.asString(),
      'reporting_user_id': reporterId ?? chat.chatContext.currentUserId,
      if (description != null) 'report_description': description
    };
  }
}
