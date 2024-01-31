// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat_options.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/handler/channel_handler.dart';
import 'package:sendbird_chat_sdk/src/public/main/handler/connection_handler.dart';
import 'package:sendbird_chat_sdk/src/public/main/handler/session_handler.dart';
import 'package:sendbird_chat_sdk/src/public/main/handler/user_event_handler.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/channel/feed_channel_change_logs.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/channel/group_channel_change_logs.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/channel/group_channel_unread_item_count.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/chat/do_not_disturb.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/chat/emoji.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/chat/global_notification_channel_setting.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/chat/notification_template.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/chat/notification_template_list.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/chat/snooze_period.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/info/app_info.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/info/file_info.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/unread_message_count.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/channel/feed_channel_change_logs_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/channel/group_channel_change_logs_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/channel/group_channel_total_unread_channel_count_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/channel/group_channel_total_unread_message_count_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/total_scheduled_message_count_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/notifications/notification_template_list_params.dart';

/// An object represents a main class to use Sendbird Chat
class SendbirdChat {
  /// Default push template
  static const String pushTemplateDefault = 'default';

  /// Alternative push template
  static const String pushTemplateAlternative = 'alternative';

  /// Max int value
  static int get maxInt => kIsWeb ? 9007199254740991 : double.maxFinite.toInt();

  static final SendbirdChat _instance = SendbirdChat._internal();

  SendbirdChat._internal()
      : _chat = Chat(appId: '', options: SendbirdChatOptions());

  late Chat _chat;

  Chat get chat => _chat;

  factory SendbirdChat() {
    return _instance;
  }

//------------------------------//
// Chat
//------------------------------//
  /// Initializes SendbirdChat with given app ID.
  static Future<bool> init({
    required String appId,
    SendbirdChatOptions? options,
  }) async {
    bool result = false;
    _instance._chat.chatContext.appId = appId;
    _instance._chat.chatContext.options = options ?? SendbirdChatOptions();

    //+ [DBManager]
    await _instance._chat.dbManager.init();

    _instance._chat.dbManager.appendLocalCacheStat(
      useLocalCache: _instance._chat.chatContext.options.useCollectionCaching,
    );
    //- [DBManager]
    return result;
  }

  /// Current SDK version.
  static String getSdkVersion() {
    sbLog.i(StackTrace.current, 'return: $sdkVersion');
    return _instance._chat.getSdkVersion();
  }

  /// Sets [SendbirdChatOptions].
  static void setOptions(SendbirdChatOptions options) {
    sbLog.i(StackTrace.current);
    _instance._chat.setOptions(options);
  }

  /// Returns current [SendbirdChatOptions].
  static SendbirdChatOptions getOptions() {
    sbLog.i(StackTrace.current);
    return _instance._chat.getOptions();
  }

  /// Sets app version.
  static void setAppVersion(String version) {
    sbLog.i(StackTrace.current, 'version: $version');
    _instance._chat.setAppVersion(version);
  }

  /// Sets log level.
  static void setLogLevel(LogLevel level) {
    sbLog.i(StackTrace.current, 'level: $level');
    _instance._chat.setLogLevel(level);
  }

  /// True if SDK has been initialized.
  static bool isInitialized() {
    final result = _instance._chat.isInitialized();
    sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }

  /// Returns current application id.
  static String? getApplicationId() {
    final result = _instance._chat.getApplicationId();
    sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }

  /// Returns current application information with [AppInfo].
  static AppInfo? getAppInfo() {
    sbLog.i(StackTrace.current);
    return _instance._chat.getAppInfo();
  }

  /// To send additional User-Agent information please set the version information.
  /// This will be set pre-defined keys only.
  static void addExtension(String key, String version) {
    sbLog.i(StackTrace.current, 'key: $key, version: $version');
    _instance._chat.addExtension(key, version);
  }

//------------------------------//
// Channel
//------------------------------//
  /// Sets the current `User`'s preference for `GroupChannel` join.
  /// If this is set as `true`, the `User` will automatically join the `GroupChannel`.
  /// If set as `false`, the `User` can join the `GroupChannel` by calling
  /// [GroupChannelOperation.acceptInvitation]
  /// or decline the invitation by calling [GroupChannelOperation.declineInvitation].
  static Future<void> setChannelInvitationPreference(bool autoAccept) async {
    sbLog.i(StackTrace.current, 'autoAccept: $autoAccept');
    await _instance._chat.setChannelInvitationPreference(autoAccept);
  }

