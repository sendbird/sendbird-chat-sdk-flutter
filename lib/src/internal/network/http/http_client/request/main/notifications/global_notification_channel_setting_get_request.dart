// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/http_client.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/api_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/chat/global_notification_channel_setting.dart';

class GlobalNotificationChannelSettingGetRequest extends ApiRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  GlobalNotificationChannelSettingGetRequest(
    Chat chat,
  ) : super(chat: chat) {
    url = 'notifications/settings';
  }

  @override
  Future<GlobalNotificationChannelSetting> response(
    Map<String, dynamic> res,
  ) async {
    return GlobalNotificationChannelSetting(setting: res);
  }
}
