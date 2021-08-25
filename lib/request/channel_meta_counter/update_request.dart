import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';
import 'package:sendbird_sdk/utils/extensions.dart';

class ChannelMetaCounterUpdateRequest extends ApiRequest {
  @override
  final method = Method.put;

  ChannelMetaCounterUpdateRequest({
    required ChannelType channelType,
    required String channelUrl,
    required Map<String, int> metaCounter,
    required MetaCounterMode mode,
    bool upsert = true,
  }) : super() {
    url = '${channelType.urlString}/$channelUrl/metacounter';
    body = {
      'metacounter': metaCounter,
      'upsert': upsert,
      'mode': mode.asString()
    };
  }

  @override
  Future<Map<String, int>> response(res) async {
    return Map<String, int>.from(res);
  }
}
