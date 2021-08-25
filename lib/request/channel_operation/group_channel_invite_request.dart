import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelInviteRequest extends ApiRequest {
  @override
  final method = Method.post;

  GroupChannelInviteRequest({
    required String channelUrl,
    required List<String> userIds,
    String? inviterId,
  }) : super() {
    url = 'group_channels/$channelUrl/invite';
    body = {
      'inviter_id': inviterId ?? state.userId,
      'user_ids': userIds,
    };
  }

  @override
  Future<GroupChannel> response(res) async {
    return GroupChannel.fromJsonAndCached(res);
  }
}
