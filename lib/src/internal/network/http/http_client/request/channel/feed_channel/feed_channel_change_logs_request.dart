// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/channel/channel_cache_extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/channel/feed_channel_change_logs.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/channel/feed_channel_change_logs_params.dart';

class FeedChannelChangeLogsGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  FeedChannelChangeLogsGetRequest(
    Chat chat,
    FeedChannelChangeLogsParams params, {
    String? token,
    int? timestamp,
    String? userId,
  }) : super(chat: chat) {
    url =
        'users/${getUrlEncodedUserId(chat, userId)}/my_group_channels/changelogs';
    queryParams = params.toJson();
    queryParams['show_member'] = true;
    queryParams['show_read_receipt'] = true;
    queryParams['show_delivery_receipt'] = true;
    queryParams['is_feed_channel'] = true;

    if (timestamp != null && timestamp > 0) {
      queryParams['change_ts'] = timestamp;
    } else if (token != null) {
      queryParams['token'] = token;
    }
  }

  @override
  Future<FeedChannelChangeLogs> response(Map<String, dynamic> res) async {
    final response = FeedChannelChangeLogs.fromJsonWithChat(chat, res);
    for (var index = 0; index < response.updatedChannels.length; index++) {
      final channel = response.updatedChannels[index];
      channel.saveToCache(chat);
      (res['updated'][index] as Map<String, dynamic>)
          .cacheMetaData(channel: channel, ts: res['ts']);
      (res['updated'][index] as Map<String, dynamic>).cacheReadStatus(channel);
      (res['updated'][index] as Map<String, dynamic>)
          .cacheDeliveryStatus(channel);
    }
    return response;
  }
}
