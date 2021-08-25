import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ChannelOperatorsAddRequest extends ApiRequest {
  @override
  final method = Method.post;

  ChannelOperatorsAddRequest({
    required ChannelType channelType,
    required String channelUrl,
    required List<String> userIds,
  }) : super() {
    url = '${channelType.urlString}/$channelUrl/operators';
    body = {'operator_ids': userIds};
  }
}
