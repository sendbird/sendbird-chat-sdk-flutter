import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class UserSessionTokenIssueRequest extends ApiRequest {
  @override
  final method = Method.post;

  UserSessionTokenIssueRequest({
    required String userId,
    int? expiresAt,
  }) : super() {
    url = 'users/$userId/token';
    body = {'expires_at': expiresAt};
    body.removeWhere((key, value) => value == null);
  }

  @override
  Future<Map<String, dynamic>> response(res) async {
    return res;
  }
}
