import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/params/poll_changelogs_params.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class PollChangelogsGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  PollChangelogsGetRequest({
    required PollChangeLogsParams params,
    String? token,
    int? ts,
    int limit = 100,
  }) {
    url =
        "${params.channelType.urlString}/${params.channelUrl}/polls/changelogs";
    queryParams = {
      'token': token,
      'change_ts': ts,
      'limit': limit,
      'show_partial_voter_list': params.showPartialVoterList
    };
    queryParams.removeWhere((key, value) => value == null);
  }

  @override
  Future<PollChangeLogsResponse> response(res) async {
    return PollChangeLogsResponse.fromJson(res);
  }
}
