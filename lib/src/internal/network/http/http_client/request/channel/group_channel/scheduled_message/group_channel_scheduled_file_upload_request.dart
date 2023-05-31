// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/scheduled_file_message_create_params.dart';

class GroupChannelScheduledFileUploadRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  GroupChannelScheduledFileUploadRequest(
    Chat chat, {
    required String channelUrl,
    required ScheduledFileMessageCreateParams params,
  }) : super(chat: chat) {
    url = 'storage/file';
    final fileSize = params.fileInfo.file?.lengthSync() ?? 0;
    if (fileSize == 0) {
      throw InvalidParameterException();
    }

    // upload size limit
    if (chat.chatContext.uploadSizeLimit < fileSize) {
      throw FileSizeLimitExceededException();
    }

    body = {
      'channel_url': channelUrl,
      'file': params.fileInfo,
    };

    params.thumbnailSizes?.asMap().forEach((index, value) =>
        body['thumbnail${index + 1}'] =
            '${value.width.round()},${value.height.round()}');

    isMultipart = true;
  }

  @override
  Future<UploadResponse> response(Map<String, dynamic> res) async {
    return UploadResponse.fromJson(res);
  }
}
