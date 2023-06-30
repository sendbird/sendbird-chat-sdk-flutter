// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'chat.dart';

extension ChatNotifications on Chat {
  Future<GlobalNotificationChannelSetting>
      getGlobalNotificationChannelSetting() async {
    sbLog.i(StackTrace.current);
    return await apiClient.send<GlobalNotificationChannelSetting>(
        GlobalNotificationChannelSettingGetRequest(this));
  }

  Future<NotificationTemplateList> getNotificationTemplateListByToken(
    NotificationTemplateListParams params, {
    String? token,
  }) async {
    sbLog.i(StackTrace.current);
    return await apiClient
        .send<NotificationTemplateList>(NotificationTemplateListGetRequest(
      this,
      params,
      token: token,
    ));
  }

  Future<NotificationTemplate> getNotificationTemplate({
    required String key,
  }) async {
    sbLog.i(StackTrace.current);
    return await apiClient
        .send<NotificationTemplate>(NotificationTemplateGetRequest(
      this,
      key: key,
    ));
  }
}
