import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ChannelMetaCounterCreateRequest extends ApiRequest {
  @override
  final method = Method.post;

  ChannelMetaCounterCreateRequest({
    required ChannelType channelType,
    required String channelUrl,
    required Map<String, int> metaCounter,
  }) : super() {
    url = '${channelType.urlString}/$channelUrl/metacounter';
    body = {'metacounter': metaCounter};
  }

  @override
  Future<Map<String, int>> response(res) async {
    return Map<String, int>.from(res);
  }
}
