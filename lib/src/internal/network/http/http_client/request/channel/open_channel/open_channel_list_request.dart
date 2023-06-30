// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/channel/channel_cache_extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/open_channel/open_channel.dart';

class OpenChannelListRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  OpenChannelListRequest(
    Chat chat, {
    required int limit,
    String? nameKeyword,
    String? urlKeyword,
    String? customType,
    List<ChannelListQueryIncludeOption>? options,
    String? token,
  }) : super(chat: chat) {
    url = 'open_channels';
    queryParams = {
      if (nameKeyword != null) 'name_contains': nameKeyword,
      if (urlKeyword != null) 'url_contains': urlKeyword,
      if (customType != null) 'custom_type': customType,
      if (token != null) 'token': token,
      'limit': limit.toString(),
    };

    queryParams.addAll(options?.toJson() ?? {});
  }

  @override
  Future<ChannelListQueryResponse<OpenChannel>> response(
      Map<String, dynamic> res) async {
    final response =
        ChannelListQueryResponse<OpenChannel>.fromJsonWithChat(chat, res);
    for (var index = 0; index < response.channels.length; index++) {
      final channel = response.channels[index];
      channel.saveToCache(chat);
      (res['channels'][index] as Map<String, dynamic>)
          .cacheMetaData(channel: channel, ts: res['ts']);
    }
    return response;
  }
}
