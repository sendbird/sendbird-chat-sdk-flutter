import '../constant/enums.dart';
import '../core/models/error.dart';
import '../core/models/user.dart';
import '../sdk/sendbird_sdk_api.dart';

import 'base_query.dart';

/// A query object to retrieve list of members from my group channel.
class GroupChannelMemberListListQuery extends QueryBase {
  /// Channel url
  String channelUrl;

  /// Filters nickname that starts with
  String nicknameStartsWith;

  /// Filters with member's role
  OperatorFilter operatorFilter;

  /// Filters with member's muted state
  MutedMemberFilter mutedMemberFilter;

  /// Filters with member's member state
  MemberStateFilter memberStateFilter;

  /// Defines query result's order
  MemberListOrder order;

  @override
  Future<List<User>> loadNext() async {
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    loading = true;

    final sdk = SendbirdSdk().getInternal();
    final res = await sdk.api.getGroupChannelMembers(
      channelUrl: channelUrl,
      token: token,
      limit: limit,
      nicknameStartsWith: nicknameStartsWith,
      operatorFilter: operatorFilter,
      mutedMemberFilter: mutedMemberFilter,
      memberStateFilter: memberStateFilter,
      order: order,
    );

    loading = false;
    token = res.next;
    hasNext = res.next != '';
    return res.users;
  }
}
