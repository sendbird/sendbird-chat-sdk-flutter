import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ChannelMetaDataUpdateRequest extends ApiRequest {
  @override
  final method = Method.put;

  ChannelMetaDataUpdateRequest({
    required ChannelType channelType,
    required String channelUrl,
    required Map<String, String> metaData,
    bool upsert = true,
  }) : super() {
    url = '${channelType.urlString}/$channelUrl/metadata';
    body = {'metadata': metaData, 'upsert': upsert};
    queryParams = {'include_ts': true};
  }

  @override
  Future<MetaDataResponse> response(res) async {
    return MetaDataResponse.fromJson(res);
  }
}
