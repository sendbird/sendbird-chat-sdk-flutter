import 'package:sendbird_sdk/core/models/emoji.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class EmojiCategoryGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  EmojiCategoryGetRequest(int categoryId) : super() {
    url = 'emoji_categories/$categoryId';
  }

  @override
  Future<EmojiCategory> response(res) async {
    return EmojiCategory.fromJson(res);
  }
}
