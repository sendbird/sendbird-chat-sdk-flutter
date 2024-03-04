// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/open_channel/open_channel_list_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/open_channel/open_channel.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/query/base_query.dart';

/// A class representing query to retrieve [OpenChannel] list.
/// Currently, 1 kind of `OpenChannel` list can be queried.
class OpenChannelListQuery extends BaseQuery {
  /// Indicate search keyword for channel URL.
  String? urlKeyword;

  /// Indicate search keyword for channel name.
  String? nameKeyword;

  /// Filters channel custom type
  String? customTypeFilter;

  /// Indicate whether to include frozen channels or not.
  bool includeFrozen = true;

  /// Indicate whether to include channel metadata on fetch.
  bool includeMetaData = true;

  OpenChannelListQuery({
    Chat? chat,
  }) : super(chat: chat ?? SendbirdChat().chat);

  /// Gets the list of next items.
  @override
  Future<List<OpenChannel>> next() async {
    sbLog.i(StackTrace.current);

    if (isLoading) throw QueryInProgressException();
    if (!hasNext) return [];

    isLoading = true;

    final options = [
      if (includeFrozen) ChannelListQueryIncludeOption.includeFrozen,
      if (includeMetaData) ChannelListQueryIncludeOption.includeMetadata
    ];

    ChannelListQueryResponse<OpenChannel> res;
    try {
      res = await chat.apiClient.send<ChannelListQueryResponse<OpenChannel>>(
        OpenChannelListRequest(
          chat,
          limit: limit,
          nameKeyword: nameKeyword,
          urlKeyword: urlKeyword,
          customType: customTypeFilter,
          token: token,
          options: options,
        ),
      );

      token = res.next;
      hasNext = res.next != '';
      for (final element in res.channels) {
        element.set(chat);
      }
    } catch (_) {
      isLoading = false;
      rethrow;
    }

    isLoading = false;
    return res.channels;
  }
}
