import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ChannelMessageTranslateRequest extends ApiRequest {
  @override
  final method = Method.post;

  ChannelMessageTranslateRequest({
    required ChannelType channelType,
    required String channelUrl,
    required int messageId,
    required List<String> targetLanguages,
  }) : super() {
    url =
        '${channelType.urlString}/$channelUrl/messages/$messageId/translation';
    body = {'target_langs': targetLanguages};
  }

  @override
  Future<UserMessage> response(res) async {
    return UserMessage.fromJson(res);
  }
}
