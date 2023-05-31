// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/main/utils/enum_utils.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat/src/public/main/define/enums.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/response/responses.dart';

class GroupChannelMemberListRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  final operatorFilterEnumMap = <OperatorFilter, String>{
    OperatorFilter.all: 'all',
    OperatorFilter.operator: 'operator',
    OperatorFilter.nonOperator: 'nonoperator',
  };

  final mutedMemberFilterEnumMap = <MutedMemberFilter, String>{
    MutedMemberFilter.all: 'all',
    MutedMemberFilter.muted: 'muted',
    MutedMemberFilter.unmuted: 'unmuted',
  };

  final memberListOrderEnumMap = <MemberListOrder, String>{
    MemberListOrder.nicknameAlphabetical: 'member_nickname_alphabetical',
    MemberListOrder.operatorThenMemberNicknameAlphabetical:
        'operator_then_member_alphabetical',
  };

  GroupChannelMemberListRequest(
    Chat chat, {
    required int limit,
    required String channelUrl,
    String? token,
    OperatorFilter operatorFilter = OperatorFilter.all,
    MutedMemberFilter mutedMemberFilter = MutedMemberFilter.all,
    MyMemberStateFilter memberStateFilter = MyMemberStateFilter.all,
    String? nicknameStartsWith,
    MemberListOrder order = MemberListOrder.nicknameAlphabetical,
  }) : super(chat: chat) {
    url = 'group_channels/$channelUrl/members';
    queryParams = {
      'limit': limit,
      if (token != null) 'token': token,
      'operator_filter': operatorFilterEnumMap[operatorFilter],
      'muted_member_filter': mutedMemberFilterEnumMap[mutedMemberFilter],
      'order': memberListOrderEnumMap[order],
      'member_state_filter': memberStateFilterEnumForQuery(memberStateFilter),
      if (nicknameStartsWith != null) 'nickname_startswith': nicknameStartsWith,
      'show_read_receipt': 'true',
      'show_delivery_receipt': 'true',
      'show_member_is_muted': 'true',
    };
  }

  @override
  Future<UserListQueryResponse> response(Map<String, dynamic> res) async {
    final output = {'users': res['members'], 'next': res['next']};
    return UserListQueryResponse.fromJsonWithChat(chat, output);
  }
}
