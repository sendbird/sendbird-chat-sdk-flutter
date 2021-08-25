import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/core/models/unread_item_count.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class UserUnreadItemCountGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  UserUnreadItemCountGetRequest(List<UnreadItemKey> keys, {String? userId})
      : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/unread_item_count';
    queryParams = {
      'item_keys': keys.map((e) => unreadItemKeyEnumMap[e]).toList()
    };
  }

  @override
  Future<UnreadItemCount> response(res) async {
    return UnreadItemCount.fromJson(res);
  }
}
