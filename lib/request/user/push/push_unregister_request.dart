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
    var typeString = '';
    
    if (type == PushTokenType.fcm) {
      typeString = 'gcm';
    } else if (type == PushTokenType.hms) {
      typeString = 'huawei';
    } else {
      typeString = type.asString();
    }

    url = 'users/${userId ?? state.userId}/push/$typeString/$token';
  }
}

class UserPushTokenUnregisterAllRequest extends ApiRequest {
  @override
  final method = Method.delete;

  UserPushTokenUnregisterAllRequest({String? userId}) : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/push';
  }
}
