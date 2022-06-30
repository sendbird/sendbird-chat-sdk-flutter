import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/params/scheduled_message_retrieval_params.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ScheduledMessageGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  ScheduledMessageGetRequest({
    required ScheduledMessageRetrievalParams params,
  }) {
    url =
        'group_channels/${params.channelUrl}/scheduled_messages/${params.scheduledMessageId}';
  }

  @override
  Future<BaseMessage> response(res) async {
    var sortedMetaarrayList = [];
    if (res['sorted_metaarray'].isNotEmpty) {
      sortedMetaarrayList.add(res['sorted_metaarray']);
    }
    res['sorted_metaarray'] = sortedMetaarrayList;

    if (res['scheduled_message_id'] == null ||
        res['scheduled_status'] == null ||
        res['scheduled_at'] == null) {
      throw SBError(message: 'Scheduled Message Info Not Found');
    }
    res['scheduled_info'] = {
      'scheduled_message_id': res['scheduled_message_id'],
      'scheduled_status': res['scheduled_status'],
      'scheduled_at': res['scheduled_at'],
    };

    return BaseMessage.fromJson(res);
  }
}
