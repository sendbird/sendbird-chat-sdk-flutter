// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/group_channel_filter.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

class PublicGroupChannelListRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  final publicGroupChannelListOrderEnumMap =
      <GroupChannelListQueryOrder, String>{
    GroupChannelListQueryOrder.chronological: 'chronological',
    GroupChannelListQueryOrder.latestLastMessage: 'latest_last_message',
    GroupChannelListQueryOrder.channelNameAlphabetical:
        'channel_name_alphabetical',
    GroupChannelListQueryOrder.metadataValueAlphabetical:
        'metadata_value_alphabetical',
  };

  PublicGroupChannelListRequest(
    Chat chat, {
    required int limit,
    required GroupChannelListQueryOrder order,
    String? token,
    List<String>? channelUrls,
    List<ChannelListQueryIncludeOption> options = const [],
    required GroupChannelFilter filter,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'group_channels';
    queryParams = {
      'user_id': userId ?? chat.chatContext.currentUserId,
      if (channelUrls != null && channelUrls.isNotEmpty)
        'channelUrls': channelUrls,
      'order': publicGroupChannelListOrderEnumMap[order],
      'distinct_mode': 'all',
      'token': token,
      'limit': limit,
    };

    queryParams.addAll(options.toJson());
    queryParams.addAll(filter.toJson());

    if (order == GroupChannelListQueryOrder.metadataValueAlphabetical &&
        filter.metadataOrderKey != null) {
      queryParams['metadata_order_key'] = filter.metadataOrderKey;
    }

    queryParams.removeWhere((key, value) => value == null);
  }

  @override
  Future<ChannelListQueryResponse<GroupChannel>> response(
      Map<String, dynamic> res) async {
    final response =
        ChannelListQueryResponse<GroupChannel>.fromJsonWithChat(chat, res);
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
