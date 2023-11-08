// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';

class GroupChannelScheduledMessageListGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  final scheduledMessageListOrderEnumMap =
      <ScheduledMessageListQueryOrder, String>{
    ScheduledMessageListQueryOrder.createdAt: 'created_at',
    ScheduledMessageListQueryOrder.scheduledAt: 'scheduled_at',
  };

  final messageTypeFilterEnumMap = <MessageTypeFilter, String>{
    MessageTypeFilter.admin: 'ADMN',
    MessageTypeFilter.file: 'FILE',
    MessageTypeFilter.user: 'MESG',
  };

  GroupChannelScheduledMessageListGetRequest(
    Chat chat, {
    String? channelUrl,
    String? channelType,
    String? senderId,
    String? token,
    int? limit,
    bool? reverse,
    List<ScheduledStatus>? status,
    MessageTypeFilter? messageType,
    ScheduledMessageListQueryOrder? order =
        ScheduledMessageListQueryOrder.createdAt,
  }) : super(chat: chat) {
    url = 'scheduled_messages';

    queryParams = {
      'channel_url': channelUrl,
      'channel_type': channelType,
      'sender_id': senderId,
      'token': token,
      'limit': limit,
      'reverse': reverse,
      'status': status,
      'message_type': messageTypeFilterEnumMap[messageType],
      'order': scheduledMessageListOrderEnumMap[order],
    };

    queryParams.removeWhere((key, value) => value == null);
  }

  @override
  Future<ScheduledMessageResponse> response(Map<String, dynamic> res) async {
    final response = ScheduledMessageResponse.fromJson(res);
    for (final element in response.scheduledMessages) {
      element.set(chat);
    }
    return response;
  }
}
