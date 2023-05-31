// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/channel/channel_cache_extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';

class GroupChannelRefreshRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  GroupChannelRefreshRequest(
    Chat chat,
    String channelUrl, {
    List<ChannelListQueryIncludeOption> options = const [],
    bool passive = false,
  }) : super(chat: chat) {
    url = '${passive ? '/sdk/' : ''}group_channels/$channelUrl';
    queryParams = options.toJson();
  }

  @override
  Future<GroupChannel> response(Map<String, dynamic> res) async {
    final channel = GroupChannel.fromJsonWithChat(chat, res)..saveToCache(chat);
    res.cacheMetaData(channel: channel);
    res.cacheReadStatus(channel);
    res.cacheDeliveryStatus(channel);
    return channel;
  }
}
