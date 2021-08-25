import 'package:sendbird_sdk/core/models/emoji.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class EmojiContainerGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  EmojiContainerGetRequest() : super() {
    url = 'emoji_categories';
  }

  @override
  Future<EmojiContainer> response(res) async {
    return EmojiContainer.fromJson(res);
  }
}
