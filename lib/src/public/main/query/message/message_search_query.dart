// // Copyright (c) 2023 Sendbird, Inc. All rights reserved.
//
// import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
// import 'package:sendbird_chat/src/internal/main/logger/sendbird_logger.dart';
// import 'package:sendbird_chat/src/internal/network/http/http_client/request/main/message_search_request.dart';
// import 'package:sendbird_chat/src/internal/network/http/http_client/response/responses.dart';
// import 'package:sendbird_chat/src/public/core/message/base_message.dart';
// import 'package:sendbird_chat/src/public/main/chat/sendbird_chat.dart';
// import 'package:sendbird_chat/src/public/main/define/enums.dart';
// import 'package:sendbird_chat/src/public/main/define/exceptions.dart';
// import 'package:sendbird_chat/src/public/main/query/base_query.dart';
//
// /// A class representing query to retrieve list of [BaseMessage]s that matches a given query
// /// with given filters.
// class MessageSearchQuery extends BaseQuery {
//   /// The keyword to search for.
//   String keyword;
//
//   /// The channel url to set as the search scope.
//   String? channelUrl;
//
//   /// The custom type of channel to set as the search scope.
//   String? channelCustomType;
//
//   /// Whether the search result is set to be reversed or not.
//   bool reverse = false;
//
//   /// Whether the search query should be an exact match or not.
//   bool exactMatch = false;
//
//   /// The start message timestamp set as the search range.
//   int? messageTimestampFrom;
//
//   /// The end message timestamp set as the search range.
//   int? messageTimestampTo;
//
//   /// Whether the search query should be an advanced query or not.
//   bool advancedQuery = false;
//
//   /// Target fields of the query to set as the search scope.
//   List<String> targetFields = [];
//
//   /// The [MessageSearchQueryOrder] of the search.
//   MessageSearchQueryOrder order = MessageSearchQueryOrder.score;
//
//   final messageSearchQueryOrderEnumMap = <MessageSearchQueryOrder, String>{
//     MessageSearchQueryOrder.score: 'score',
//     MessageSearchQueryOrder.timestamp: 'ts',
//   };
//
//   MessageSearchQuery({
//     required this.keyword,
//     Chat? chat,
//   }) : super(chat: chat ?? SendbirdChat().chat);
//
//   /// Gets the list of next items.
//   @override
//   Future<List<BaseMessage>> next() async {
//     sbLog.i(StackTrace.current);
//
//     if (isLoading) throw QueryInProgressException();
//     if (!hasNext) return [];
//
//     isLoading = true;
//
//     final res = await chat.apiClient.send<MessageSearchQueryResponse>(
//       MessageSearchRequest(
//         chat,
//         limit: limit,
//         keyword: keyword,
//         channelUrl: channelUrl,
//         channelCustomType: channelCustomType,
//         beforeToken: null,
//         afterToken: token,
//         token: null,
//         startAt: messageTimestampFrom,
//         endAt: messageTimestampTo,
//         sortField: messageSearchQueryOrderEnumMap[order],
//         reverse: reverse,
//         exactMatch: exactMatch,
//         advancedQuery: advancedQuery,
//         targetFields: targetFields,
//       ),
//     );
//
//     isLoading = false;
//     token = res.next;
//     hasNext = res.hasNext;
//     return res.results;
//   }
// }
