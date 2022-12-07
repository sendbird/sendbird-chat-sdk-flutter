import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/features/poll/poll.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class PollVoteRequest extends ApiRequest {
  @override
  final method = Method.put;

  PollVoteRequest(
      {required int pollId,
      required List<int> pollOptionIds,
      required String channelUrl,
      required ChannelType channelType}) {
    url = 'polls/$pollId/vote';
    body = {
      'option_ids': pollOptionIds,
      'channel_url': channelUrl,
      'channel_type': channelType.urlString,
    };
  }

  @override
  Future<Poll> response(res) async {
    return Poll.fromJson(res);
  }
}
