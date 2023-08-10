import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';
import 'package:sendbird_sdk/utils/extensions.dart';

class UserPushTokenUnregisterRequest extends ApiRequest {
  @override
  final method = Method.delete;

  UserPushTokenUnregisterRequest({
    required PushTokenType type,
    required String token,
    String? userId,
  }) : super(userId: userId) {
    final typeString = type == PushTokenType.fcm ? 'gcm' : type.asString();
    url = 'users/${userId ?? state.userId}/push/$typeString/$token';
  }

  @override
  Future<int?> response(res) async {
    return res['device_token_last_deleted_at'] as int?;
  }
}

class UserPushTokenUnregisterAllRequest extends ApiRequest {
  @override
  final method = Method.delete;

  UserPushTokenUnregisterAllRequest({String? userId}) : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/push';
  }

  @override
  Future<int?> response(res) async {
    return res['device_token_last_deleted_at'] as int?;
  }
}
