// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat/src/public/main/define/enums.dart';

class ChannelMetaCounterUpdateRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.put;

  ChannelMetaCounterUpdateRequest(
    Chat chat, {
    required ChannelType channelType,
    required String channelUrl,
    required Map<String, int> metaCounter,
    required UpdateMetaCounterMode mode,
    bool upsert = true,
  }) : super(chat: chat) {
    url = '${channelType.urlString}/$channelUrl/metacounter';
    body = {
      'metacounter': metaCounter,
      'upsert': upsert,
      'mode': mode.asString()
    };
  }

  @override
  Future<Map<String, int>> response(Map<String, dynamic> res) async {
    return Map<String, int>.from(res);
  }
}
