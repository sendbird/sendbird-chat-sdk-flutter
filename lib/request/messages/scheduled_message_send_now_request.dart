import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelScheduledMessageSendNowRequest extends ApiRequest {
  @override
  final method = Method.post;

  GroupChannelScheduledMessageSendNowRequest({
    required ChannelType channelType,
    required String channelUrl,
    required int scheduledMessageId,
  }) {
    url =
        '${channelType.urlString}/$channelUrl/scheduled_messages/$scheduledMessageId/send_now';
  }
}
