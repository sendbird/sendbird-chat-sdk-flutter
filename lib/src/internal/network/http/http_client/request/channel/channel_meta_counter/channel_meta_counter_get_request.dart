// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat/src/public/main/define/enums.dart';

class ChannelMetaCounterGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  ChannelMetaCounterGetRequest(
    Chat chat, {
    required ChannelType channelType,
    required String channelUrl,
    List<String> keys = const [],
  }) : super(chat: chat) {
    url = '${channelType.urlString}/$channelUrl/metacounter';
    queryParams = {'include_ts': true};
    if (keys.isNotEmpty) {
      queryParams['keys'] = keys;
    }
  }

  @override
  Future<Map<String, int>> response(Map<String, dynamic> res) async {
    return Map<String, int>.from(res);
  }
}