  /// Gets the current `User`'s preference for `GroupChannel` join.
  /// If this is set as `true`, the `User` will automatically join the `GroupChannel`.
  /// If set as `false`, the `User` can join the `GroupChannel` by calling
  /// [GroupChannelOperation.acceptInvitation]
  /// or decline the invitation by calling [GroupChannelOperation.declineInvitation].
  static Future<bool> getChannelInvitationPreference() async {
    sbLog.i(StackTrace.current);
    return await _instance._chat.getChannelInvitationPreference();
  }

  /// Requests the channel changelogs from given token.
  static Future<GroupChannelChangeLogs> getMyGroupChannelChangeLogs(
    GroupChannelChangeLogsParams params, {
    String? token,
    int? timestamp,
  }) async {
    sbLog.i(StackTrace.current, 'token: $token');
    return _instance._chat.getMyGroupChannelChangeLogs(params,
        token: token, timestamp: timestamp);
  }

  /// Requests the channel changelogs from given token.
  /// @since 4.0.3
  static Future<FeedChannelChangeLogs> getMyFeedChannelChangeLogs(
    FeedChannelChangeLogsParams params, {
    String? token,
    int? timestamp,
  }) async {
    sbLog.i(StackTrace.current, 'token: $token');
    return _instance._chat
        .getMyFeedChannelChangeLogs(params, token: token, timestamp: timestamp);
  }

  /// Sends mark as read to all joined `GroupChannel`s.
  /// This method has rate limit. You can send one request per second.
  static Future<void> markAsReadAll() async {
    sbLog.i(StackTrace.current);
    await _instance._chat.markAsReadAll();
  }

  /// Sends mark as read to joined `GroupChannel`s.
  /// This method has rate limit. You can send one request per second.
  static Future<void> markAsRead({required List<String> channelUrls}) async {
    sbLog.i(StackTrace.current, 'channelUrls: $channelUrls');
    await _instance._chat.markAsRead(channelUrls: channelUrls);
  }

  /// Sends mark as delivered to this channel when you received push message from us.
  /// [data] is the payload data from the push.
  static Future<void> markAsDelivered(
      {required Map<String, dynamic> data}) async {
    sbLog.i(StackTrace.current, 'data: $data');
    await _instance._chat.markAsDelivered(data: data);
  }

  /// Gets the number of my `GroupChannel`s.
  static Future<int> getGroupChannelCount(MyMemberStateFilter filter) async {
    sbLog.i(StackTrace.current, 'filter: $filter');
    return await _instance._chat.getGroupChannelCount(filter);
  }

  /// Gets the total number of unread `GroupChannel`s the current user has joined.
  static Future<int> getTotalUnreadChannelCount(
      [GroupChannelTotalUnreadChannelCountParams? params]) async {
    final result = await _instance._chat.getTotalUnreadChannelCount(params);
    sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }

  /// Gets the total number of unread message of `GroupChannel`s with [GroupChannelTotalUnreadMessageCountParams] filter.
  static Future<int> getTotalUnreadMessageCount(
      [GroupChannelTotalUnreadMessageCountParams? params]) async {
    final result = await _instance._chat.getTotalUnreadMessageCount(params);
    sbLog.i(StackTrace.current, 'return: $result');
    return result.totalCountForGroupChannels;
  }

  /// Gets the total number of unread message of `GroupChannel`s and `FeedChannel`s
  /// with [GroupChannelTotalUnreadMessageCountParams] filter.
  /// @since 4.0.3
  static Future<UnreadMessageCount> getTotalUnreadMessageCountWithFeedChannel(
      [GroupChannelTotalUnreadMessageCountParams? params]) async {
    final result = await _instance._chat.getTotalUnreadMessageCount(params);
    sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }

  /// Gets the unread item count of `GroupChannel`s from keys.
  static Future<GroupChannelUnreadItemCount> getUnreadItemCount(
      List<UnreadItemKey> keys) async {
    final result = await _instance._chat.getUnreadItemCount(keys);
    sbLog.i(StackTrace.current, 'keys: $keys, return: $result');
    return result;
  }

