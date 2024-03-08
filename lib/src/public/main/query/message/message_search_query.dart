// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/message_search_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/query/base_query.dart';

/// A class representing query to retrieve list of [BaseMessage]s that matches a given query
/// with given filters.
/// @since 4.0.13
class MessageSearchQuery extends BaseQuery {
  /// The keyword to search for.
  /// @since 4.0.13
  String keyword;

  /// The channel url to set as the search scope.
  /// @since 4.0.13
  String? channelUrl;

  /// The custom type of channel to set as the search scope.
  /// @since 4.0.13
  String? channelCustomType;

  /// Whether the search result is set to be reversed or not.
  /// @since 4.0.13
  bool reverse = false;

  /// Whether the search query should be an exact match or not.
  /// @since 4.0.13
  bool exactMatch = false;

  /// The start message timestamp set as the search range.
  /// @since 4.0.13
  int? messageTimestampFrom;

  /// The end message timestamp set as the search range.
  /// @since 4.0.13
  int? messageTimestampTo;

  /// Whether the search query should be an advanced query or not.
  /// @since 4.0.13
  bool advancedQuery = false;

  /// Target fields of the query to set as the search scope.
  /// @since 4.0.13
  List<String> targetFields = [];

  /// The [MessageSearchQueryOrder] of the search.
  /// @since 4.0.13
  MessageSearchQueryOrder order = MessageSearchQueryOrder.score;

  final _messageSearchQueryOrderEnumMap = <MessageSearchQueryOrder, String>{
    MessageSearchQueryOrder.score: 'score',
    MessageSearchQueryOrder.timestamp: 'ts',
  };

  /// The total count of results that matches the given search.
  /// @since 4.0.13
  int totalCount = -1;

  MessageSearchQuery({
    required this.keyword,
    Chat? chat,
  }) : super(chat: chat ?? SendbirdChat().chat);

  /// Gets the list of next items.
  /// @since 4.0.13
  @override
  Future<List<BaseMessage>> next() async {
    sbLog.i(StackTrace.current);

    if (isLoading) throw QueryInProgressException();
    if (!hasNext) return [];

    isLoading = true;

    MessageSearchQueryResponse res;
    try {
      res = await chat.apiClient.send<MessageSearchQueryResponse>(
        MessageSearchRequest(
          chat,
          limit: limit,
          keyword: keyword,
          channelUrl: channelUrl,
          channelCustomType: channelCustomType,
          beforeToken: null,
          afterToken: token,
          token: null,
          startAt: messageTimestampFrom,
          endAt: messageTimestampTo,
          sortField: _messageSearchQueryOrderEnumMap[order],
          reverse: reverse,
          exactMatch: exactMatch,
          advancedQuery: advancedQuery,
          targetFields: targetFields,
        ),
      );

      hasNext = res.hasNext;
      totalCount = res.totalCount;
      token = res.next;
    } catch (_) {
      isLoading = false;
      rethrow;
    }

    isLoading = false;
    return res.results;
  }
}
