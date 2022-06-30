import 'package:sendbird_sdk/features/poll/poll.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class PollOptionUpdateRequest extends ApiRequest {
  @override
  final method = Method.put;

  PollOptionUpdateRequest({
    required int pollId,
    required int optionId,
    required String text,
  }) {
    url = 'polls/$pollId/options/$optionId';
    body = {'text': text};
  }

  @override
  Future<Poll> response(res) async {
    return Poll.fromJson(res);
  }
}
