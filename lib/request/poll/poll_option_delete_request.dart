import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class PollOptionDeleteRequest extends ApiRequest {
  @override
  final method = Method.delete;

  PollOptionDeleteRequest({
    required int pollId,
    required int pollOptionId,
  }) {
    url = 'polls/$pollId/options/$pollOptionId';
  }
}
