import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/channel/open/open_channel.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class OpenChannelListRequest extends ApiRequest {
  @override
  final method = Method.get;

  OpenChannelListRequest({
    String? channelName,
    String? channelUrl,
    String? customType,
    List<ChannelQueryIncludeOption>? options,
    String? token,
    int limit = 30,
  }) : super() {
    url = 'open_channels';
    queryParams = {
      if (channelName != null) 'name_contains': channelName,
      if (channelUrl != null) 'url_contains': channelUrl,
      if (customType != null) 'custom_type': customType,
      if (token != null) 'token': token,
      'limit': limit.toString(),
    };

    queryParams.addAll(options?.toJson() ?? {});
  }

  @override
  Future<ChannelListQueryResponse<OpenChannel>> response(res) async {
    return ChannelListQueryResponse()
      ..channels = (res['channels'] as List)
          .map((e) => OpenChannel.fromJsonAndCached(e, ts: res['ts']))
          .toList()
      ..next = res['next'] as String;
  }
}
