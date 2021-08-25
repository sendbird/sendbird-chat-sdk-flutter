import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class UserMetaDataDeleteRequest extends ApiRequest {
  @override
  final method = Method.delete;

  UserMetaDataDeleteRequest(String key, {String? userId})
      : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/metadata/$key';
  }
}

class UserMetaDataDeleteAllRequest extends ApiRequest {
  @override
  final method = Method.delete;

  UserMetaDataDeleteAllRequest({String? userId}) : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/metadata';
  }
}
