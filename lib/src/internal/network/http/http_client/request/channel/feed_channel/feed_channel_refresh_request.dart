// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/channel/channel_cache_extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/feed_channel/feed_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';

class FeedChannelRefreshRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  FeedChannelRefreshRequest(
    Chat chat,
    String channelUrl, {
    List<ChannelListQueryIncludeOption> options = const [],
    bool passive = false,
  }) : super(chat: chat) {
    url = '${passive ? '/sdk/' : ''}group_channels/$channelUrl';
    queryParams = options.toJson();
    queryParams['is_feed_channel'] = true;
  }

  @override
  Future<FeedChannel> response(Map<String, dynamic> res) async {
    final channel = FeedChannel(
      groupChannel: GroupChannel.fromJsonWithChat(chat, res)..saveToCache(chat),
    )..set(SendbirdChat().chat); // Set the singleton chat
    res.cacheMetaData(channel: channel);
    res.cacheReadStatus(channel);
    res.cacheDeliveryStatus(channel);
    return channel;
  }
}
