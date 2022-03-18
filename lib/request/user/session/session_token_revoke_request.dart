import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class UserSessionTokenRevokeRequest extends ApiRequest {
  @override
  final method = Method.delete;

  UserSessionTokenRevokeRequest({
    required String userId,
  }) : super() {
    url = 'users/$userId/token';
  }
}
