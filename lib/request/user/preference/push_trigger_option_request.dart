import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class UserPushTriggerOptionSetRequest extends ApiRequest {
  @override
  final method = Method.put;

  UserPushTriggerOptionSetRequest(PushTriggerOption option, {String? userId})
      : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/push_preference';
    body = {'push_trigger_option': pushTriggerOptionEnumMap[option]};
  }
}

class UserPushTriggerOptionGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  UserPushTriggerOptionGetRequest({String? userId}) : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/push_preference';
  }

  @override
  Future<PushTriggerOption> response(res) async {
    return enumDecode(
      pushTriggerOptionEnumMap,
      res['push_trigger_option'],
      unknownValue: PushTriggerOption.all,
    );
  }
}
