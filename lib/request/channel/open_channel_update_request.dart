import 'package:sendbird_sdk/constant/types.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class OpenChannelUpdateRequest extends ApiRequest {
  @override
  final method = Method.put;

  OpenChannelUpdateRequest(
    OpenChannelParams params, {
    OnUploadProgressCallback? onProgress,
    String? userId,
  }) : super(userId: userId) {
    url = 'open_channels/${params.channelUrl}';
    body = params.toJson();
    isMultipart = params.coverImage != null && params.coverImage!.hasBinary;
    progress = onProgress;
  }

  @override
  Future<OpenChannel> response(res) async {
    return OpenChannel.fromJsonAndCached(res);
  }
}
