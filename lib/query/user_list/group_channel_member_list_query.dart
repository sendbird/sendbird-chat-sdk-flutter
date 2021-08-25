import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/query/base_query.dart';
import 'package:sendbird_sdk/request/user/list/member_list_request.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';

part 'group_channel_member_list_query.g.dart';

/// A query object to retrieve list of members from my group channel.
@JsonSerializable()
class GroupChannelMemberListQuery extends QueryBase {
  /// Channel url
  String channelUrl;

  /// Filters nickname that starts with
  String? nicknameStartsWith;

  /// Filters with member's role
  OperatorFilter operatorFilter = OperatorFilter.all;

  /// Filters with member's muted state
  MutedMemberFilter mutedMemberFilter = MutedMemberFilter.all;

  /// Filters with member's member state
  @JsonKey(toJson: memberStateFilterEnumForQuery)
  MemberStateFilter memberStateFilter = MemberStateFilter.all;

  /// Defines query result's order
  MemberListOrder order = MemberListOrder.nicknameAlphabetical;

  GroupChannelMemberListQuery({required this.channelUrl});

  @override
  Future<List<User>> loadNext() async {
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    loading = true;

    final sdk = SendbirdSdk().getInternal();
    final res = await sdk.api.send<UserListQueryResponse>(
      GroupChannelMemberListRequest(
        channelUrl: channelUrl,
        token: token,
        limit: limit,
        nicknameStartsWith: nicknameStartsWith,
        operatorFilter: operatorFilter,
        mutedMemberFilter: mutedMemberFilter,
        memberStateFilter: memberStateFilter,
        order: order,
      ),
    );

    loading = false;
    token = res.next;
    hasNext = res.next != '';
    return res.users;
  }

  // Json Serialization

  Map<String, dynamic> toJson() => _$GroupChannelMemberListQueryToJson(this);
}
