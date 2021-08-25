import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelDeleteRequest extends ApiRequest {
  @override
  final method = Method.delete;

  GroupChannelDeleteRequest(String channelUrl) : super() {
    url = 'group_channels/$channelUrl';
  }
}
