import 'package:sendbird_sdk/constant/types.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class GroupChannelCreateRequest extends ApiRequest {
  @override
  final method = Method.post;

  GroupChannelCreateRequest(
    GroupChannelParams params, {
    OnUploadProgressCallback? onProgress,
    String? userId,
  }) : super(userId: userId) {
    url = 'group_channels';
    body = params.toJson();
    isMultipart = params.coverImage != null && params.coverImage!.hasBinary;
    progress = onProgress;
  }

  @override
  Future<GroupChannel> response(res) async {
    return GroupChannel.fromJsonAndCached(res);
  }
}
