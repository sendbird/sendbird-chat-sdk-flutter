// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/group_channel_filter.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/enum_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/group_channel_list_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/query/base_query.dart';

/// A class representing query to retrieve [GroupChannel] list for the current [User].
/// Currently, 1 kind of [GroupChannel] list can be queried.
/// The list of [GroupChannel]s the current [User] is a member of.
class GroupChannelListQuery extends BaseQuery {
  /// Result order of channels. Refer to [GroupChannelListQueryOrder].
  /// [GroupChannelListQueryOrder.metadataValueAlphabetical] works with [metaDataOrderKeyFilter].
  GroupChannelListQueryOrder order =
      GroupChannelListQueryOrder.latestLastMessage;

  /// List of channel URL filter. It will return `null` if channel URL filter hasn't been set before.
  /// [GroupChannel] list containing only and exactly the passed [GroupChannel] URLs will be returned.
  List<String> channelUrlsFilter = [];

  /// A filter to return channels with the current [User] state matching to [MyMemberStateFilter].
  ///
  /// If set [MyMemberStateFilter.invited], only the channels from which invitations has been sent to the current [User] (but not accepted yet) will be returned.
  /// If set [MyMemberStateFilter.invitedByFriend], only the channels from which invitations by friend has been sent to the current [User] (but not accepted yet) will be returned.
  /// If set [MyMemberStateFilter.invitedByNonFriend], only the channels from which invitations by non friend has been sent to the current [User] (but not accepted yet) will be returned.
  /// If set [MyMemberStateFilter.joined], only the channels the current [User] is already joined will be returned.
  @JsonKey(toJson: memberStateFilterEnumForQuery)
  MyMemberStateFilter myMemberStateFilter = MyMemberStateFilter.all;

  /// Super channel filter. Refer to [SuperChannelFilter].
  @JsonKey(toJson: groupChannelSuperFilterEnum)
  SuperChannelFilter superChannelFilter = SuperChannelFilter.all;

  /// Public channel filter. Refer to [PublicChannelFilter].
  PublicChannelFilter publicChannelFilter = PublicChannelFilter.all;

  /// Unread channel filter. Refer to [UnreadChannelFilter].
  UnreadChannelFilter unreadChannelFilter = UnreadChannelFilter.all;

  /// Hidden channel filter. Refer to [HiddenChannelFilter].
  HiddenChannelFilter hiddenChannelFilter = HiddenChannelFilter.unhidden;

  /// A filter to return channels that start with the specified customType.
  @JsonKey(name: 'custom_type_startswith')
  String? customTypeStartsWithFilter;

  /// List of custom type filter. [GroupChannel] list containing only and exactly the passed custom types will be returned.
  List<String> customTypesFilter = [];

  /// Searches for [GroupChannel]s with members whose nicknames contain the specified value.
  /// If you pass nickname such as "abc", then the returned channel list will be containing member like "*abc*".
  /// This does not cooperate with other filters.
  String? nicknameContainsFilter;

  /// [User] IDs include filter.
  List<String> userIdsIncludeFilter = [];

  /// [GroupChannelListQueryType] of [User] IDs filter.
  /// Refer to [setUserIdsIncludeFilter]
  GroupChannelListQueryType queryType = GroupChannelListQueryType.and;

  /// [User] IDs exact filter.[GroupChannel] list containing only and exactly the passed [User] IDs will be returned.
  /// This does not cooperate with other filters.
  List<String> userIdsExactFilter = [];

  /// A channel name filter. [GroupChannel] list containing the passed channel name will be returned.
  /// If you pass name such as "abc", then the returned channel list will be containing name like "*abc*".
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

  /// Query string. Refer to [setSearchFilter].
  String? searchQuery;

  /// Search fields. Refer to [setSearchFilter] and [GroupChannelListQuerySearchField].
  List<GroupChannelListQuerySearchField> searchFields = [];

  /// Checks whether query result includes empty channels. (channels without messages).
  /// This flag is true by default.
  bool includeEmpty = true;

  /// Checks whether query result includes frozen channels.
  /// This flag is true by default.
  bool includeFrozen = true;

  /// Checks whether to include channel metadata on fetch.
  /// This flag is true by default.
  bool includeMetaData = true;

  /// Whether to include chat notification [GroupChannel].
  /// @since 4.0.3
  bool includeChatNotification = false;

  /// Restricts the search scope to only retrieve group channels which have been created before the specified time, in milliseconds.
  /// @since 4.1.2
  int? createdBefore;

  /// Restricts the search scope to only retrieve group channels which have been created after the specified time, in milliseconds.
  /// @since 4.1.2
  int? createdAfter;

  GroupChannelListQuery({
    Chat? chat,
  }) : super(chat: chat ?? SendbirdChat().chat);

  /// [User] IDs exact filter.[GroupChannel] list containing only and exactly the passed [User] IDs will be returned.
  /// This does not cooperate with other filters.
  void setUserIdsExactFilter(List<String> userIds) {
    sbLog.i(StackTrace.current, 'userIds: $userIds');

    nicknameContainsFilter = null;
    userIdsIncludeFilter = [];
    userIdsExactFilter = userIds;
  }

