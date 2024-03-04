// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:core';

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/scheduled_message/group_channel_scheduled_message_get_list_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/scheduled_message_list_query_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/query/base_query.dart';

/// Represents a query for retrieving a list of scheduled messages.
class ScheduledMessageListQuery extends BaseQuery {
  ScheduledMessageListQueryParams? params;

  ScheduledMessageListQuery({
    this.params,
    Chat? chat,
  }) : super(chat: chat ?? SendbirdChat().chat) {
    if (params?.limit != null) limit = params!.limit!;
  }

  /// Gets the list of next items.
  @override
  Future<List<BaseMessage>> next() async {
    sbLog.i(StackTrace.current);

    if (isLoading) throw QueryInProgressException();
    if (!hasNext) return [];

    isLoading = true;

    ScheduledMessageResponse res;
    try {
      res = await chat.apiClient.send<ScheduledMessageResponse>(
        GroupChannelScheduledMessageListGetRequest(
          chat,
          limit: limit,
          channelUrl: params?.channelUrl,
          reverse: params?.reverse,
          status: params?.scheduledStatus,
          messageType: params?.messageTypeFilter,
          order: params?.order,
          token: token,
        ),
      );

      token = res.next;
      hasNext = res.next != '';
    } catch (_) {
      isLoading = false;
      rethrow;
    }

    isLoading = false;
    return res.scheduledMessages;
  }
}
