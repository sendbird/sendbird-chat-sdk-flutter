import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class MutedUserListRequest extends ApiRequest {
  @override
  final method = Method.get;

  MutedUserListRequest({
    required ChannelType channelType,
    required String channelUrl,
    String? token,
    int limit = 30,
  }) : super() {
    url = '${channelType.urlString}/$channelUrl/mute';
    queryParams = {
      'limit': limit,
      if (token != null) 'token': token,
    };
  }

  @override
  Future<UserListQueryResponse> response(res) async {
    final output = {'users': res['muted_list'], 'next': res['next']};
    return UserListQueryResponse.fromJson(output);
  }
}
