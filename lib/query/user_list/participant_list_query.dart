import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/query/base_query.dart';
import 'package:sendbird_sdk/request/user/list/participant_list_request.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';

class ParticipantListQuery extends QueryBase {
  String channelUrl;

  ParticipantListQuery({required this.channelUrl});

  @override
  Future<List<User>> loadNext() async {
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    loading = true;

    final req = OpenChannelParticipantListRequest(
      channelUrl: channelUrl,
      token: token,
      limit: limit,
    );

    final sdk = SendbirdSdk().getInternal();
    final res = await sdk.api.send<UserListQueryResponse<User>>(req);
    loading = false;
    token = res.next;
    hasNext = res.next != '';
    return res.users;
  }
}
