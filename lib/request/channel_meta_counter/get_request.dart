import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ChannelMetaCounterGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  ChannelMetaCounterGetRequest({
    required ChannelType channelType,
    required String channelUrl,
    List<String> keys = const [],
  }) : super() {
    url = '${channelType.urlString}/$channelUrl/metacounter';
    queryParams = {'include_ts': true};
    if (keys.isNotEmpty) {
      queryParams['keys'] = keys;
    }
  }

  @override
  Future<Map<String, int>> response(res) async {
    return Map<String, int>.from(res);
  }
}
