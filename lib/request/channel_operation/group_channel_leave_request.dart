import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelLeaveRequest extends ApiRequest {
  @override
  final method = Method.put;

  GroupChannelLeaveRequest({
    required String channelUrl,
    String? userId,
    bool? shouldRemoveOperatorStatus,
  }) : super(userId: userId) {
    url = 'group_channels/$channelUrl/leave';
    body = {
      'should_remove_operator_status': shouldRemoveOperatorStatus ?? false
    };
  }
}
