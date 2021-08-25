import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class UserSnoozePeriodSetRequest extends ApiRequest {
  @override
  final method = Method.put;

  UserSnoozePeriodSetRequest({
    required bool enable,
    DateTime? startDate,
    DateTime? endDate,
    String? userId,
  }) : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/push_preference';
    body = {
      'snooze_enabled': enable,
      if (startDate != null)
        'snooze_start_ts': startDate.millisecondsSinceEpoch,
      if (endDate != null) 'snooze_end_ts': endDate.millisecondsSinceEpoch
    };
  }
}

class UserSnoozePeriodGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  UserSnoozePeriodGetRequest({String? userId}) : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/push_preference';
  }

  @override
  Future<SnoozeResponse> response(res) async {
    return SnoozeResponse.fromJson(res);
  }
}
