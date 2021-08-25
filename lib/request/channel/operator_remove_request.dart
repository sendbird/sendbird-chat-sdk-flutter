import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ChannelOperatorsRemoveRequest extends ApiRequest {
  @override
  final method = Method.delete;

  ChannelOperatorsRemoveRequest({
    required ChannelType channelType,
    required String channelUrl,
    List<String> userIds = const [],
    bool removeAll = false,
  }) : super() {
    url = '${channelType.urlString}/$channelUrl/operators';
    body = {
      if (removeAll) 'delete_all': true,
      if (!removeAll) 'operator_ids': userIds,
    };
  }
}
