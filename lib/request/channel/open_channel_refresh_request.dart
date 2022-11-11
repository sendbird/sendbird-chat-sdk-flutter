import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class OpenChannelRefreshRequest extends ApiRequest {
  @override
  final method = Method.get;

  OpenChannelRefreshRequest({
    required String channelUrl,
    List<ChannelQueryIncludeOption> options = const [],
    bool passive = false,
  }) : super() {
    url = '${passive ? '/sdk/' : ''}open_channels/$channelUrl';
    queryParams = options.toJson();
  }

  @override
  Future<OpenChannel> response(res) async {
    final ts = DateTime.now().millisecondsSinceEpoch;
    return OpenChannel.fromJsonAndCached(res, ts: ts);
  }
}
