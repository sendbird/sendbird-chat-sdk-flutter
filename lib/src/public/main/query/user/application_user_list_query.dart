// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/user/list/application_user_list_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/query/base_query.dart';

/// A class representing query to retrieve lists related to [User].
///
/// #################### SECURITY TIPS ####################
/// Before launching, you should review "Allow retrieving user list from SDK" under ⚙️ Sendbird Dashboard ->Settings -> Security.
/// It's turned on at first to simplify running samples and implementing your first code.
/// Most apps will want to disable "Allow retrieving user list from SDK" as that could possibly expose user information
/// #################### SECURITY TIPS ####################
class ApplicationUserListQuery extends BaseQuery {
  /// Sets [User] IDs filter. [User] list containing the passed [User] IDs will be returned.
  List<String>? userIdsFilter;

  /// A filter to return users whose nicknames start with the specified string.
  String? nicknameStartsWithFilter;

  /// [User] meta data key/value filter. [User] list containing only and exactly the passed [User] meta data will be returned.
  /// This should be specified in conjunction with the [metaDataValuesFilter].
  String? metaDataKeyFilter;

  /// [User] meta data key/value filter. [User] list containing only and exactly the passed [User] meta data will be returned.
  /// This should be specified in conjunction with the [metaDataKeyFilter].
  List<String>? metaDataValuesFilter;

  ApplicationUserListQuery({
    this.userIdsFilter,
    this.metaDataKeyFilter,
    this.metaDataValuesFilter,
    this.nicknameStartsWithFilter,
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
        ApplicationUserListRequest(
          chat,
          limit: limit,
          token: token,
          userIds: userIdsFilter,
          metaDataKey: metaDataKeyFilter,
          metaDataValues: metaDataValuesFilter,
          nicknameStartsWith: nicknameStartsWithFilter,
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
