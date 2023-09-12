// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

class UserGroupChannelCountGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  UserGroupChannelCountGetRequest(
    Chat chat,
    MyMemberStateFilter filter, {
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/group_channel_count';
    queryParams = {'state': memberStateFilterEnumForGroupCount(filter)};
  }

  @override
  Future<int> response(Map<String, dynamic> res) async {
    return res['group_channel_count'];
  }

  String memberStateFilterEnumForGroupCount(MyMemberStateFilter filter) {
    switch (filter) {
      case MyMemberStateFilter.all:
        return 'all';
      case MyMemberStateFilter.invited:
        return 'invited';
      case MyMemberStateFilter.joined:
        return 'joined';
      case MyMemberStateFilter.invitedByFriend:
        return 'invited_by_friend';
      case MyMemberStateFilter.invitedByNonFriend:
        return 'invited_by_non_friend';
    }
  }
}
