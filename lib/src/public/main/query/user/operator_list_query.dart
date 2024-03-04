// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/user/list/operator_list_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/query/base_query.dart';

/// A class representing query to retrieve operator lists related to [User].
class OperatorListQuery extends BaseQuery {
  /// The [ChannelType] of the channel you want to get operators from.
  ChannelType channelType;

  /// The channel url of the channel you want to get operators from.
  String channelUrl;

  OperatorListQuery({
    required this.channelType,
    required this.channelUrl,
    Chat? chat,
  }) : super(chat: chat ?? SendbirdChat().chat);

  /// Gets the list of next items.
  @override
  Future<List<User>> next() async {
    sbLog.i(StackTrace.current);

    if (isLoading) throw QueryInProgressException();
    if (!hasNext) return [];

    isLoading = true;

    OperatorListQueryResponse res;
    try {
      res = await chat.apiClient.send<OperatorListQueryResponse>(
        OperatorListRequest(
          chat,
          limit: limit,
          token: token,
          channelType: channelType,
          channelUrl: channelUrl,
        ),
      );

      token = res.next;
      hasNext = res.next != '';
    } catch (_) {
      isLoading = false;
      rethrow;
    }

    isLoading = false;
    return res.operators;
  }
}
