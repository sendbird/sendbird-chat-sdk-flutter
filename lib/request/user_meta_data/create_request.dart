import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class UserMetaDataCreateRequest extends ApiRequest {
  @override
  final method = Method.post;

  UserMetaDataCreateRequest(Map<String, String> metaData, {String? userId})
      : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/metadata';
    body = {'metadata': metaData, 'upsert': true};
  }

  @override
  Future<Map> response(res) async {
    return Map.from(res);
  }
}
