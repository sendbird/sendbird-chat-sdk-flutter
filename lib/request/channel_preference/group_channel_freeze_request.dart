import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelFreezeSetRequest extends ApiRequest {
  @override
  final method = Method.put;

  GroupChannelFreezeSetRequest(
      {required String channelUrl, required bool freeze, String? userId})
      : super(userId: userId) {
    url = 'group_channels/$channelUrl/freeze';
    body = {'freeze': freeze};
  }
}
