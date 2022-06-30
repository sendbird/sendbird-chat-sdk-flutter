import 'package:sendbird_sdk/features/poll/poll.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class PollCloseRequest extends ApiRequest {
  @override
  final method = Method.put;

  PollCloseRequest({required int pollId}) {
    url = 'polls/$pollId/close';
  }

  @override
  Future<Poll> response(res) async {
    return Poll.fromJson(res);
  }
}