  /// Gets the subscribed total number of unread message of all `GroupChannel`s the current user has joined.
  static int get getSubscribedTotalUnreadMessageCount {
    final result = _instance._chat.subscribedTotalUnreadMessageCount;
    sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }

  /// Gets the total number of unread message of `GroupChannel`s with subscribed custom types.
  static int get getSubscribedCustomTypeTotalUnreadMessageCount {
    final result = _instance._chat.subscribedCustomTypeTotalUnreadMessageCount;
    sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }

  /// Gets the number of unread message of `GroupChannel` with subscribed custom type.
  static int? getSubscribedCustomTypeUnreadMessageCount(String customType) {
    final result =
        _instance._chat.subscribedCustomTypeUnreadMessageCount(customType);
    sbLog.i(StackTrace.current, 'customType: $customType, return: $result');
    return result;
  }

  /// Gets the number of total scheduled messages.
  static Future<int> getTotalScheduledMessageCount({
    TotalScheduledMessageCountParams? params,
  }) async {
    final result =
        await _instance._chat.getTotalScheduledMessageCount(params: params);
    sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }

//------------------------------//
// Connection
//------------------------------//
  /// Connects to SendbirdChat with given `User` ID and auth token.
  /// If you have created `User`s without [auth token](https://docs.sendbird.com/platform#user_3_create),
  /// refer to [connect] or just pass auth token with `null`.
  static Future<User> connect(
    String userId, {
    String? nickname,
    String? accessToken,
    String? apiHost,
    String? wsHost,
  }) async {
    sbLog.i(StackTrace.current, 'userId: $userId');

    return await _instance._chat.connect(
      userId,
      nickname: nickname,
      accessToken: accessToken,
      apiHost: apiHost,
      wsHost: wsHost,
    );
  }

  /// Disconnects from SendbirdChat.
  static Future<void> disconnect() async {
    sbLog.i(StackTrace.current,
        'userId: ${_instance._chat.chatContext.currentUserId}');
    await _instance._chat.disconnect();
  }

  /// Tries reconnection with previously and successfully connected user information.
  /// This can be called in [ConnectionHandler.onReconnectFailed] or where you check the device network status
  /// to let the SDK try reconnection.
  /// [ConnectionHandler.onReconnectStarted] will be called after you call this
  /// (note that it will not be called if there is previously started connection process which has not finished),
  /// and [ConnectionHandler.onReconnectFailed] or [ConnectionHandler.onReconnectSucceeded] will be
  /// called according to the connection status afterwards.
  /// Usually, the SDK automatically retries connection process when the network connection is lost with some backoff period.
  /// When you call this method, you can start connection process immediately.
  static Future<bool> reconnect() async {
    sbLog.i(StackTrace.current);
    return await _instance._chat.reconnect(reset: true);
  }

  /// The last connected timestamp.
  static int? getLastConnectedAt() {
    final result = _instance._chat.getLastConnectedAt();
    sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }

  /// Gets the SDK socket connection state.
  static MyConnectionState getConnectionState() {
    final result = _instance._chat.getConnectionState();
    sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }

//------------------------------//
// Emoji
//------------------------------//
  /// Requests the all emoji.
  static Future<EmojiContainer> getAllEmoji() async {
    sbLog.i(StackTrace.current);
    return await _instance._chat.getAllEmoji();
  }

  /// Requests the emoji.
  static Future<Emoji> getEmoji(String key) async {
    sbLog.i(StackTrace.current);
    return await _instance._chat.getEmoji(key);
  }

  /// Requests the emoji category.
  static Future<EmojiCategory> getEmojiCategory(int categoryId) async {
    sbLog.i(StackTrace.current);
    return await _instance._chat.getEmojiCategory(categoryId);
  }

//------------------------------//
// Event Handler
//------------------------------//
  /// Adds a channel handler. All added handlers will be notified when events occur.
  static void addChannelHandler(String identifier, RootChannelHandler handler) {
    sbLog.i(StackTrace.current, 'identifier: $identifier');
    _instance._chat.addChannelHandler(identifier, handler);
  }

  /// Gets a channel handler.
  static BaseChannelHandler? getChannelHandler(String identifier) {
    sbLog.i(StackTrace.current, 'identifier: $identifier');
    return _instance._chat.getChannelHandler(identifier);
  }

