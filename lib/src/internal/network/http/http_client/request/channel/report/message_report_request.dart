// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat/src/public/main/define/enums.dart';

class MessageReportRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  MessageReportRequest(
    Chat chat, {
    required int messageId,
    required String senderId,
    required ChannelType channelType,
    required String channelUrl,
    required ReportCategory category,
    String? description,
  }) : super(chat: chat) {
    url = 'report/${channelType.urlString}/$channelUrl/messages/$messageId';
    body = {
      'reporting_user_id': chat.chatContext.currentUserId,
      'offending_user_id': senderId,
      'report_category': category.asString(),
      if (description != null) 'report_description': description
    };
  }
}
