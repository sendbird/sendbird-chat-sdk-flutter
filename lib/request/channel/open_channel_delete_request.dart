import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class OpenChannelDeleteRequest extends ApiRequest {
  @override
  final method = Method.delete;

  OpenChannelDeleteRequest(String channelUrl) : super() {
    url = 'open_channels/$channelUrl';
  }
}
