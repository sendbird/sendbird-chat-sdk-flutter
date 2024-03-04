// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/user/list/blocked_user_list_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/query/base_query.dart';

/// A class representing query to retrieve lists related to blocked [User].
class BlockedUserListQuery extends BaseQuery {
  /// [User] IDs filter. [User] list containing the passed [User] IDs will be returned.
  List<String> userIdsFilter = [];

  BlockedUserListQuery({
    this.userIdsFilter = const [],
    Chat? chat,
  }) : super(chat: chat ?? SendbirdChat().chat);

  /// Gets the list of next items.
  @override
  Future<List<User>> next() async {
    sbLog.i(StackTrace.current);

    if (isLoading) throw QueryInProgressException();
    if (!hasNext) return [];

    isLoading = true;

    final req = BlockedUserListRequest(
      chat,
      limit: limit,
      token: token,
      userIds: userIdsFilter,
    );

    UserListQueryResponse<User> res;
    try {
      res = await chat.apiClient.send<UserListQueryResponse<User>>(req);

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
