// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/enum_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/user/list/group_channel_member_list_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/query/base_query.dart';

/// A query object to retrieve list of members from my group channel.
class MemberListQuery extends BaseQuery {
  /// The url of the channel to get member list from.
  String channelUrl;

  /// A filter to return members whose nicknames start with the specified string.
  String? nicknameStartsWith;

  /// Operator filter.
  OperatorFilter operatorFilter = OperatorFilter.all;

  /// Muted member filter.
  MutedMemberFilter mutedMemberFilter = MutedMemberFilter.all;

  /// A filter to return members with the member state matching to [MyMemberStateFilter].
  @JsonKey(toJson: memberStateFilterEnumForQuery)
  MyMemberStateFilter memberStateFilter = MyMemberStateFilter.all;

  /// Indicates how the query result should be ordered.
  MemberListOrder order = MemberListOrder.nicknameAlphabetical;

  MemberListQuery({
    required this.channelUrl,
    Chat? chat,
  }) : super(chat: chat ?? SendbirdChat().chat);

  /// Gets the list of next items.
  @override
  Future<List<User>> next() async {
    sbLog.i(StackTrace.current);

    if (isLoading) throw QueryInProgressException();
    if (!hasNext) return [];

    isLoading = true;

    UserListQueryResponse res;
    try {
      res = await chat.apiClient.send<UserListQueryResponse>(
        GroupChannelMemberListRequest(
          chat,
          limit: limit,
          channelUrl: channelUrl,
          token: token,
          nicknameStartsWith: nicknameStartsWith,
          operatorFilter: operatorFilter,
          mutedMemberFilter: mutedMemberFilter,
          memberStateFilter: memberStateFilter,
          order: order,
        ),
      );

      token = res.next;
      hasNext = res.next != '';
    } catch (_) {
      isLoading = false;
      rethrow;
    }

    isLoading = false;
    return res.users;
  }
}
