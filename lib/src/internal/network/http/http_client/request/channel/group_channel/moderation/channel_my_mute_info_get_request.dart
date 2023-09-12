// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/info/mute_info.dart';

class ChannelMyMuteInfoGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  ChannelMyMuteInfoGetRequest(
    Chat chat, {
    required ChannelType channelType,
    required String channelUrl,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url =
        '${channelType.urlString}/$channelUrl/mute/${getUrlEncodedUserId(chat, userId)}';
  }

  @override
  Future<MuteInfo> response(Map<String, dynamic> res) async {
    return MuteInfo.fromJson(res);
  }
}
