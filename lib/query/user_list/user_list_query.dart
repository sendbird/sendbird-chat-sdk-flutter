import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/query/base_query.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/request/user/list/application_user_list_request.dart';
import 'package:sendbird_sdk/request/user/list/banned_user_list_request.dart';
import 'package:sendbird_sdk/request/user/list/blocked_user_list_request.dart';
import 'package:sendbird_sdk/request/user/list/muted_user_list_request.dart';
import 'package:sendbird_sdk/request/user/list/participant_list_request.dart';
import 'package:sendbird_sdk/request/user/list/user_list_query.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';

part 'user_list_query.g.dart';
part 'application_user_list_query.dart';

/// #################### SECURITY TIPS ####################
/// Before launching, you should review "Allow retrieving user list from SDK" under ⚙️ Sendbird Dashboard ->Settings -> Security.
/// It's turned on at first to simplify running samples and implementing your first code.
/// Most apps will want to disable "Allow retrieving user list from SDK" as that could possibly expose user information
/// #################### SECURITY TIPS ####################

/// A query object to retrieve user list
@JsonSerializable()
class UserListQuery extends QueryBase {
  /// Channel type related to this query
  ChannelType? channelType;

  /// Channel url related to this query
  String? channelUrl;

  /// Query type
  UserListQueryType queryType;

  /// Filter for list of user ids
  List<String>? userIds;

  UserListQuery({
    required this.queryType,
    this.channelType,
    this.channelUrl,
    this.userIds,
  });

  @override
  Future<List<User>> loadNext() async {
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    switch (queryType) {
      case UserListQueryType.banned:
      case UserListQueryType.muted:
        if (channelType == null || channelUrl == null) {
          throw InvalidParameterError();
        }
        break;
      case UserListQueryType.participants:
        if (channelUrl == null) throw InvalidParameterError();
        break;
      default:
        break;
    }

    loading = true;

    ApiRequest req;
    switch (queryType) {
      case UserListQueryType.filtered:
        req = UserListRequest(
          token: token,
          limit: limit,
          userIds: userIds,
        );
        break;
      case UserListQueryType.banned:
        req = BannedUserListRequest(
          channelType: channelType!,
          channelUrl: channelUrl!,
          token: token,
          limit: limit,
        );
        break;
      case UserListQueryType.blocked:
        req = BlockedUserListRequest(
          token: token,
          limit: limit,
        );
        break;
      case UserListQueryType.muted:
        req = MutedUserListRequest(
          channelType: channelType!,
          channelUrl: channelUrl!,
          token: token,
          limit: limit,
        );
        break;
      case UserListQueryType.participants:
        req = OpenChannelParticipantListRequest(
          channelUrl: channelUrl!,
          token: token,
          limit: limit,
        );
        break;
    }

    final sdk = SendbirdSdk().getInternal();
    final res = await sdk.api.send<UserListQueryResponse>(req);

    loading = false;
    token = res.next;
    hasNext = res.next != '';
    return res.users;
  }

  // Json Serialization

  Map<String, dynamic> toJson() => _$UserListQueryToJson(this);
}