  /// Removes a channel handler. The deleted handler no longer be notified.
  static void removeChannelHandler(String identifier) {
    sbLog.i(StackTrace.current, 'identifier: $identifier');
    _instance._chat.removeChannelHandler(identifier);
  }

  /// Removes all channel handlers added by [addChannelHandler].
  static void removeAllChannelHandlers() {
    sbLog.i(StackTrace.current);
    _instance._chat.removeAllChannelHandlers();
  }

  /// Adds a connection handler. All added handlers will be notified when events occurs.
  static void addConnectionHandler(
      String identifier, ConnectionHandler handler) {
    sbLog.i(StackTrace.current, 'identifier: $identifier');
    _instance._chat.addConnectionHandler(identifier, handler);
  }

  /// Gets a connection handler.
  static ConnectionHandler? getConnectionHandler(String identifier) {
    sbLog.i(StackTrace.current, 'identifier: $identifier');
    return _instance._chat.getConnectionHandler(identifier);
  }

  /// Removes a connection handler. The deleted handler no longer be notified.
  static void removeConnectionHandler(String identifier) {
    sbLog.i(StackTrace.current, 'identifier: $identifier');
    _instance._chat.removeConnectionHandler(identifier);
  }

  /// Removes all connection handlers added by [addConnectionHandler].
  static void removeAllConnectionHandlers() {
    sbLog.i(StackTrace.current);
    _instance._chat.removeAllConnectionHandlers();
  }

  /// Adds a user event handler. All added handlers will be notified when events occur.
  static void addUserEventHandler(String identifier, UserEventHandler handler) {
    sbLog.i(StackTrace.current, 'identifier: $identifier');
    _instance._chat.addUserEventHandler(identifier, handler);
  }

  /// Gets a user event handler.
  static UserEventHandler? getUserEventHandler(String identifier) {
    sbLog.i(StackTrace.current, 'identifier: $identifier');
    return _instance._chat.getUserEventHandler(identifier);
  }

  /// Removes a user event handler. The deleted handler no longer be notified.
  static void removeUserEventHandler(String identifier) {
    sbLog.i(StackTrace.current, 'identifier: $identifier');
    _instance._chat.removeUserEventHandler(identifier);
  }

  /// Removes all user event handlers added by [addUserEventHandler].
  static void removeAllUserEventHandlers() {
    sbLog.i(StackTrace.current);
    _instance._chat.removeAllUserEventHandlers();
  }

  /// Set a [SessionHandler] which is required for SDK refresh the session when the current session expires.
  /// Must be set before the connection is made by [connect].
  static void setSessionHandler(SessionHandler handler) {
    sbLog.i(StackTrace.current);
    _instance._chat.setSessionHandler(handler);
  }

  /// Gets a session handler.
  static SessionHandler? getSessionHandler() {
    sbLog.i(StackTrace.current);
    return _instance._chat.getSessionHandler();
  }

  /// Removes a session handler. The deleted handler no longer be notified.
  static void removeSessionHandler() {
    sbLog.i(StackTrace.current);
    _instance._chat.removeSessionHandler();
  }

//------------------------------//
// Push
//------------------------------//
  /// Registers push token for the current `User` to receive push notification.
  /// To enable push notification and get a token,
  /// Push token registration succeeds only when the connection ([connect]) is made.
  /// Otherwise, callback will return with [PushTokenRegistrationStatus.pending] status.
  /// Then, you can register push token again by calling [SendbirdChat.registerPushToken] after the connection is done.
  /// This just adds token to the server.
  /// If you want to register this token and delete all the previous ones, refer to [registerPushToken].
  static Future<PushTokenRegistrationStatus> registerPushToken({
    required PushTokenType type,
    required String token,
    bool alwaysPush = false,
    bool unique = false,
  }) async {
    sbLog.i(StackTrace.current, 'PushTokenType: $type');
    return await _instance._chat.registerPushToken(
      type: type,
      token: token,
      alwaysPush: alwaysPush,
      unique: unique,
    );
  }

  /// The pending push token. `null` if there is no registration pending token.
  static String? getPendingPushToken() {
    sbLog.i(StackTrace.current, 'getPendingPushToken()');
    return _instance._chat.getPendingPushToken();
  }

