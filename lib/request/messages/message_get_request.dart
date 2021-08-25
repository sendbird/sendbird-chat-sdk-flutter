import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ChannelMessageGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  ChannelMessageGetRequest({
    required ChannelType channelType,
    required String channelUrl,
    required int messageId,
    required MessageRetrievalParams params,
  }) : super() {
    url = '${channelType.urlString}/$channelUrl/messages/$messageId';
    queryParams = params.toJson();
  }

  @override
  Future<BaseMessage?> response(res) async {
    return BaseMessage.msgFromJson(res);
  }
}
