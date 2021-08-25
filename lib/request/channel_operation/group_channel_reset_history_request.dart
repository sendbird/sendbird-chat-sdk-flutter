import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelHistoryResetRequest extends ApiRequest {
  @override
  final method = Method.put;

  GroupChannelHistoryResetRequest({required String channelUrl, String? userId})
      : super(userId: userId) {
    url = 'group_channels/$channelUrl/reset_user_history';
  }

  @override
  Future<int> response(res) async {
    return res['ts_message_offset'];
  }
}
