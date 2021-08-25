import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class OpenChannelParticipantListRequest extends ApiRequest {
  @override
  final method = Method.get;

  OpenChannelParticipantListRequest({
    required String channelUrl,
    String? token,
    int limit = 30,
  }) : super() {
    url = 'open_channels/$channelUrl/participants';
    queryParams = {
      'limit': limit,
      if (token != null) 'token': token,
    };
  }

  @override
  Future<UserListQueryResponse> response(res) async {
    final output = {'users': res['participants'], 'next': res['next']};
    return UserListQueryResponse.fromJson(output);
  }
}
