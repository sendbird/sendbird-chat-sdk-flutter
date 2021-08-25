import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class UserTotalUnreadChannelCountGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  UserTotalUnreadChannelCountGetRequest({String? userId})
      : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/unread_channel_count';
  }

  @override
  Future<int> response(res) async {
    return res['unread_count'];
  }
}
