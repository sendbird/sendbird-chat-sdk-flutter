// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

class ChannelOperatorsRemoveRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.delete;

  ChannelOperatorsRemoveRequest(
    Chat chat, {
    required ChannelType channelType,
    required String channelUrl,
    List<String> userIds = const [],
    bool removeAll = false,
  }) : super(chat: chat) {
    url = '${channelType.urlString}/$channelUrl/operators';
    body = {
      if (removeAll) 'delete_all': true,
      if (!removeAll) 'operator_ids': getUrlEncodedUserIds(chat, userIds),
    };
  }
}
