// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/enum_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/channel/group_channel_total_unread_channel_count_params.dart';

class UserTotalUnreadChannelCountGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  UserTotalUnreadChannelCountGetRequest(
    Chat chat, {
    GroupChannelTotalUnreadChannelCountParams? params,
    String? userId,
  }) : super(chat: chat, userId: userId) {
    url = 'users/${getUrlEncodedUserId(chat, userId)}/unread_channel_count';
    final customTypes = params?.channelCustomTypes ?? [];
    final superFilter = params?.superChannelFilter ?? SuperChannelFilter.all;
    queryParams = {
      if (customTypes.isNotEmpty) 'custom_types': customTypes,
      'super_mode': groupChannelSuperFilterEnum(superFilter),
    };
  }

  @override
  Future<int> response(Map<String, dynamic> res) async {
    return res['unread_count'];
  }
}
