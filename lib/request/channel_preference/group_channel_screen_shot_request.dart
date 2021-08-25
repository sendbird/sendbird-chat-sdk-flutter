import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelScreenshotRequest extends ApiRequest {
  @override
  final method = Method.post;

  GroupChannelScreenshotRequest({required String channelUrl}) : super() {
    url = 'group_channels/$channelUrl/screenshot';
  }
}
