import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class AppSessionKeyUpdateRequest extends ApiRequest {
  @override
  final method = Method.post;

  AppSessionKeyUpdateRequest({
    required String appId,
    required String accessToken,
    bool expiringSession = false,
    String? userId,
  }) : super() {
    url = 'users/${userId ?? state.userId}/session_key';
    body = {'expiring_session': expiringSession};
    headers = {'App-Id': appId, 'Access-Token': accessToken};
  }

  @override
  Future<Map<String, dynamic>> response(res) async {
    return Map.from(res);
  }
}