  /// Unregisters push token for the current `User`.
  static Future<void> unregisterPushToken({
    required PushTokenType type,
    required String token,
  }) async {
    sbLog.i(StackTrace.current, 'PushTokenType: $type');
    return await _instance._chat.unregisterPushToken(
      type: type,
      token: token,
    );
  }

  /// Unregisters all push token bound to the current `User`.
  static Future<void> unregisterPushTokenAll() async {
    sbLog.i(StackTrace.current);
    return await _instance._chat.unregisterPushTokenAll();
  }

  /// Sets the current `User`'s push trigger option.
  /// If certain channel's push trigger option is set to [GroupChannelPushTriggerOption.defaultValue],
  /// it works according to the state of [PushTriggerOption].
  /// If not, push messages will be triggered according to the state of [GroupChannelPushTriggerOption].
  /// Refer to [GroupChannelPushTriggerOption].
  static Future<void> setPushTriggerOption(PushTriggerOption option) async {
    sbLog.i(StackTrace.current, 'option: $option');
    await _instance._chat.setPushTriggerOption(option);
  }

  /// Gets the current `User`'s push trigger option. Refer to [PushTriggerOption].
  /// For details of push trigger option, refer to [setPushTriggerOption].
  static Future<PushTriggerOption> getPushTriggerOption() async {
    sbLog.i(StackTrace.current);
    return await _instance._chat.getPushTriggerOption();
  }

  /// Sets the push notification sound file path for the current `User`.
  /// This setting will be delivered on push notification payload.
  static Future<void> setPushSound(String sound) async {
    sbLog.i(StackTrace.current, 'sound: $sound');
    return await _instance._chat.setPushSound(sound);
  }

  /// Gets push notification sound path for the current `User`.
  static Future<String> getPushSound() async {
    sbLog.i(StackTrace.current);
    return await _instance._chat.getPushSound();
  }

  /// Sets push template option for the current `User`.
  /// The only valid arguments for template name are [SendbirdChat.pushTemplateDefault] and [SendbirdChat.pushTemplateAlternative].
  /// If [SendbirdChat.pushTemplateDefault] is set,
  /// the push notification will contain the original message in the `message` field of the push notification.
  /// If [SendbirdChat.pushTemplateAlternative] is set,
  /// `message` of push notification will be replaced by the content you've set on
  /// [Sendbird Dashboard](https://dashboard.sendbird.com).
  static Future<void> setPushTemplate(String name) async {
    sbLog.i(StackTrace.current, 'name: $name');
    return await _instance._chat.setPushTemplate(name);
  }

  /// Gets push template option for the current `User`.
  /// For details of push template option, refer to [setPushTemplate].
  /// This can be used, for instance,
  /// when you need to check the push notification content preview is on or off at the moment.
  static Future<String> getPushTemplate() async {
    sbLog.i(StackTrace.current);
    return await _instance._chat.getPushTemplate();
  }

//------------------------------//
// User
//------------------------------//
  /// The current connected [User]. `null` if [connect] is not called.
  static User? get currentUser {
    return _instance._chat.currentUser;
  }

  /// Updates current `User`'s information.
  static Future<void> updateCurrentUserInfo({
    String? nickname,
    FileInfo? profileFileInfo,
    List<String>? preferredLanguages,
    ProgressHandler? progressHandler,
  }) async {
    sbLog.i(StackTrace.current, 'nickname: $nickname');
    await _instance._chat.updateCurrentUserInfo(
      nickname: nickname,
      profileFileInfo: profileFileInfo,
      preferredLanguages: preferredLanguages,
      progressHandler: progressHandler,
    );
  }

  /// Blocks the specified `User` ID.
  /// Blocked `User` cannot send messages to the blocker.
  static Future<User> blockUser(String userId) async {
    sbLog.i(StackTrace.current, 'userId: $userId');
    return await _instance._chat.blockUser(userId);
  }

  /// Unblocks the specified `User` ID.
  /// Unblocked `User` cannot send messages to the ex-blocker.
  static Future<void> unblockUser(String userId) async {
    sbLog.i(StackTrace.current, 'userId: $userId');
    await _instance._chat.unblockUser(userId);
  }

