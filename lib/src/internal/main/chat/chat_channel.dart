// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'chat.dart';

extension ChatChannel on Chat {
  Future<void> setChannelInvitationPreference(bool autoAccept) async {
    sbLog.i(StackTrace.current, 'autoAccept: $autoAccept');
    await apiClient
        .send(ChannelInvitationPreferenceSetRequest(this, autoAccept));
  }

  Future<bool> getChannelInvitationPreference() async {
    sbLog.i(StackTrace.current);
    return await apiClient
        .send<bool>(ChannelInvitationPreferenceGetRequest(this));
  }

  Future<GroupChannelChangeLogs> getMyGroupChannelChangeLogs(
    GroupChannelChangeLogsParams params, {
    String? token,
    int? timestamp,
  }) async {
    sbLog.i(StackTrace.current, 'token: $token');

    final res = await apiClient.send<GroupChannelChangeLogs>(
        GroupChannelChangeLogsGetRequest(this, params,
            token: token, timestamp: timestamp));

    for (final element in res.updatedChannels) {
      element.saveToCache(this);
    }
    return res;
  }

  Future<FeedChannelChangeLogs> getMyFeedChannelChangeLogs(
    FeedChannelChangeLogsParams params, {
    String? token,
    int? timestamp,
  }) async {
    sbLog.i(StackTrace.current, 'token: $token');

    final res = await apiClient.send<FeedChannelChangeLogs>(
        FeedChannelChangeLogsGetRequest(this, params,
            token: token, timestamp: timestamp));

    for (final element in res.updatedChannels) {
      element.saveToCache(this);
    }
    return res;
  }

  Future<void> markAsReadAll() async {
    sbLog.i(StackTrace.current);

    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - lastMarkAsReadTimestamp <= 1000) {
      throw MarkAsReadRateLimitExceededException();
    }
    lastMarkAsReadTimestamp = now;

    await apiClient.send(GroupChannelMarkAsReadAllRequest(this,
        userId: chatContext.currentUserId));
  }

  Future<void> markAsRead({required List<String> channelUrls}) async {
    sbLog.i(StackTrace.current, 'channelUrls: $channelUrls');

    if (channelUrls.isEmpty) throw InvalidParameterException();

    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - lastMarkAsReadTimestamp <= 1000) {
      throw MarkAsReadRateLimitExceededException();
    }
    lastMarkAsReadTimestamp = now;

    await apiClient.send(GroupChannelMarkAsReadAllRequest(
      this,
      channelUrls: channelUrls,
      userId: chatContext.currentUserId,
    ));
  }

  Future<void> markAsDelivered({required Map<String, dynamic> data}) async {
    sbLog.i(StackTrace.current, 'data: $data');

    Map<String, dynamic>? sendbird = data['sendbird'];
    String? appId, userId, channelUrl, sessionKey;
    int? createdAt;

    if (sendbird != null) {
      Map<String, dynamic>? recipient = sendbird['recipient'];
      Map<String, dynamic>? channel = sendbird['channel'];
      Map<String, dynamic>? session = sendbird['session_key'];

      createdAt = sendbird['created_at'];
      appId = sendbird['app_id'];

      if (recipient != null) userId = recipient['id'];
      if (channel != null) channelUrl = channel['channel_url'];
      if (session != null) sessionKey = session['key'];
    }

    if (appId != null &&
        userId != null &&
        channelUrl != null &&
        sessionKey != null &&
        createdAt != null) {
      sessionManager.setSessionKey(sessionKey);

      await apiClient.send(GroupChannelMarkAsDeliveredRequest(
        this,
        channelUrl: channelUrl,
        userId: userId,
        timestamp: createdAt,
      ));
    } else {
      throw InvalidParameterException();
    }
  }

  Future<int> getGroupChannelCount(MyMemberStateFilter filter) async {
    sbLog.i(StackTrace.current, 'filter: $filter');
    return await apiClient
        .send<int>(UserGroupChannelCountGetRequest(this, filter));
  }

  Future<int> getTotalUnreadChannelCount(
      [GroupChannelTotalUnreadChannelCountParams? params]) async {
    final result = await apiClient
        .send<int>(UserTotalUnreadChannelCountGetRequest(this, params: params));
    sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }

  Future<UnreadMessageCount> getTotalUnreadMessageCount(
      [GroupChannelTotalUnreadMessageCountParams? params]) async {
    final result = await apiClient.send<UnreadMessageCount>(
        UserTotalUnreadMessageCountGetRequest(this, params: params));
    sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }

  Future<GroupChannelUnreadItemCount> getUnreadItemCount(
      List<UnreadItemKey> keys) async {
    final result = await apiClient.send<GroupChannelUnreadItemCount>(
        UserUnreadItemCountGetRequest(this, keys));
    sbLog.i(StackTrace.current, 'keys: $keys, return: $result');
    return result;
  }

  int get subscribedTotalUnreadMessageCount {
    final result = chatContext.unreadMessageCountInfo.all;
    sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }

  int get subscribedCustomTypeTotalUnreadMessageCount {
    final result = chatContext.unreadMessageCountInfo.customTypes.values
        .reduce((a, b) => a + b);
    sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }

  int? subscribedCustomTypeUnreadMessageCount(String customType) {
    final result = chatContext.unreadMessageCountInfo.customTypes[customType];
    sbLog.i(StackTrace.current, 'customType: $customType, return: $result');
    return result;
  }

  Future<int> getTotalScheduledMessageCount({
    TotalScheduledMessageCountParams? params,
  }) async {
    final result = await apiClient.send(
        GroupChannelScheduledMessageTotalCountRequest(this, params: params));
    sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }
}
