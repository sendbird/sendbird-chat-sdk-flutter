import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class UserUnblockRequest extends ApiRequest {
  @override
  final method = Method.delete;

  UserUnblockRequest({String? userId, required String targetId})
      : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/block/$targetId';
    body = {'target_id': targetId};
  }
}
