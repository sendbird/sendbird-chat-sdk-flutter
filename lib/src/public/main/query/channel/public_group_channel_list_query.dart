// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/group_channel_filter.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/public/public_group_channel_list_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/query/base_query.dart';

/// A class representing query to retrieve [GroupChannel] list for the current `User`.
/// Currently, 1 kind of public `GroupChannel` list can be queried.
class PublicGroupChannelListQuery extends BaseQuery {
  /// List of channel URL filter. It will return `null` if channel URL filter hasn't been set before.
  /// [GroupChannel] list containing only and exactly the passed [GroupChannel] URLs will be returned.
  List<String>? channelUrlsFilter;

  /// Super channel filter. Refer to [SuperChannelFilter].
  SuperChannelFilter superChannelFilter = SuperChannelFilter.all;

  /// Membership filter. Default is [MembershipFilter.joined].
  MembershipFilter membershipFilter = MembershipFilter.all;

  /// Order of query result
  GroupChannelListQueryOrder order =
      GroupChannelListQueryOrder.channelNameAlphabetical;

  /// A filter to return channels that start with the specified customType.
  /// It will return `null` if custom type starts with filter hasn't been set before.
  String? customTypeStartsWithFilter;

  /// List of custom type filter. [GroupChannel] list containing only and exactly the passed custom types will be returned.
  /// It will return `null` if custom types filter hasn't been set before.
  List<String>? customTypesFilter;

  /// A channel name filter. [GroupChannel] list containing the passed channel name will be returned.
  /// If you pass name such as "abc", then the returned channel list will be containing name like "*abc*".
  /// It will return `null` if channel name filter hasn't been set before.
  String? channelNameContainsFilter;

  /// Meta data order key filter. It will return `null` if meta data order key filter hasn't been set before.
  /// This filter will work only if [order] is [GroupChannelListQueryOrder.metadataValueAlphabetical]
  String? metaDataOrderKeyFilter;

  /// The metadataKey set with either [metaDataValues] or [metaDataValueStartsWith].
  String? metaDataKey;

  /// Works exclusively with [metaDataValueStartsWith].
  List<String>? metaDataValues;

  /// Works exclusively with [metaDataValues].
  String? metaDataValueStartsWith;

  /// Checks whether query result includes empty channels. (channels without messages).
  /// This flag is false by default.
  bool includeEmpty = true;

  /// Checks whether query result includes frozen channels.
  /// This flag is true by default.
  bool includeFrozen = true;

  /// Query result of channel object contains meta data if `true`
  /// default value is `true`
  bool includeMetaData = true;

  /// Restricts the search scope to only retrieve group channels which have been created before the specified time, in milliseconds.
  /// @since 4.1.2
  int? createdBefore;

  /// Restricts the search scope to only retrieve group channels which have been created after the specified time, in milliseconds.
  /// @since 4.1.2
  int? createdAfter;

  PublicGroupChannelListQuery({
    Chat? chat,
  }) : super(chat: chat ?? SendbirdChat().chat);

  /// setMetaDataFilterWithValues
  void setMetaDataFilterWithValues(String key, List<String> values) {
    sbLog.i(StackTrace.current, 'key: $key, values: $values');

    metaDataKey = key;
    metaDataValues = values;
    metaDataValueStartsWith = null;
  }

  /// setMetaDataFilterWithValues
  void setMetaDataFilterWithStartWith(String key, String startWith) {
    sbLog.i(StackTrace.current, 'key: $key, startWith: $startWith');

    metaDataKey = key;
    metaDataValues = null;
    metaDataValueStartsWith = startWith;
  }

  /// Gets the list of next items.
  @override
  Future<List<GroupChannel>> next() async {
    sbLog.i(StackTrace.current);

    if (isLoading) throw QueryInProgressException();
    if (!hasNext) return [];

    isLoading = true;

    final options = <ChannelListQueryIncludeOption>[
      if (includeFrozen) ChannelListQueryIncludeOption.includeFrozen,
      if (includeEmpty) ChannelListQueryIncludeOption.includeEmpty,
      if (includeMetaData) ChannelListQueryIncludeOption.includeMetadata,
      ChannelListQueryIncludeOption.includeMember,
      ChannelListQueryIncludeOption.includeReadReceipt,
      ChannelListQueryIncludeOption.includeDeliveryReceipt,
    ];

    final filter = GroupChannelFilter()
      ..customTypeStartsWith = customTypeStartsWithFilter
      ..customTypes = customTypesFilter
      ..nameContains = channelNameContainsFilter
      ..superMode = superChannelFilter
      ..publicMembershipFilter = membershipFilter
      ..metadataOrderKey = metaDataOrderKeyFilter
      ..metaDataKey = metaDataKey
      ..metaDataValues = metaDataValues
      ..metaDataValueStartsWithFilter = metaDataValueStartsWith
      ..publicMode = PublicChannelFilter.public
      ..createdBefore = GroupChannelFilter.toSec(createdBefore)
      ..createdAfter = GroupChannelFilter.toSec(createdAfter);

    final res =
        await chat.apiClient.send<ChannelListQueryResponse<GroupChannel>>(
      PublicGroupChannelListRequest(
        chat,
        limit: limit,
        order: order,
        token: token,
        channelUrls: channelUrlsFilter,
        options: options,
        filter: filter,
      ),
    );

    for (final element in res.channels) {
      element.set(chat);
    }

    isLoading = false;
    token = res.next;
    hasNext = res.next != '';
    return res.channels;
  }
}
