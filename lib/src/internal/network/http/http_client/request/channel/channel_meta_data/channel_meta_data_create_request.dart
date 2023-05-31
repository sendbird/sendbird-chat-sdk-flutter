// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';

class ChannelMetaDataCreateRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  ChannelMetaDataCreateRequest(
    Chat chat, {
    required ChannelType channelType,
    required String channelUrl,
    required Map<String, String> metaData,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = '${channelType.urlString}/$channelUrl/metadata';
    body = {'metadata': metaData, 'upsert': true};
    queryParams = {'include_ts': true};
  }

  @override
  Future<MetaDataResponse> response(Map<String, dynamic> res) async {
    return MetaDataResponse.fromJson(res);
  }
}
