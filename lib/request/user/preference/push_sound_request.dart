import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class UserPushSoundSetRequest extends ApiRequest {
  @override
  final method = Method.put;

  UserPushSoundSetRequest(String sound, {String? userId})
      : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/push_preference';
    body = {'push_sound': sound};
  }
}

class UserPushSoundGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  UserPushSoundGetRequest({String? userId}) : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/push_preference';
  }

  @override
  Future<String> response(res) async {
    return res['push_sound'];
  }
}
