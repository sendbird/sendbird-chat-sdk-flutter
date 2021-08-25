import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class UserBlockRequest extends ApiRequest {
  @override
  final method = Method.post;

  UserBlockRequest({String? userId, required String targetId})
      : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/block';
    body = {'target_id': targetId};
  }

  @override
  Future<User> response(res) async {
    return User.fromJson(res);
  }
}
