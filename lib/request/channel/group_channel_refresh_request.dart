import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelRefreshRequest extends ApiRequest {
  @override
  final method = Method.get;

  GroupChannelRefreshRequest(
    String channelUrl, {
    List<ChannelQueryIncludeOption> options = const [],
    bool passive = false,
  }) : super() {
    url = '${passive ? '/sdk/' : ''}group_channels/$channelUrl';
    queryParams = options.toJson();
  }

  @override
  Future<GroupChannel> response(res) async {
    final ts = DateTime.now().millisecondsSinceEpoch;
    return GroupChannel.fromJsonAndCached(res, ts: ts);
  }
}
