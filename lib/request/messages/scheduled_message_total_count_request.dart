import 'package:sendbird_sdk/params/scheduled_message_total_count_params.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelScheduledMessageTotalCountRequest extends ApiRequest {
  @override
  final method = Method.get;

  GroupChannelScheduledMessageTotalCountRequest({
    TotalScheduledMessageCountParams? params,
  }) {
    url = 'scheduled_messages/count';
    if (params != null) {
      queryParams.addAll(params.toJson());
    }
  }

  @override
  Future<int> response(res) async {
    return res['count'];
  }
}