  /// Sets Do-not-disturb option for the current `User`.
  /// If this option is enabled,
  /// the current `User` does not receive push notification during the specified time repeatedly.
  /// If you want to snooze specific period, use [setSnoozePeriod].
  static Future<void> setDoNotDisturb({
    required bool enable,
    int startHour = 0,
    int startMin = 0,
    int endHour = 23,
    int endMin = 59,
    String timezone = 'UTC',
  }) async {
    sbLog.i(StackTrace.current, 'enable: $enable');
    return await _instance._chat.setDoNotDisturb(
      enable: enable,
      startHour: startHour,
      startMin: startMin,
      endHour: endHour,
      endMin: endMin,
      timezone: timezone,
    );
  }

  /// Gets Do-not-disturb option for the current `User`.
  static Future<DoNotDisturb> getDoNotDisturb() async {
    sbLog.i(StackTrace.current);
    return await _instance._chat.getDoNotDisturb();
  }

  /// Sets snooze period for the current `User`.
  /// If this option is enabled,
  /// the current `User` does not receive push notification during the given period.
  /// It's not a repetitive operation.
  /// If you want to snooze repeatedly, use [setDoNotDisturb].
  static Future<void> setSnoozePeriod({
    required bool enable,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    sbLog.i(StackTrace.current, 'enable: $enable');
    return await _instance._chat.setSnoozePeriod(
      enable: enable,
      startDate: startDate,
      endDate: endDate,
    );
  }

  /// Gets snooze period for the current `User`.
  static Future<SnoozePeriod> getSnoozePeriod() async {
    sbLog.i(StackTrace.current);
    return await _instance._chat.getSnoozePeriod();
  }

//------------------------------//
// Notifications
//------------------------------//
  /// Retrieves Global Notification channel theme.
  /// @since 4.0.3
  static Future<GlobalNotificationChannelSetting>
      getGlobalNotificationChannelSetting() async {
    sbLog.i(StackTrace.current);
    return await _instance._chat.getGlobalNotificationChannelSetting();
  }

  /// Retrieves Notification template list by token.
  /// [token] is the value to retrieve notification template list from.
  /// @since 4.0.3
  static Future<NotificationTemplateList> getNotificationTemplateListByToken(
    NotificationTemplateListParams params, {
    String? token,
  }) async {
    sbLog.i(StackTrace.current);
    return await _instance._chat
        .getNotificationTemplateListByToken(params, token: token);
  }

  /// Retrieves Notification template.
  /// [key] is the template key.
  /// @since 4.0.3
  static Future<NotificationTemplate> getNotificationTemplate({
    required String key,
  }) async {
    sbLog.i(StackTrace.current);
    return await _instance._chat.getNotificationTemplate(key: key);
  }

  /// Authenticate with the Sendbird server.
  /// Calling this method will grant you access to Sendbird notification's features.
  /// If you want to access Sendbird Chat's features, call [SendbirdChat.connect].
  /// You can deauthenticate from the Sendbird server by calling [SendbirdChat.disconnect].
  /// @since 4.0.6
  static Future<User> authenticateFeed(
    String userId, {
    String? accessToken,
    String? apiHost,
  }) async {
    sbLog.i(StackTrace.current, 'userId: $userId');

    return await _instance._chat.authenticateFeed(
      userId,
      accessToken: accessToken,
      apiHost: apiHost,
    );
  }

  /// Refresh the contents of all notification collections that are currently valid.
  /// @since 4.0.6
  static void refreshNotificationCollections() {
    sbLog.i(StackTrace.current);

    _instance._chat.refreshNotificationCollections();
  }

//------------------------------//
// useCollectionCaching
//------------------------------//
  /// Gets cached data size. (Bytes)
  /// Refer to [SendbirdChatOptions.useCollectionCaching].
  /// @since 4.2.0
  static Future<int?> getCachedDataSize() async {
    return await _instance._chat.getCachedDataSize();
  }

  /// Clears all cached data.
  /// Refer to [SendbirdChatOptions.useCollectionCaching].
  /// @since 4.2.0
  static Future<void> clearCachedData() async {
    await _instance._chat.clearCachedData();
  }

  /// Clears cached messages regarding [channelUrl].
  /// Refer to [SendbirdChatOptions.useCollectionCaching].
  /// @since 4.2.0
  static Future<void> clearCachedMessages(String channelUrl) async {
    await _instance._chat.clearCachedMessages(channelUrl);
  }
}
