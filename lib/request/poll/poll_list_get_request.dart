import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class PollListGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  PollListGetRequest({
    required String channelUrl,
    required ChannelType channelType,
    String? token,
    int limit = 20,
  }) : assert(1 <= limit && limit <= 20) {
    url = 'polls';

    queryParams = {
      'channel_url': channelUrl,
      'token': token,
      'limit': limit,
      'channel_type': channelType.urlString,
    };

    queryParams.removeWhere((key, value) => value == null);
  }

  @override
  Future<PollListQueryResponse> response(res) async {
    return PollListQueryResponse.fromJson(res);
  }
}
