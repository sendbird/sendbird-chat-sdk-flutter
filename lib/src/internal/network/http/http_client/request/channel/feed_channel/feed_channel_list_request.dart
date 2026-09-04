// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';

class FeedChannelListRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  FeedChannelListRequest(
    Chat chat, {
    required int limit,
    List<ChannelListQueryIncludeOption> options = const [],
    // includeEmpty is sent explicitly below (see CLNP-8901).
    required bool includeEmpty,
    String? token,
  }) : super(chat: chat) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/my_group_channels';

    queryParams = {
      'limit': limit,
      if (token != null) 'token': token,
    };

    queryParams.addAll(options.toJson());
    queryParams['is_feed_channel'] = true;
    queryParams['order'] = 'latest_last_message';

    // Always send show_empty explicitly (including `false`); the include-option
    // list can only emit `true`. Non-null, so the removeWhere below keeps it.
    // Matches the Android/iOS/JS feed queries. (CLNP-8901)
    queryParams['show_empty'] = includeEmpty;

    queryParams.removeWhere((key, value) => value == null);
  }

  @override
  Future<FeedChannelListQueryResponse> response(
      Map<String, dynamic> res) async {
    final response = FeedChannelListQueryResponse.fromJsonWithChat(chat, res);
    for (var index = 0; index < response.channels.length; index++) {
      final channel = response.channels[index];
      channel.saveToCache(
        chat,
        channel: channel,
        res: res['channels'][index] as Map<String, dynamic>,
        ts: res['ts'],
      );
    }
    return response;
  }
}
