import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/group_channel_filters.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/query/base_query.dart';
import 'package:sendbird_sdk/request/channel/group_channel_list_request.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';

part 'group_channel_list_query.g.dart';

/// A query object to retrieve list of my group channel.
@JsonSerializable()
class GroupChannelListQuery extends QueryBase {
  /// Order of the query result
  GroupChannelListOrder order = GroupChannelListOrder.latestLastMessage;

  /// Sets query type user Id filter, it only will work when `includeMemberList` is true
  GroupChannelListQueryType queryType = GroupChannelListQueryType.or;

  /// Sets filter channel urls.
  ///
  /// It will return a list containing only and exactly matched
  /// with given urls. This filter does not cooperate with other filters.
  List<String> channelUrls = [];

  /// Sets the member state filter
  @JsonKey(toJson: memberStateFilterEnumForQuery)
  MemberStateFilter memberStateFilter = MemberStateFilter.all;

  /// Sets to filter super channel. Default is `all`
  @JsonKey(toJson: groupChannelSuperFilterEnum)
  SuperChannelFilter superChannelFilter = SuperChannelFilter.all;

  /// Sets to filter public channel. Default is `all`
  PublicChannelFilter publicChannelFilter = PublicChannelFilter.all;

  /// Sets to filter channels by the unread messages.
  /// The default value is `all`
  UnreadChannelFilter unreadChannelFilter = UnreadChannelFilter.all;

  /// Sets to filter channels by the hidden state.
  /// The default value is `unhiddenOnly`
  ChannelHiddenStateFilter channelHiddenStateFilter =
      ChannelHiddenStateFilter.unhiddenOnly;

  /// Sets to filter channels by custom type that starts with
  String? customTypeStartWith;

  /// Sets the custom type filter.
  List<String> customTypes = [];

  /// Sets the filter with nickname.
  ///
  /// Query result will contains
  /// channels that any one of member contains given nickname
  String? nicknameContains;

  /// Sets the filter with user IDs
  ///
  /// Query result will return if any one of user id matches with channel's members
  List<String> userIdsIncludeIn = [];

  /// Sets the filter with user IDs
  ///
  /// Query result will return only if channel's members are exactly matched
  /// with this property
  List<String> userIdsExactlyIn = [];

  /// Sets a filter to return only channels that contains the
  /// specified group channel name
  String? channelNameContains;

  /// Sets a key for ordering by value in the metadata.
  /// This is valid when the `order` is `channelMetaDataValueAlphabetical` only
  String? metaDataOrderKeyFilter;

  /// Searches for group channels with metadata containing an item with the
  /// specified value as its key
  String? metaDataKeyFilter;

  /// Searches for group channels with metadata containing an item with the
  /// key specified by the metaDataKey
  List<String>? metaDataValuesFilter;

  /// Searches for group channels with metadata containing an item with the
  /// key specified by the metaDataKey and the values of that item start with
  /// the specified value
  String? metaDataValueStartWithFilter;

  String? searchQuery;
  List<GroupChannelListQuerySearchField> searchFields = [];

  /// Query result includes empty (message) channel if `true`.
  /// default value is `true`
  bool includeEmptyChannel = true;

  /// Query result includes frozen channels if `true`.
  /// default value is `true`
  bool includeFrozenChannel = true;

  /// Query result of channel object contains member list if `true`.
  /// default value is `true`
  bool includeMemberList = true;

  /// Query result of channel object contains meta data if `true`.
  /// deault value is `true`
  bool includeMetaData = true;

  GroupChannelListQuery();

  void setUserIdsExactFilter(List<String> userIds) {
    nicknameContains = null;
    userIdsIncludeIn = [];
    userIdsExactlyIn = userIds;
    queryType = GroupChannelListQueryType.and;
  }

  void setUserIdsIncludeFilter(
      List<String> userIds, GroupChannelListQueryType type) {
    nicknameContains = null;
    userIdsExactlyIn = [];
    userIdsIncludeIn = userIds;
    queryType = type;
  }

  void setNicknameContainsFilter(String nickname) {
    userIdsIncludeIn = [];
    userIdsExactlyIn = [];
    nicknameContains = nickname;
  }

  void setSearchFilter(
      String searchQuery, List<GroupChannelListQuerySearchField> searchFields) {
    searchQuery = searchQuery;
    searchFields = searchFields;
  }

  void setChannelUrlsFilter(List<String> channelUrls) {
    userIdsExactlyIn = [];
    userIdsIncludeIn = [];
    searchFields = [];
    searchQuery = null;
    nicknameContains = null;
    channelUrls = channelUrls;
  }

  void setMetaDataFilterWithValues(String key, List<String> values) {
    metaDataKeyFilter = key;
    metaDataValuesFilter = values;
    metaDataValueStartWithFilter = null;
  }

  void setMetaDataFilterWithStartWith(String key, String startWith) {
    metaDataKeyFilter = key;
    metaDataValuesFilter = null;
    metaDataValueStartWithFilter = startWith;
  }

  @override
  Future<List<GroupChannel>> loadNext() async {
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    loading = true;

    final filter = GroupChannelFilter()
      ..customTypeStartswith = customTypeStartWith
      ..customTypes = customTypes
      ..memberStateFilter = memberStateFilter
      ..membersExactlyIn = userIdsExactlyIn
      ..membersIncludeIn = userIdsIncludeIn
      ..membersNicknameContains = nicknameContains
      ..nameContains = channelNameContains
      ..superMode = superChannelFilter
      ..publicMode = publicChannelFilter
      ..unreadFilter = unreadChannelFilter
      ..metadataOrderKey = metaDataOrderKeyFilter
      ..hiddenMode = channelHiddenStateFilter
      ..metaDataKey = metaDataKeyFilter
      ..metaDataValues = metaDataValuesFilter
      ..metaDataValueStartWithFilter = metaDataValueStartWithFilter;

    final options = [
      if (includeFrozenChannel) ChannelQueryIncludeOption.frozenChannel,
      if (includeEmptyChannel) ChannelQueryIncludeOption.emptyChannel,
      if (includeMemberList) ChannelQueryIncludeOption.memberList,
      if (includeMetaData) ChannelQueryIncludeOption.metaData,
      ChannelQueryIncludeOption.readReceipt,
      ChannelQueryIncludeOption.deliveryReceipt,
    ];

    final sdk = SendbirdSdk().getInternal();
    final res = await sdk.api.send<ChannelListQueryResponse<GroupChannel>>(
      GroupChannelListRequest(
        filter: filter,
        options: options,
        queryType: queryType,
        token: token,
        limit: limit,
        order: order,
        channelUrls: channelUrls,
        searchFields: searchFields,
        searchQuery: searchQuery,
      ),
    );

    loading = false;
    token = res.next;
    hasNext = res.next != '';
    return res.channels;
  }

  // Json Serialization

  Map<String, dynamic> toJson() => _$GroupChannelListQueryToJson(this);
}
