// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';

class MessageSearchRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  MessageSearchRequest(
    Chat chat, {
    required int limit,
    required String keyword,
    String? channelUrl,
    String? channelCustomType,
    String? beforeToken,
    String? afterToken,
    String? token,
    int? startAt,
    int? endAt,
    String? sortField,
    bool? reverse,
    bool? exactMatch,
    bool? advancedQuery,
    List<String>? targetFields,
  }) : super(chat: chat) {
    url = 'search/messages';
    queryParams = {
      'limit': limit,
      'query': keyword,
      'channel_url': channelUrl,
      'custom_type': channelCustomType,
      'before': beforeToken,
      'after': afterToken,
      'token': token,
      'message_ts_from': startAt,
      'message_ts_to': endAt,
      'sort_field': sortField,
      'reverse': reverse,
      'exact_match': exactMatch,
      'advanced_query': advancedQuery,
      'target_fields': targetFields,
    };

    queryParams.removeWhere((key, value) => value == null);
  }

  @override
  Future<MessageSearchQueryResponse> response(Map<String, dynamic> res) async {
    final response = MessageSearchQueryResponse.fromJson(res);
    for (final element in response.results) {
      element.set(chat);
    }
    return response;
  }
}
