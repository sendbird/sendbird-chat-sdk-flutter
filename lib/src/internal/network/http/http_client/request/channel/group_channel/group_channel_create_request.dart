// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/channel/channel_cache_extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/channel/group_channel_create_params.dart';

class GroupChannelCreateRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  GroupChannelCreateRequest(
    Chat chat,
    GroupChannelCreateParams params, {
    ProgressHandler? progressHandler,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'group_channels';
    body = params.toJson();
    isMultipart = params.coverImage != null && params.coverImage!.hasBinary;
    this.progressHandler = progressHandler;
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
