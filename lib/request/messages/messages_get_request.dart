import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ChannelMessagesGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  ChannelType channelType;

  ChannelMessagesGetRequest({
    required this.channelType,
    required String channelUrl,
    required Map<String, dynamic> params,
    int timestamp = 0,
    int messageId = 0,
    int parentMessageId = 0,
  }) : super() {
    if (messageId <= 0 && timestamp <= 0) {
      throw InvalidParameterError();
    }

    url = '${channelType.urlString}/$channelUrl/messages';

    queryParams = params;
    queryParams['is_sdk'] = true;
    if (messageId > 0) {
      queryParams['message_id'] = messageId;
    } else {
      queryParams['message_ts'] = timestamp;
    }

    if (parentMessageId > 0) {
      queryParams['root_message_id'] = parentMessageId;
    }
  }

  @override
  Future<List<BaseMessage>> response(res) async {
    final lst = (res['messages'] as List)
        .map((e) => BaseMessage.msgFromJson(e, channelType: channelType))
        .toList();
    lst.removeWhere((element) => element == null);
    return List<BaseMessage>.from(lst);
  }
}
