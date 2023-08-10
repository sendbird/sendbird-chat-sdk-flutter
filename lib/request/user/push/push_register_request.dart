import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class UserPushTokenRegisterRequest extends ApiRequest {
  @override
  final method = Method.post;

  UserPushTokenRegisterRequest({
    required PushTokenType type,
    required String token,
    bool alwaysPush = false,
    bool unique = false,
    String? userId,
  }) : super(userId: userId) {
    final typeUrl = pushTokenToString(type);
    if (typeUrl == null) {
      return;
    }

    url = 'users/${userId ?? state.userId}/push/$typeUrl';

    body = {
      if (type == PushTokenType.fcm) 'gcm_reg_token': token,
      if (type == PushTokenType.apns) 'apns_device_token': token,
      if (type == PushTokenType.hms) 'huawei_device_token': token,
      'is_unique': unique,
      'always_push': alwaysPush,
    };
  }

  @override
  Future<int?> response(res) async {
    return res['device_token_last_deleted_at'] as int?;
  }
}
