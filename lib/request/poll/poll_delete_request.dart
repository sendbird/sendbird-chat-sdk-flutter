import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class PollDeleteRequest extends ApiRequest {
  @override
  final method = Method.delete;

  PollDeleteRequest({required int pollId}) {
    url = 'polls/$pollId';
  }
}
