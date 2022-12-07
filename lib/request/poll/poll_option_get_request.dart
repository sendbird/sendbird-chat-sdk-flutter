import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/features/poll/poll_option.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class PollOptionGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  PollOptionGetRequest({
    required int pollId,
    required int pollOptionId,
    required String channelUrl,
    required ChannelType channelType,
  }) {
    url = 'polls/$pollId/options/$pollOptionId';
    queryParams = {
      'channel_url': channelUrl,
      'channel_type': channelType.urlString,
    };
  }

  @override
  Future<PollOption> response(res) async {
    return PollOption.fromJson(res);
  }
}
