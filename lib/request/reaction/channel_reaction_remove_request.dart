import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/features/reaction/reaction_event.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ChannelReactionDeleteRequest extends ApiRequest {
  @override
  final method = Method.delete;

  ChannelReactionDeleteRequest({
    required ChannelType channelType,
    required String channelUrl,
    required int messageId,
    required String key,
    String? userId,
  }) : super(userId: userId) {
    url = '${channelType.urlString}/$channelUrl/messages/$messageId/reactions';
    body = {'reaction': key};
  }

  @override
  Future<ReactionEvent> response(res) async {
    return ReactionEvent.fromJson(res);
  }
}
