import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/models/group_channel_filters.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class PublicGroupChannelListRequest extends ApiRequest {
  @override
  final method = Method.get;

  PublicGroupChannelListRequest({
    required PublicGroupChannelListOrder order,
    String? token,
    int limit = 30,
    List<String>? channelUrls,
    List<ChannelQueryIncludeOption> options = const [],
    required GroupChannelFilter filter,
    String? userId,
  }) : super(userId: userId) {
    url = 'group_channels';
    queryParams = {
      'user_id': userId ?? state.userId,
      if (channelUrls != null && channelUrls.isNotEmpty)
        'channelUrls': channelUrls,
      'order': publicGroupChannelListOrderEnumMap[order],
      'distinct_mode': 'all',
      'token': token,
      'limit': limit,
    };

    queryParams.addAll(options.toJson());
    queryParams.addAll(filter.toJson());

    if (order == PublicGroupChannelListOrder.channelMetaDataValueAlphabetical &&
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
