import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/query/base_query.dart';
import 'package:sendbird_sdk/request/user/list/blocked_user_list_request.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';

class BlockedUserListQuery extends QueryBase {
  List<String> userIds = [];

  BlockedUserListQuery({this.userIds = const []});

  @override
  Future<List<User>> loadNext() async {
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    loading = true;

    final req = BlockedUserListRequest(
      token: token,
      limit: limit,
      userIds: userIds,
    );

    final sdk = SendbirdSdk().getInternal();
    final res = await sdk.api.send<UserListQueryResponse<User>>(req);
    loading = false;
    token = res.next;
    hasNext = res.next != '';
    return res.users;
  }
}
