// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat/src/public/main/define/enums.dart';

class PinCreateRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.post;

  PinCreateRequest(
    Chat chat, {
    required ChannelType channelType,
    required String channelUrl,
    required int messageId,
  }) : super(chat: chat) {
    url = '${channelType.urlString}/$channelUrl/messages/$messageId/pin';
  }
}
