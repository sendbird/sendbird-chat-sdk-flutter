import 'package:sendbird_sdk/constant/types.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/request/abstract/api_request.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbird_sdk/services/network/http_client.dart';

class ChannelFileUploadRequest extends ApiRequest {
  @override
  final method = Method.post;

  ChannelFileUploadRequest({
    required String channelUrl,
    required String requestId,
    required FileMessageParams params,
    OnUploadProgressCallback? onProgress,
  }) : super() {
    url = 'storage/file';
    final fileSize = params.uploadFile.file?.lengthSync() ?? 0;
    if (fileSize == 0) {
      throw InvalidParameterError();
    }

    //upload size limit
    if (state.uploadSizeLimit < fileSize) {
      throw FileSizeLimitExceededError();
    }

    body = {
      'channel_url': channelUrl,
      'request_id': requestId,
      'file': params.uploadFile,
    };

    params.thumbnailSizes?.asMap().forEach((index, value) =>
        body['thumbnail${index + 1}'] =
            '${value.width.round()},${value.height.round()}');

    isMultipart = true;
    progress = onProgress;
  }

  @override
  Future<UploadResponse> response(res) async {
    return UploadResponse.fromJson(res);
  }
}
