import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelMemberListRequest extends ApiRequest {
  @override
  final method = Method.get;

  GroupChannelMemberListRequest({
    required String channelUrl,
    String? token,
    int limit = 30,
    OperatorFilter operatorFilter = OperatorFilter.all,
    MutedMemberFilter mutedMemberFilter = MutedMemberFilter.all,
    MemberStateFilter memberStateFilter = MemberStateFilter.all,
    String? nicknameStartsWith,
    MemberListOrder order = MemberListOrder.nicknameAlphabetical,
  }) : super() {
    url = 'group_channels/$channelUrl/members';
    queryParams = {
      'limit': limit,
      if (token != null) 'token': token,
      'operator_filter': operatorFilterEnumMap[operatorFilter],
      'muted_member_filter': mutedMemberFilterEnumMap[mutedMemberFilter],
      'order': memberListOrderEnumMap[order],
      'member_state_filter': memberStateFilterEnumForQuery(memberStateFilter),
      if (nicknameStartsWith != null) 'nickname_startswith': nicknameStartsWith,
      //
      'show_read_receipt': 'true',
      'show_delivery_receipt': 'true',
      'show_member_is_muted': 'true',
    };
  }

  @override
  Future<UserListQueryResponse> response(res) async {
    final output = {'users': res['members'], 'next': res['next']};
    return UserListQueryResponse.fromJson(output);
  }
}
