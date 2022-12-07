import 'package:sendbird_sdk/features/poll/poll.dart';
import 'package:sendbird_sdk/params/poll_params.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class PollCreateRequest extends ApiRequest {
  @override
  final method = Method.post;

  PollCreateRequest({required PollCreateParams params}) {
    url = 'polls';

    body.addAll(params.toJson());
    body.removeWhere((key, value) => value == null);
  }

  @override
  Future<Poll> response(res) async {
    return Poll.fromJson(res);
  }
}