  /// Sets [User] IDs filter. [GroupChannel] list containing the passed [User] IDs and other members will be returned.
  /// This does not cooperate with other filters.
  void setUserIdsIncludeFilter(
      List<String> userIds, GroupChannelListQueryType type) {
    sbLog.i(StackTrace.current, 'userIds: $userIds, type: $type');

    nicknameContainsFilter = null;
    userIdsExactFilter = [];
    userIdsIncludeFilter = userIds;
    queryType = type;
  }

  /// Searches for [GroupChannel]s with members whose nicknames contain the specified value.
  /// If you pass nickname such as "abc", then the returned channel list will be containing member like "*abc*".
  /// This does not cooperate with other filters.
  void setNicknameContainsFilter(String nickname) {
    sbLog.i(StackTrace.current, 'nickname: $nickname');

    userIdsIncludeFilter = [];
    userIdsExactFilter = [];
    nicknameContainsFilter = nickname;
  }

  /// Sets `Search` filter.
  /// [GroupChannel]s will be included in the result if its data in specified [GroupChannelListQuerySearchField]s contains specified query string.
  /// Refer to [GroupChannelListQuerySearchField].
  /// If you set multiple [GroupChannelListQuerySearchField]s, the result will be union of each result.
  /// [searchFields] that you want to search.
  /// [searchQuery] string you want to search with.
  void setSearchFilter(
    List<GroupChannelListQuerySearchField> searchFields,
    String searchQuery,
  ) {
    sbLog.i(StackTrace.current, 'searchQuery: $searchQuery');

    this.searchFields = searchFields;
    this.searchQuery = searchQuery;
  }

  /// List of channel URL filter. It will return `null` if channel URL filter hasn't been set before.
  /// [GroupChannel] list containing only and exactly the passed [GroupChannel] URLs will be returned.
  void setChannelUrlsFilter(List<String> channelUrls) {
    sbLog.i(StackTrace.current, 'channelUrls: $channelUrls');

    userIdsExactFilter = [];
    userIdsIncludeFilter = [];
    searchFields = [];
    searchQuery = null;
    nicknameContainsFilter = null;
    channelUrls = channelUrls;
  }

  /// Works exclusively with [setMetaDataValueStartsWith].
  void setMetaData(String key, List<String> values) {
    sbLog.i(StackTrace.current, 'key: $key, values: $values');

    metaDataKey = key;
    metaDataValues = values;
    metaDataValueStartsWith = null;
  }

  /// Works exclusively with [setMetaData].
  void setMetaDataValueStartsWith(String key, String startWith) {
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

    final filter = GroupChannelFilter()
      ..customTypeStartsWith = customTypeStartsWithFilter
      ..customTypes = customTypesFilter
      ..memberStateFilter = myMemberStateFilter
      ..membersExactlyIn = userIdsExactFilter
      ..membersIncludeIn = userIdsIncludeFilter
      ..membersNicknameContains = nicknameContainsFilter
      ..nameContains = channelNameContainsFilter
      ..superMode = superChannelFilter
      ..publicMode = publicChannelFilter
      ..unreadFilter = unreadChannelFilter
      ..metadataOrderKey = metaDataOrderKeyFilter
      ..hiddenMode = hiddenChannelFilter
      ..metaDataKey = metaDataKey
      ..metaDataValues = metaDataValues
      ..metaDataValueStartsWithFilter = metaDataValueStartsWith
      ..createdBefore = GroupChannelFilter.toSec(createdBefore)
      ..createdAfter = GroupChannelFilter.toSec(createdAfter);

    final options = [
      if (includeEmpty) ChannelListQueryIncludeOption.includeEmpty,
      if (includeFrozen) ChannelListQueryIncludeOption.includeFrozen,
      if (includeMetaData) ChannelListQueryIncludeOption.includeMetadata,
      if (includeChatNotification)
        ChannelListQueryIncludeOption.includeChatNotification,
      ChannelListQueryIncludeOption.includeMember,
      ChannelListQueryIncludeOption.includeReadReceipt,
      ChannelListQueryIncludeOption.includeDeliveryReceipt,
    ];

    ChannelListQueryResponse<GroupChannel> res;
    try {
      res = await chat.apiClient.send<ChannelListQueryResponse<GroupChannel>>(
        GroupChannelListRequest(
          chat,
          limit: limit,
          filter: filter,
          options: options,
          queryType: queryType,
          token: token,
          order: order,
          channelUrls: channelUrlsFilter,
          searchFields: searchFields,
          searchQuery: searchQuery,
        ),
      );

      token = res.next;
      hasNext = res.next != '';
      for (final channel in res.channels) {
        channel.set(chat);
      }

      //+ [DBManager]
      if (chat.dbManager.isEnabled()) {
        await chat.dbManager.upsertGroupChannels(res.channels);
      }
      //- [DBManager]
    } catch (_) {
      isLoading = false;
      rethrow;
    }

    isLoading = false;
    return res.channels;
  }
}
