// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/channel/channel_cache_extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/channel/group_channel_filter.dart';

class GroupChannelListRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  final groupChannelListOrderEnumMap = <GroupChannelListQueryOrder, String>{
    GroupChannelListQueryOrder.chronological: 'chronological',
    GroupChannelListQueryOrder.latestLastMessage: 'latest_last_message',
    GroupChannelListQueryOrder.channelNameAlphabetical:
        'channel_name_alphabetical',
    GroupChannelListQueryOrder.metadataValueAlphabetical:
        'metadata_value_alphabetical',
  };

  GroupChannelListRequest(
    Chat chat, {
    required int limit,
    required GroupChannelListQueryOrder order,
    String? token,
    List<String>? channelUrls,
    String? searchQuery,
    required GroupChannelListQueryType queryType,
    List<GroupChannelListQuerySearchField> searchFields = const [],
    List<ChannelListQueryIncludeOption> options = const [],
    required GroupChannelFilter filter,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/my_group_channels';

    final searchFieldStrings = stringFromSearchFields(searchFields);
    queryParams = {
      if (userId != null) 'user_id': userId,
      if (token != null) 'token': token,
      'limit': limit,
      if (channelUrls != null) 'channel_urls': channelUrls,
      'order': groupChannelListOrderEnumMap[order],
      if (searchFieldStrings.isNotEmpty) 'search_field': searchFieldStrings,
      if (searchFieldStrings.isNotEmpty) 'search_query': searchQuery,
      'distinct_mode': 'all',
      'show_member': true,
    };

    queryParams.addAll(options.toJson());
    queryParams.addAll(filter.toJson());

    if (filter.membersIncludeIn != null &&
        filter.membersIncludeIn!.isNotEmpty) {
      queryParams['members_include_in'] = filter.membersIncludeIn;
      queryParams['query_type'] = queryType.asString();
    }

    if (order == GroupChannelListQueryOrder.metadataValueAlphabetical &&
        filter.metadataOrderKey != null) {
      queryParams['metadata_order_key'] = filter.metadataOrderKey;
    }

    queryParams['is_explicit_request'] = true;

    queryParams.removeWhere((key, value) => value == null);
  }

  @override
  Future<ChannelListQueryResponse<GroupChannel>> response(
      Map<String, dynamic> res) async {
    final response =
        ChannelListQueryResponse<GroupChannel>.fromJsonWithChat(chat, res);
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

  List<String> stringFromSearchFields(
      List<GroupChannelListQuerySearchField> fields) {
    if (fields.isEmpty) {
      return [];
    }

    final result = <String>[];
    for (final element in fields) {
      if (element == GroupChannelListQuerySearchField.memberNickname) {
        result.add('member_nick_name');
      } else {
        result.add('channel_name');
      }
    }
    return result;
  }
}
