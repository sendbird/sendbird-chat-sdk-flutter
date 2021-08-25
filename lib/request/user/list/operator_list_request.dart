import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class OperatorListRequest extends ApiRequest {
  @override
  final method = Method.get;

  OperatorListRequest({
    required ChannelType channelType,
    required String channelUrl,
    String? token,
    int limit = 30,
  }) : super() {
    url = '${channelType.urlString}/$channelUrl/operators';
    queryParams = {
      'limit': limit.toString(),
      if (token != null) 'token': token,
    };
  }

  @override
  Future<OperatorListQueryResponse> response(res) async {
    return OperatorListQueryResponse.fromJson(res);
  }
}
