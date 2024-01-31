// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/feed_channel/feed_channel_list_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/feed_channel/feed_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/query/base_query.dart';

/// A class representing query to retrieve [FeedChannel] list for the current [User].
/// @since 4.0.3
class FeedChannelListQuery extends BaseQuery {
  /// Checks whether query result includes empty channels. (channels without messages).
  /// This flag is true by default.
  /// @since 4.0.3
  bool includeEmpty = true;

  //+ [DBManager] This will be supported in FeedChannelCollection because of some limitation.
  // int _fetchedCount = 0;
  // int _offset = 0;
  //- [DBManager]

  FeedChannelListQuery({
    Chat? chat,
  }) : super(chat: chat ?? SendbirdChat().chat);

  /// Gets the list of [FeedChannel]s. The queried result is passed to `handler` as list.
  /// If this method is repeatedly called after each [next] is finished,
  /// it retrieves the following pages of the [FeedChannel] list.
  /// If there is no more pages to be read, an empty list (not `null`) is returned.
  /// @since 4.0.3
  @override
  Future<List<FeedChannel>> next() async {
    sbLog.i(StackTrace.current);

    if (isLoading) throw QueryInProgressException();
    if (!hasNext) return [];

    isLoading = true;

    final options = [
      if (includeEmpty) ChannelListQueryIncludeOption.includeEmpty,
      ChannelListQueryIncludeOption.includeMember,
      ChannelListQueryIncludeOption.includeReadReceipt,
      ChannelListQueryIncludeOption.includeDeliveryReceipt,
    ];

    FeedChannelListQueryResponse res;

    try {
      res = await chat.apiClient.send<FeedChannelListQueryResponse>(
        FeedChannelListRequest(
          chat,
          limit: limit,
          options: options,
          token: token,
        ),
      );

      token = res.next;
      hasNext = res.next != '';
      for (final element in res.channels) {
        element.set(chat);
      }

      //+ [DBManager]
      // if (chat.dbManager.isEnabled()) {
      //   await chat.dbManager.upsertFeedChannels(res.channels);
      //
      //   _fetchedCount += res.channels.length;
      //   _offset = _fetchedCount;
      // }
      //- [DBManager]
    } catch (e) {
      isLoading = false;

      //+ [DBManager]
      // if (chat.dbManager.isEnabled()) {
      //   final localChannels =
      //       await chat.dbManager.getFeedChannels(query: this, offset: _offset);
      //   _offset += localChannels.length;
      //
      //   hasNext = (limit == localChannels.length);
      //   return localChannels;
      // }
      //- [DBManager]
      rethrow;
    }

    isLoading = false;
    return res.channels;
  }
}
