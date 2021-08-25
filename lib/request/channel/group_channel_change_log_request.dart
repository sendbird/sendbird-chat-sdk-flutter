import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/params/group_channel_change_logs_params.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelChangeLogsGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  GroupChannelChangeLogsGetRequest(GroupChannelChangeLogsParams params,
      {String? token, int? timestamp, String? userId})
      : super() {
    url = 'users/${userId ?? state.userId}/my_group_channels/changelogs';
    queryParams = params.toJson();
    if (timestamp != null && timestamp > 0) {
      queryParams['change_ts'] = timestamp;
    } else if (token != null) {
      queryParams['token'] = token;
    }
  }

  @override
  Future<ChannelChangeLogsResponse> response(res) async {
    return ChannelChangeLogsResponse.fromJson(res);
  }
}
