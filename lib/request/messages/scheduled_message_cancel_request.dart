import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelScheduledMessageCancelRequest extends ApiRequest {
  @override
  final method = Method.delete;

  GroupChannelScheduledMessageCancelRequest({
    required String channelUrl,
    required int scheduledMessageId,
  }) : super() {
    url = 'group_channels/$channelUrl/scheduled_messages/$scheduledMessageId';
  }
}
