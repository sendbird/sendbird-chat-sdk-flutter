// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/channel/channel_cache_extensions.dart';
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

    queryParams.removeWhere((key, value) => value == null);
  }

  @override
  Future<FeedChannelListQueryResponse> response(
      Map<String, dynamic> res) async {
    final response = FeedChannelListQueryResponse.fromJsonWithChat(chat, res);
    for (var index = 0; index < response.channels.length; index++) {
      final channel = response.channels[index];
      channel.saveToCache(chat);
      (res['channels'][index] as Map<String, dynamic>)
          .cacheMetaData(channel: channel, ts: res['ts']);
      (res['channels'][index] as Map<String, dynamic>).cacheReadStatus(channel);
      (res['channels'][index] as Map<String, dynamic>)
          .cacheDeliveryStatus(channel);
    }
    return response;
  }
}
