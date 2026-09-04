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
    // includeEmpty / includeFrozen are sent explicitly below (see CLNP-8901),
    // so they are passed as booleans rather than via the include-option list.
    required bool includeEmpty,
    required bool includeFrozen,
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

    // Always send show_empty / show_frozen explicitly (including `false`); the
    // include-option list can only emit `true` keys. Both are non-null, so the
    // removeWhere(value == null) below keeps them. (CLNP-8901)
    queryParams['show_empty'] = includeEmpty;
    queryParams['show_frozen'] = includeFrozen;

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
