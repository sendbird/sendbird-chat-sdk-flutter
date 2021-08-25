import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class BlockedUserListRequest extends ApiRequest {
  @override
  final method = Method.get;

  BlockedUserListRequest({
    List<String> userIds = const [],
    String? token,
    int limit = 30,
    String? userId,
  }) : super() {
    url = 'users/${userId ?? state.userId}/block';
    queryParams = {
      'limit': limit,
      if (token != null) 'token': token,
      if (userIds.isNotEmpty) 'user_ids': userIds,
    };
  }

  @override
  Future<UserListQueryResponse> response(res) async {
    return UserListQueryResponse.fromJson(res);
  }
}
