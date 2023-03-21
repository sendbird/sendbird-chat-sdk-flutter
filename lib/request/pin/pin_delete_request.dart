import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class PinDeleteRequest extends ApiRequest {
  @override
  final method = Method.delete;

  PinDeleteRequest({
    required int messageId,
    required String channelUrl,
    required ChannelType channelType,
  }) {
    url = '${channelType.urlString}/$channelUrl/messages/$messageId/pin';
  }

}
