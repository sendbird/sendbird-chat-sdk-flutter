import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ChannelMyMuteInfoGetRequest extends ApiRequest {
  @override
  final method = Method.get;

  ChannelMyMuteInfoGetRequest({
    required ChannelType channelType,
    required String channelUrl,
    String? userId,
  }) : super(userId: userId) {
    url = '${channelType.urlString}/$channelUrl/mute/${userId ?? state.userId}';
  }

  @override
  Future<MuteInfoResponse> response(res) async {
    return MuteInfoResponse.fromJson(res);
  }
}
