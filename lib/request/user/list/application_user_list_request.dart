import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ApplicationUserListRequest extends ApiRequest {
  @override
  final method = Method.get;

  ApplicationUserListRequest({
    String? token,
    int limit = 30,
    String? metaDataKey,
    List<String>? metaDataValues,
    String? nicknameStartsWith,
    List<String>? userIds,
  }) : super() {
    url = 'users';
    queryParams = {
      'limit': limit,
      if (token != null) 'token': token,
      if (userIds != null && userIds.isNotEmpty) 'user_ids': userIds,
      if (metaDataKey != null) 'metadatakey': metaDataKey,
      if (metaDataValues != null && metaDataValues.isNotEmpty)
        'metadatavalues_in': metaDataValues,
      if (nicknameStartsWith != null) 'nickname_startswith': nicknameStartsWith,
    };
  }

  @override
  Future<UserListQueryResponse> response(res) async {
    return UserListQueryResponse.fromJson(res);
  }
}
