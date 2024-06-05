// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/channel/group_channel_update_params.dart';

class GroupChannelUpdateRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  GroupChannelUpdateRequest(
    Chat chat,
    String channelUrl,
    GroupChannelUpdateParams params, {
    ProgressHandler? progressHandler,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'group_channels/$channelUrl';
    body = params.toJson();
    isMultipart = params.coverImage != null && params.coverImage!.hasBinary;
    this.progressHandler = progressHandler;
  }

  @override
  Future<GroupChannel> response(Map<String, dynamic> res) async {
    final channel = GroupChannel.fromJsonWithChat(chat, res);
    channel.saveToCache(
      chat,
      channel: channel,
      res: res,
    );
    return channel;
  }
}
