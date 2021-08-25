import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelCountReferenceRequest extends ApiRequest {
  @override
  final method = Method.put;

  GroupChannelCountReferenceRequest(
      {required String channelUrl,
      required CountPreference prefs,
      String? userId})
      : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/count_preference/$channelUrl';
    body = {'count_preference': countPreferenceEnumMap[prefs]};
  }

  @override
  Future<CountPreference> response(res) async {
    return enumDecode<CountPreference>(
      countPreferenceEnumMap,
      res['count_preference'],
      unknownValue: CountPreference.all,
    );
  }
}
