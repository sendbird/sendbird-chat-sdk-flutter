import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/query/base_query.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';

part 'user_list_query.g.dart';
part 'application_user_list_query.dart';

/// A query object to retrieve user list
@JsonSerializable()
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
    if (queryType == null) throw InvalidParameterError();
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    final sdk = SendbirdSdk().getInternal();

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

  // Json Serialization

  Map<String, dynamic> toJson() => _$UserListQueryToJson(this);
}
