// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/poll/poll_list_get_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/poll/poll.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/poll/poll_list_query_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/query/base_query.dart';

/// A class representing query to retrieve the list of polls.
class PollListQuery extends BaseQuery {
  final PollListQueryParams params;

  PollListQuery(
    this.params, {
    Chat? chat,
  }) : super(chat: chat ?? SendbirdChat().chat) {
    if (params.limit != null) {
      limit = (params.limit)!;
    } else {
      limit = BaseQuery.defaultPollListQueryLimit;
    }
  }

  /// Gets the list of next items.
  @override
  Future<List<Poll>> next() async {
    sbLog.i(StackTrace.current);

    if (isLoading) throw QueryInProgressException();
    if (!hasNext) return [];

    isLoading = true;

    PollListQueryResponse res;
    try {
      res = await chat.apiClient.send<PollListQueryResponse>(
        PollListGetRequest(
          chat,
          limit: limit,
          channelType: params.channelType,
          channelUrl: params.channelUrl,
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
    return res.polls;
  }
}
