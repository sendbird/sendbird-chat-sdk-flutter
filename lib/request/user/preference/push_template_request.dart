import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class UserPushTemplateSetRequest extends ApiRequest {
  @override
  final method = Method.put;

  UserPushTemplateSetRequest(String name, {String? userId})
      : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/push/template';
    body = {'name': name};
  }
}

class UserPushTemplateGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  UserPushTemplateGetRequest({String? userId}) : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/push/template';
  }

  @override
  Future<String> response(res) async {
    return res['name'];
  }
}
