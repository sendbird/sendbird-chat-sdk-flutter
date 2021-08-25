import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ChannelMetaDataDeleteRequest extends ApiRequest {
  @override
  final method = Method.delete;

  ChannelMetaDataDeleteRequest({
    required ChannelType channelType,
    required String channelUrl,
    required String key,
  }) : super() {
    url = '${channelType.urlString}/$channelUrl/metadata/$key';
    queryParams = {'include_ts': true};
  }

  @override
  Future<int> response(res) async {
    return res['ts'];
  }
}

class ChannelMetaDataDeleteAllRequest extends ApiRequest {
  @override
  final method = Method.delete;

  ChannelMetaDataDeleteAllRequest({
    required ChannelType channelType,
    required String channelUrl,
  }) : super() {
    url = '${channelType.urlString}/$channelUrl/metadata';
    queryParams = {'include_ts': true};
  }

  @override
  Future<int> response(res) async {
    return res['ts'];
  }
}
