import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class UserDoNotDisturbSetRequest extends ApiRequest {
  @override
  final method = Method.put;

  UserDoNotDisturbSetRequest({
    required bool enable,
    int startHour = 0,
    int startMin = 0,
    int endHour = 23,
    int endMin = 59,
    String timezone = 'UTC',
    String? userId,
  }) : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/push_preference';
    body = {
      'do_not_disturb': enable,
      'start_hour': startHour,
      'start_min': startMin,
      'end_hour': endHour,
      'end_min': endMin,
      'timezone': timezone
    };
  }
}

class UserDoNotDisturbGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  UserDoNotDisturbGetRequest({String? userId}) : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/push_preference';
  }

  @override
  Future<DoNotDisturbResponse> response(res) async {
    return DoNotDisturbResponse.fromJson(res);
  }
}
