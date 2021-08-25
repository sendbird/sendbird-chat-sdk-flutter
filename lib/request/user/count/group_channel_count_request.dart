import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class UserGroupChannelCountGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  UserGroupChannelCountGetRequest(MemberStateFilter filter, {String? userId})
      : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/group_channel_count';
    queryParams = {'state': memberStateFilterEnumForGroupCount(filter)};
  }

  @override
  Future<int> response(res) async {
    return res['group_channel_count'];
  }
}
