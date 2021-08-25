import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class MessageSearchRequest extends ApiRequest {
  @override
  final method = Method.get;

  MessageSearchRequest({
    required String keyword,
    String? channelUrl,
    String? customType,
    String? beforeIndex,
    String? afterIndex,
    String? token,
    List<String>? targetUserIds,
    int? startAt,
    int? endAt,
    String? sortField,
    int? limit,
    bool? reverse,
    bool? exactMatch,
    bool? advanced,
    List<String>? targetFields,
  }) : super() {
    url = 'search/messages';
    queryParams = {
      'query': keyword,
      'channel_url': channelUrl,
      'custom_type': customType,
      'limit': limit,
      'before': beforeIndex,
      'after': afterIndex,
      'token': token,
      'target_user_ids': targetUserIds,
      'include_open': false,
      'include_not_joined_public': false,
      'sort_field': sortField,
      'reverse': reverse,
      'exact_match': exactMatch,
      'advanced_query': advanced,
      'target_fields': targetFields,
      if (startAt != 0) 'message_ts_from': startAt,
      if (endAt != 0) 'message_ts_to': endAt,
    };

    queryParams.removeWhere((key, value) => value == null);
  }

  @override
  Future<MessageSearchQueryResponse> response(res) async {
    return MessageSearchQueryResponse.fromJson(res);
  }
}
