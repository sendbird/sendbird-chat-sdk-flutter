import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ScheduledMessageListGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  ScheduledMessageListGetRequest({
    String? channelUrl,
    String? channelType,
    String? senderId,
    String? token,
    int? limit,
    bool? reverse,
    List<ScheduledStatus>? status,
    MessageTypeFilter? messageType,
    ScheduledMessageListOrder? order = ScheduledMessageListOrder.createdAt,
  }) {
    url = 'scheduled_messages';

    queryParams = {
      'channel_url': channelUrl,
      'channel_type': channelType,
      'sender_id': senderId,
      'token': token,
      'limit': limit,
      'reverse': reverse,
      'status': status,
      'message_type': messageTypeFilterEnumMap[messageType],
      'order': scheduledMessageListOrderEnumMap[order],
    };

    queryParams.removeWhere((key, value) => value == null);
  }

  @override
  Future<ScheduledMessageResponse> response(res) async {
    return ScheduledMessageResponse.fromJson(res);
  }
}
