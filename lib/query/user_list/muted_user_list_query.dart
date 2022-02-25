import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/core/models/restricted_user.dart';
import 'package:sendbird_sdk/query/base_query.dart';
import 'package:sendbird_sdk/request/user/list/banned_user_list_request.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';

part 'muted_user_list_query.g.dart';

@JsonSerializable()
class MutedUserListQuery extends QueryBase {
  /// Channel type related to this query
  ChannelType channelType;

  /// Channel url related to this query
  String channelUrl;

  MutedUserListQuery({
    required this.channelType,
    required this.channelUrl,
  });

  @override
  Future<List<RestrictedUser>> loadNext() async {
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    loading = true;

    final req = BannedUserListRequest(
      channelType: channelType,
      channelUrl: channelUrl,
      token: token,
      limit: limit,
    );

    final sdk = SendbirdSdk().getInternal();
    final res = await sdk.api.send<UserListQueryResponse<RestrictedUser>>(req);
    loading = false;
    token = res.next;
    hasNext = res.next != '';
    return res.users;
  }
}
