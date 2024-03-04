// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/poll/poll_option_get_list_voters_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/poll/poll_voter_list_query_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/query/base_query.dart';

/// A class representing query to retrieve the list of voters for each poll options.
class PollVoterListQuery extends BaseQuery {
  final PollVoterListQueryParams params;

  PollVoterListQuery(
    this.params, {
    Chat? chat,
  }) : super(chat: chat ?? SendbirdChat().chat) {
    if (params.limit != null) limit = (params.limit)!;
  }

  /// Gets the list of next items.
  @override
  Future<List<User>> next() async {
    sbLog.i(StackTrace.current);

    if (isLoading) throw QueryInProgressException();
    if (!hasNext) return [];

    isLoading = true;

    PollVoterListQueryResponse res;
    try {
      res = await chat.apiClient.send<PollVoterListQueryResponse>(
        PollOptionGetListVotersRequest(
          chat,
          limit: limit,
          channelType: params.channelType,
          channelUrl: params.channelUrl,
          pollId: params.pollId,
          pollOptionId: params.pollOptionId,
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
    return res.voters;
  }
}
