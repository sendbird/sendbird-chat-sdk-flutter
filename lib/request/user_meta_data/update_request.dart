import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class UserMetaDataUpdateRequest extends ApiRequest {
  @override
  final method = Method.put;

  UserMetaDataUpdateRequest(
    Map<String, String> metaData, {
    String? userId,
    bool upsert = true,
  }) : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/metadata';
    body = {'metadata': metaData, 'upsert': upsert};
  }

  @override
  Future<Map> response(res) async {
    return Map.from(res);
  }
}
