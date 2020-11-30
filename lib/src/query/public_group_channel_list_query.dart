import 'base_query.dart';

import '../channel/group_channel.dart';
import '../constant/enums.dart';
import '../models/error.dart';
import '../models/group_channel_filters.dart';
import '../sdk/sendbird_sdk_api.dart';

/// A query object to retrieve list of group channel.
class GroupChannelListQuery extends QueryBase {
  /// True if query result includes empty (message) channel
  /// default value is `true`
  bool includeEmptyChannel = true;

  /// True if query result includes frozen channels.
  /// default value is `true`
  bool includeFrozenChannel = true;

  /// True if query result of channel object contains member list
  /// default value is `true`
  bool includeMemberList = true;

  /// Order of the query result
  GroupChannelListOrder order;

  /// Sets query type user Id filter, it only will work when `includeMemberList` is true
  GroupChannelListQueryType queryType;

  /// Sets filter channel urls. It will return a list containing only and exactly matched
  /// with given urls. This filter does not cooperate with other filters.
  List<String> channelUrls;

  /// Sets the member state filter
  MemberStateFilter memberStateFilter;

  /// Sets to filter super channel. Default is `all`
  GroupChannelSuperChannelFilter superChannelFilter;

  /// Sets to filter channels by custom type that starts with
  String customTypeStartWithFilter;

  /// Sets the custom type filter.
  List<String> customTypesFilter;

  /// Sets a filter to return only channels that contains the
  /// specified group channel name
  String channelNameContainsFilter;

  /// Sets a key for ordering by value in the metadata.
  /// This is valid when the `order` is `channelMetaDataValueAlphabetical` only
  String metaDataOrderKeyFilter;

  @override
  Future<List<GroupChannel>> loadNext() async {
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    loading = true;

    List<ChannelQueryIncludeOption> options = [];
    if (includeFrozenChannel)
      options.add(ChannelQueryIncludeOption.frozenChannel);
    if (includeEmptyChannel)
      options.add(ChannelQueryIncludeOption.emptyChannel);
    if (includeMemberList) options.add(ChannelQueryIncludeOption.memberList);

    final filter = GroupChannelFilter()
      ..customTypeStartswith = customTypeStartWithFilter
      ..customTypes = customTypesFilter
      ..memberStateFilter = memberStateFilter
      ..memberStateFilter = memberStateFilter
      ..nameContains = channelNameContainsFilter
      ..superMode = superChannelFilter
      ..metadataOrderKey = metaDataOrderKeyFilter;

    final sdk = SendbirdSdk().getInternal();
    final res = await sdk.api.getPublicGroupChannels(
      order: order,
      token: token,
      limit: limit,
      channelUrls: channelUrls,
      options: options,
      filter: filter,
    );

    loading = false;
    token = res.next;
    hasNext = res.next != '';
    return res.channels;
  }
}
