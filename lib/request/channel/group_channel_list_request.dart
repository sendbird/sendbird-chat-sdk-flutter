import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/models/group_channel_filters.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/query/channel_list/group_channel_list_query.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';
import 'package:sendbird_sdk/utils/extensions.dart';

class GroupChannelListRequest extends ApiRequest {
  @override
  final method = Method.get;

  GroupChannelListRequest(GroupChannelListQuery query, {String? userId})
      : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/my_group_channels';

    final searchFieldStrings = stringFromSearchFields(query.searchFields);
    queryParams = {
      'user_id': userId,
      'token': query.token,
      'limit': query.limit,
      'channelUrls': query.channelUrls,
      'order': groupChannelListOrderEnumMap[query.order],
      if (searchFieldStrings.isNotEmpty) 'search_field': searchFieldStrings,
      if (searchFieldStrings.isNotEmpty) 'search_query': query.searchQuery,
      'distinct_mode': 'all',
      'show_member': true,
    };

    final filter = GroupChannelFilter()
      ..customTypeStartswith = query.customTypeStartWith
      ..customTypes = query.customTypes
      ..memberStateFilter = query.memberStateFilter
      ..membersExactlyIn = query.userIdsExactlyIn
      ..membersIncludeIn = query.userIdsIncludeIn
      ..membersNicknameContains = query.nicknameContains
      ..nameContains = query.channelNameContains
      ..superMode = query.superChannelFilter
      ..publicMode = query.publicChannelFilter
      ..unreadFilter = query.unreadChannelFilter
      ..metadataOrderKey = query.metaDataOrderKey
      ..hiddenMode = query.channelHiddenStateFilter;

    final options = [
      if (query.includeFrozenChannel) ChannelQueryIncludeOption.frozenChannel,
      if (query.includeEmptyChannel) ChannelQueryIncludeOption.emptyChannel,
      if (query.includeMemberList) ChannelQueryIncludeOption.memberList,
      if (query.includeMetaData) ChannelQueryIncludeOption.metaData,
      ChannelQueryIncludeOption.readReceipt,
      ChannelQueryIncludeOption.deliveryReceipt,
    ];

    queryParams.addAll(options.toJson());
    queryParams.addAll(filter.toJson());

    if (filter.membersIncludeIn != null &&
        filter.membersIncludeIn!.isNotEmpty) {
      queryParams['members_include_in'] = filter.membersIncludeIn;
      queryParams['query_type'] = query.queryType.asString();
    }

    if (query.order == GroupChannelListOrder.channelMetaDataValueAlphabetical &&
        filter.metadataOrderKey != null) {
      queryParams['metadata_order_key'] = filter.metadataOrderKey;
    }

    queryParams.removeWhere((key, value) => value == null);
  }

  @override
  Future<ChannelListQueryResponse<GroupChannel>> response(res) async {
    return ChannelListQueryResponse()
      ..channels = (res['channels'] as List)
          .map((e) => GroupChannel.fromJsonAndCached(e, ts: res['ts']))
          .toList()
      ..next = res['next'] as String;
  }
}
