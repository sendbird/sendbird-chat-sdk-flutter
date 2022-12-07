import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class PollOptionGetListVotersRequest extends ApiRequest {
  @override
  final method = Method.get;

  PollOptionGetListVotersRequest({
    required int pollId,
    required int pollOptionId,
    required String channelUrl,
    required ChannelType channelType,
    String? token,
    int limit = 100,
  }) : assert(1 <= limit && limit <= 100) {
    url = 'polls/$pollId/options/$pollOptionId/voters';
    queryParams = {
      'token': token,
      'channel_url': channelUrl,
      'limit': limit,
      'channel_type': channelType.urlString,
    };

    queryParams.removeWhere((key, value) => value == null);
  }

  @override
  Future<PollVoterListQueryResponse> response(res) async {
    return PollVoterListQueryResponse.fromJson(res);
  }
}
