import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelMarkAsDeliveredRequest extends ApiRequest {
  @override
  final method = Method.put;

  GroupChannelMarkAsDeliveredRequest({
    required String channelUrl,
    required String userId,
    required int timestamp,
  }) : super(userId: userId) {
    url = 'group_channels/$channelUrl/messages/mark_as_delivered';
    body = {'user_id': userId, 'ts': timestamp};
  }
}
