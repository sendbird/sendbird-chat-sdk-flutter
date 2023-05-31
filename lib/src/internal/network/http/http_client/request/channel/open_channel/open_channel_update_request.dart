// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat/src/internal/main/chat_cache/channel/channel_cache_extensions.dart';
import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat/src/public/core/channel/open_channel/open_channel.dart';
import 'package:sendbird_chat/src/public/main/params/channel/open_channel_update_params.dart';

class OpenChannelUpdateRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  OpenChannelUpdateRequest(
    Chat chat,
    String channelUrl,
    OpenChannelUpdateParams params, {
    ProgressHandler? progressHandler,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'open_channels/$channelUrl';
    body = params.toJson();
    isMultipart = params.coverImage != null && params.coverImage!.hasBinary;
    this.progressHandler = progressHandler;
  }

  @override
  Future<OpenChannel> response(Map<String, dynamic> res) async {
    final channel = OpenChannel.fromJsonWithChat(chat, res)..saveToCache(chat);
    res.cacheMetaData(channel: channel);
    return channel;
  }
}
