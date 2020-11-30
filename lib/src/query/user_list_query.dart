import 'package:flutter/foundation.dart';

import '../../sendbirdsdk.dart';
import '../constant/enums.dart';
import '../models/error.dart';
import '../models/responses.dart';
import '../models/user.dart';
import '../query/base_query.dart';

part 'application_user_list_query.dart';

/// A query object to retrieve user list
class UserListQuery extends QueryBase {
  /// Channel type related to this query
  ChannelType channelType;

  /// Channel url related to this query
  String channelUrl;

  /// Query type
  UserListQueryType queryType;

  /// Filter for list of user ids
  List<String> userIds;

  UserListQuery({
    @required this.queryType,
    this.channelType,
    this.channelUrl,
    this.userIds,
  });

  @override
  Future<List<User>> loadNext() async {
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    final sdk = SendbirdSdk().getInternal();

    switch (queryType) {
      case UserListQueryType.banned:
      case UserListQueryType.muted:
        if (channelType == null || channelUrl == null)
          throw InvalidParameterError();
        break;
      case UserListQueryType.participants:
        if (channelUrl == null) throw InvalidParameterError();
        break;
      default:
        break;
    }

    loading = true;

    UserListQueryResponse res;
    switch (queryType) {
      case UserListQueryType.filtered:
        res = await sdk.api.getUsers(
          token: token,
          limit: limit,
          userIds: userIds,
        );
        break;
      case UserListQueryType.banned:
        res = await sdk.api.getBannedUsers(
          type: channelType,
          channelUrl: channelUrl,
          token: token,
          limit: limit,
        );
        break;
      case UserListQueryType.blocked:
        res = await sdk.api.getBlockedUsers(
          token: token,
          limit: limit,
        );
        break;
      case UserListQueryType.muted:
        res = await sdk.api.getMutedUsers(
          type: channelType,
          channelUrl: channelUrl,
          token: token,
          limit: limit,
        );
        break;
      case UserListQueryType.participants:
        res = await sdk.api.getOpenChannelParticipants(
          channelUrl: channelUrl,
          token: token,
          limit: limit,
        );
        break;
    }
    loading = false;
    token = res.next;
    hasNext = res.next != '';
    return res.users;
  }
}
