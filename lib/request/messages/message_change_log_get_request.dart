import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ChannelMessageChangeLogGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  ChannelMessageChangeLogGetRequest({
    required ChannelType channelType,
    required String channelUrl,
    required MessageChangeLogParams params,
    String? token,
    int? timestamp,
  }) : super() {
    url = '${channelType.urlString}/$channelUrl/messages/changelogs';
    queryParams = params.toJson();
    if (token != null) {
      queryParams['token'] = token;
    } else {
      queryParams['change_ts'] = timestamp;
    }
  }

  @override
  Future<MessageChangeLogsResponse> response(res) async {
    return MessageChangeLogsResponse.fromJson(res);
  }
}
