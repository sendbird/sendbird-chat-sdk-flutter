import 'base_query.dart';

import '../channel/group_channel.dart';
import '../constant/enums.dart';
import '../models/error.dart';
import '../models/group_channel_filters.dart';
import '../sdk/sendbird_sdk_api.dart';

/// A query object to retrieve list of public group channel.
class PublicGroupChannelListQuery extends QueryBase {
  /// Filters for channel urls.
  ///
  /// Result will return a list containing only and exactly matched
  /// with given urls. This filter does not cooperate with other filters.
  List<String> channelUrls;

  /// Filters channels for super group channel. Default is `all`
  GroupChannelSuperChannelFilter superChannelFilter;

  /// Filters by current user's member state in public group channel
  PublicGroupChannelMembershipFilter membershipFilter;

  /// Order of query result
  PublicGroupChannelListOrder order;

  /// Filter by custom type that starts with
  String customTypeStartWithFilter;

  /// Filters by custom types.
  List<String> customTypesFilter;

  /// Filters by channel name contains certain text
  String channelNameContainsFilter;

  /// Sets metadata's key for ordering its value
  ///
  /// This is valid when the `order` is `channelMetaDataValueAlphabetical` only
  String metaDataOrderKeyFilter;

  /// Query result includes empty (message) channel if `true`
  /// default value is `true`
  bool includeEmptyChannel = true;

  /// Query result includes frozen channels if `true`
  /// default value is `true`
  bool includeFrozenChannel = true;

  /// Query result of channel object contains member list if `true`
  /// default value is `true`
  bool includeMemberList = true;

  // Query result of channel object contains meta data if `true`
  // deault value is `false`
  // bool includeMetaData = false;

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
    // if (includeMetaData) options.add(ChannelQueryIncludeOption.metaData);

    final filter = GroupChannelFilter()
      ..customTypeStartswith = customTypeStartWithFilter
      ..customTypes = customTypesFilter
      ..nameContains = channelNameContainsFilter
      ..superMode = superChannelFilter
      ..publicMembershipFilter = membershipFilter
      ..metadataOrderKey = metaDataOrderKeyFilter
      ..publicMode = GroupChannelPublicChannelFilter.public;

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
