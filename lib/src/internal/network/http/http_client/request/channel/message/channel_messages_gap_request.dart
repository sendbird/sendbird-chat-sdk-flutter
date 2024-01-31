// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

class ChannelMessagesGapRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  ChannelType channelType;
  bool checkingContinuousMessages;

  ChannelMessagesGapRequest(
    Chat chat, {
    required this.channelType,
    required String channelUrl,
    required Map<String, dynamic> messageListParams,
    int? prevStartTs, // oldest in prev direction
    int? prevEndTs, // latest in prev direction
    int? prevCacheCount, // inclusive prev cache count
    int? nextStartTs, // oldest in next direction
    int? nextEndTs, // latest in next direction
    int? nextCacheCount, // inclusive next cache count
    this.checkingContinuousMessages = false, // useLocalCache
  }) : super(chat: chat) {
    url = '${channelType.urlString}/$channelUrl/messages_gap';

    queryParams = messageListParams;
    queryParams['include_poll_details'] = true;

    if (prevStartTs != null && prevEndTs != null && prevCacheCount != null) {
      queryParams['prev_start_ts'] = prevStartTs;
      queryParams['prev_end_ts'] = prevEndTs;
      queryParams['prev_cache_count'] = prevCacheCount;
    }

    if (nextStartTs != null && nextEndTs != null && nextCacheCount != null) {
      queryParams['next_start_ts'] = nextStartTs;
      queryParams['next_end_ts'] = nextEndTs;
      queryParams['next_cache_count'] = nextCacheCount;
    }

    queryParams['checking_continuous_messages'] = checkingContinuousMessages;
  }

  @override
  Future<ChannelMessagesGapResponse> response(Map<String, dynamic> res) async {
    final isHugeGap = res['is_huge_gap'] as bool;

    final prevMessages = (res['prev_messages'] as List)
        .map((e) => RootMessage.getMessageFromJsonWithChat(chat, e,
            channelType: channelType))
        .toList();

    final nextMessages = (res['next_messages'] as List)
        .map((e) => RootMessage.getMessageFromJsonWithChat(chat, e,
            channelType: channelType))
        .toList();

    final prevHasMore = res['prev_hasmore'] as bool;
    final nextHasMore = res['next_hasmore'] as bool;

    bool? isPrevContinuous;
    bool? isNextContinuous;
    if (checkingContinuousMessages) {
      isPrevContinuous = res['is_continuous_prev_messages'] as bool;
      isNextContinuous = res['is_continuous_next_messages'] as bool;
    }

    return ChannelMessagesGapResponse(
      isHugeGap: isHugeGap,
      prevMessages: prevMessages,
      nextMessages: nextMessages,
      prevHasMore: prevHasMore,
      nextHasMore: nextHasMore,
      isPrevContinuous: isPrevContinuous,
      isNextContinuous: isNextContinuous,
    );
  }
}

class ChannelMessagesGapResponse {
  final List<RootMessage> prevMessages;
  final List<RootMessage> nextMessages;
  final bool? prevHasMore;
  final bool? nextHasMore;
  final bool? isPrevContinuous;
  final bool? isNextContinuous;
  final bool isHugeGap;

  ChannelMessagesGapResponse({
    required this.prevMessages,
    required this.nextMessages,
    required this.prevHasMore,
    required this.nextHasMore,
    this.isPrevContinuous,
    this.isNextContinuous,
    required this.isHugeGap,
  });
}
