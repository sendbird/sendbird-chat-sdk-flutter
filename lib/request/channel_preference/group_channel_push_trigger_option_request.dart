import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelPushTriggerOptionGetRequest extends ApiRequest {
  @override
  final Method method = Method.get;

  GroupChannelPushTriggerOptionGetRequest({
    required String channelUrl,
    String? userId,
  }) : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/push_preference/$channelUrl';
  }

  @override
  Future<GroupChannelPushTriggerOption> response(
      Map<String, dynamic> json) async {
    return enumDecode(
      groupChannelPushTriggerOptionEnumMap,
      json['push_trigger_option'],
      unknownValue: GroupChannelPushTriggerOption.global,
    );
  }
}

class GroupChannelPushTriggerOptionSetRequest extends ApiRequest {
  @override
  final Method method = Method.put;

  GroupChannelPushTriggerOptionSetRequest(
      {required String channelUrl,
      required GroupChannelPushTriggerOption option,
      String? userId})
      : super(userId: userId) {
    url = 'users/${userId ?? state.userId}/push_preference/$channelUrl';
    body = {
      'push_trigger_option': groupChannelPushTriggerOptionEnumMap[option]
    };
  }

  @override
  Future<GroupChannelPushTriggerOption> response(
      Map<String, dynamic> json) async {
    return enumDecode(
      groupChannelPushTriggerOptionEnumMap,
      json['push_trigger_option'],
      unknownValue: GroupChannelPushTriggerOption.global,
    );
  }
}
