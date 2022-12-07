import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/models/group_channel_filters.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';
import 'package:sendbird_sdk/utils/extensions.dart';

class GroupChannelListRequest extends ApiRequest {
  @override
  final method = Method.get;

  GroupChannelListRequest({
    required GroupChannelListOrder order,
    String? token,
    int limit = 30,
    List<String>? channelUrls,
    String? searchQuery,
    required GroupChannelListQueryType queryType,
    List<GroupChannelListQuerySearchField> searchFields = const [],
    List<ChannelQueryIncludeOption> options = const [],
    required GroupChannelFilter filter,
    String? userId,
  }) : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/my_group_channels';

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

    if (order == GroupChannelListOrder.channelMetaDataValueAlphabetical &&
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
