import 'package:sendbird_sdk/core/models/emoji.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class EmojiGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  EmojiGetRequest(String key) : super() {
    url = 'emojis/$key';
  }

  @override
  Future<Emoji> response(res) async {
    return Emoji.fromJson(res);
  }
}
