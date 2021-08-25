import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ChannelMetaDataGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  ChannelMetaDataGetRequest({
    required ChannelType channelType,
    required String channelUrl,
    List<String> keys = const [],
  }) : super() {
    url = '${channelType.urlString}/$channelUrl/metadata';
    queryParams = {'include_ts': true};
    if (keys.isNotEmpty) {
      queryParams['keys'] = keys;
    }
  }

  @override
  Future<MetaDataResponse> response(res) async {
    return MetaDataResponse.fromJson(res);
  }
}
