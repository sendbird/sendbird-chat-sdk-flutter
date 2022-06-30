import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/features/poll/poll.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class PollOptionAddRequest extends ApiRequest {
  @override
  final method = Method.post;

  PollOptionAddRequest({
    required int pollId,
    required String text,
    required String channelUrl,
    required ChannelType channelType,
  }) : assert(text.length <= 2000) {
    url = 'polls/$pollId/options';
    body = {
      'text': text,
      'channel_url': channelUrl,
      'channel_type': channelType.urlString,
    };
  }

  @override
  Future<Poll> response(res) async {
    return Poll.fromJson(res);
  }
}
