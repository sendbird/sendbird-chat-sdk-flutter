import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/constant/types.dart';
import 'package:sendbird_sdk/core/channel/base/base_channel.dart';
import 'package:sendbird_sdk/core/channel/group/features/delivery_status.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/models/app_info.dart';
import 'package:sendbird_sdk/core/models/emoji.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/image_info.dart';
import 'package:sendbird_sdk/core/models/options.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/core/models/unread_item_count.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/handlers/channel_event_handler.dart';
import 'package:sendbird_sdk/handlers/connection_event_handler.dart';
import 'package:sendbird_sdk/handlers/event_manager.dart';
import 'package:sendbird_sdk/handlers/session_event_handler.dart';
import 'package:sendbird_sdk/handlers/user_event_handler.dart';
import 'package:sendbird_sdk/params/group_channel_change_logs_params.dart';
import 'package:sendbird_sdk/params/group_channel_total_unread_message_count_params.dart';
import 'package:sendbird_sdk/sdk/internal/sendbird_sdk_internal.dart';
import 'package:sendbird_sdk/utils/logger.dart';

/// An object represents a main class to use Sendbird Chat
class SendbirdSdk {
  //Singleton Pattern
  static SendbirdSdk _instance = SendbirdSdk._instanceFunction();
  SendbirdSdk._instanceFunction();
  SendbirdSdkInternal _int;

  factory SendbirdSdk({
    String appId,
    String apiToken,
    Options options,
  }) {
    if (_instance != null &&
        (appId == null || appId == _instance._int?.state?.appId)) {
      _instance.setOptions(options);
      return _instance;
    }

    // initialize with different app id, so logout and
    // reinitialize internal obj
    _instance._int?.logout();
    _instance._int = SendbirdSdkInternal(
      appId: appId,
      apiToken: apiToken,
      options: options ?? Options(),
    );

    return _instance;
  }

  /// Sets [Options] to configure SDK
  void setOptions(Options options) {
    _int?.setOptions(options);
  }

  /// Returns current configuration [Options]
  Options getOptions() {
    return _int.options;
  }

  SendbirdSdkInternal getInternal() {
    return _int;
  }

  void setLogLevel(LogLevel level) {
    initLogger(level);
  }

  // public

  /// Connects to Sendbird server with given parameters. If previously connected
  /// and try to connect with different [userId] then everything will be reset
  /// before it attempts to connect. Provide [accessToken] can be used if you
  /// generated the token from platform api
  Future<User> connect(
    String userId, {
    String nickname,
    String accessToken,
    String apiHost,
    String wsHost,
  }) async {
    return _int.connect(
      userId: userId,
      nickname: nickname,
      accessToken: accessToken,
      apiHost: apiHost,
      wsHost: wsHost,
    );
  }

  /// Disconnects from Sendbird server
  void disconnect() {
    _int.logout();
  }

  /// Reconnects if previously connected and disconnect due to any reasons.
  /// It will return `false` if previous connection was not made.
  bool reconnect() {
    if (getCurrentUser() == null && _int.state.sessionKey == null) {
      return false;
    }

    _int.reconnect(reset: true);
    return true;
  }

  /// Returns current connected [User], nullable.
  User getCurrentUser() {
    return _int.state?.currentUser;
  }

  /// Returns current user's last connection timestamp as epoch milliseocnds,
  /// nullable
  int getLastConnectedAt() {
    return _int.state?.lastConnectedAt;
  }

  /// Add [ChannelEventHandler] with [identifier] to SDK.
  void addChannelHandler(String identifier, ChannelEventHandler handler) {
    _int.eventManager.addHandler(identifier, handler);
  }

  /// Returns [ChannelEventHandler] with given [identifier].
  ///
  /// null if handler is not found with [identifier]
  ChannelEventHandler getChannelHandler(String identifier) {
    return _int.eventManager.getHandler(
      identifier: identifier,
      type: EventType.channel,
    );
  }

  /// Removes [ChannelEventHandler] with [identifier] from SDK.
  void removeChannelHandler(String identifier) {
    _int.eventManager.removeHandler(identifier, EventType.channel);
  }

  /// Adds [ConnectionEventHandler] with [identifier] to SDK.
  void addConnectionHandler(String identifier, ConnectionEventHandler handler) {
    _int.eventManager.addHandler(identifier, handler);
  }

  /// Returns [ConnectionEventHandler] with [identifier] from SDK.
  ///
  /// null if the handler is not found with [identifier]
  ConnectionEventHandler getConnectionHandler(String identifier) {
    return _int.eventManager.getHandler(
      identifier: identifier,
      type: EventType.connection,
    );
  }

  /// Removes [ConnectionEventHandler] with [identifier] from SDK.
  void removeConnectionHandler(String identifier) {
    _int.eventManager.removeHandler(identifier, EventType.connection);
  }

  /// Adds [SessionEventHandler] to SDK.
  void addSessionHandler(SessionEventHandler handler) {
    _int.eventManager.addHandler('', handler);
  }

  /// Returns [SessionEventHandler] if registered
  SessionEventHandler getSessionHandler() {
    return _int.eventManager.getHandler(type: EventType.session);
  }

  /// Removes [SessionEventHandler] from SDK.
  void removeSessionHandler() {
    _int.eventManager.removeHandler('', EventType.session);
  }

  /// Adds [UserEventHandler] with [identifier] to SDK.
  void addUserEventHandler(String identifier, UserEventHandler handler) {
    _int.eventManager.addHandler(identifier, handler);
  }

  /// Returns [UserEventHandler] with [identifier] from SDK.
  UserEventHandler getUserEventHandler(String identifier) {
    return _int.eventManager.getHandler(
      identifier: identifier,
      type: EventType.userEvent,
    );
  }

  /// Removes [UserEventHandler] with [identifier] from SDK.
  void removeUserEventHandler(String identifier) {
    _int.eventManager.removeHandler(identifier, EventType.userEvent);
  }

  /// Returns current SDK version as `String`.
  String getSdkVersion() {
    return sdk_version;
  }

  /// True if SDK has been initialized.
  bool isInitialized() {
    return _int.state.appId != '';
  }

  /// Returns current application id as `String` if initialized.
  String getApplicationId() {
    return _int.state.appId;
  }

  /// Returns current application information with [AppInfo].
  AppInfo getAppInfo() {
    return _int.state.appInfo;
  }

  /// Returns [ConnectionState].
  ConnectionState getConnectionState() {
    if (_int.state.connecting || _int.state.reconnecting) {
      return ConnectionState.connecting;
    } else if (_int.webSocket != null) {
      return _int.webSocket.connectionState;
    }
    return ConnectionState.closed;
  }

  /// Updates current user information with [nickname], [imageInfo],
  /// [preferredLanguages].
  Future<void> updateCurrentUserInfo({
    String nickname,
    ImageInfo imageInfo,
    List<String> preferredLanguages,
    OnUploadProgressCallback progress,
  }) async {
    final user = await _int.api.updateUser(
      userId: _int.state.userId,
      nickname: nickname,
      imageInfo: imageInfo,
      preferredLanguages: preferredLanguages,
      progress: progress,
    );
    _int.state.currentUser.copyWith(user);
  }

  /// Blocks a user with [userId].
  Future<User> blockUser(String userId) async {
    return _int.api.blockUser(userId);
  }

  /// Unblocks a user with [userId].
  Future<void> unblockUser(String userId) async {
    return _int.api.unblockUser(userId);
  }

  /// Sets channel invitation preference with [autoAccept]. Default is `true`
  ///
  /// If [autoAccept] has been set to `false`, then current user won't be
  /// automatically joined to channels when get invited from other users
  Future<void> setChannelInvitationPreference(bool autoAccept) async {
    return _int.api.setAutoAcceptInvitation(autoAccept);
  }

  /// Returns `true` if channel invitation preference is set as auto accepted
  Future<bool> getChannelInvitationPreference() async {
    return _int.api.getAutoAcceptInvitation();
  }

  /// Returns pending push token
  String getPendingToken() {
    return _int.state.pushToken;
  }

  /// Registers push [token] with [type].
  ///
  /// In order to make push notification work with sendbird, [token] has to be
  /// registered with specific [PushTokenType] such as fcm or apns. If [unique]
  /// is `true` then only one push token will be keep tracked
  Future<PushTokenRegistrationStatus> registerPushToken({
    @required PushTokenType type,
    @required String token,
    bool unique = false,
  }) async {
    //if not connected return pending
    return _int.api.registerPushToken(type: type, token: token, unique: unique);
  }

  /// Unregisters push [token] with [type].
  ///
  /// Once [token] has been unregistered from sendbird server, associated device
  /// will not receive any push notification from sendbird.
  Future<void> unregisterPushToken({
    @required PushTokenType type,
    @required String token,
  }) async {
    return _int.api.unregisterPushToken(type: type, token: token);
  }

  /// Unregisters all push token with given [type].
  Future<void> unregisterAllPushToken(PushTokenType type) async {
    return _int.api.unregisterAllPushToken(type);
  }

  /// Sets do not disturb mode [enable] with given start and end time.
  Future<void> setDoNotDisturb({
    @required bool enable,
    int startHour = 0,
    int startMin = 0,
    int endHour = 23,
    int endMin = 59,
    String timezone,
  }) async {
    return _int.api.setDoNotDisturb(
      enable: enable,
      startHour: startHour,
      startMin: startMin,
      endHour: endHour,
      endMin: endMin,
      timezone: timezone,
    );
  }

  /// Returns current do not disturb mode
  Future<DoNotDisturbResponse> getDoNotDisturb() async {
    return _int.api.getDoNotDisturb();
  }

  /// Sets snooze period [enable] with start and end date.
  Future<void> setSnoozePeriod({
    @required bool enable,
    DateTime startDate,
    DateTime endDate,
  }) async {
    return _int.api.setSnoozePeriod(
      enable: enable,
      startDate: startDate,
      endDate: endDate,
    );
  }

  /// Returns current snooze period.
  Future<SnoozeResponse> getSnoozePeriod() async {
    return _int.api.getSnoozePeriod();
  }

  /// Sets push trigger [option] for current user.
  Future<void> setPushTriggerOption(PushTriggerOption option) async {
    return _int.api.setPushTriggerOption(option);
  }

  /// Returns [PushTriggerOption] of current user.
  Future<PushTriggerOption> getPushTriggerOption() async {
    return _int.api.getPushTriggerOption();
  }

  /// Sets push [sound].
  Future<void> setPushSound(String sound) async {
    return _int.api.setPushSound(sound);
  }

  /// Returns push sound in `String`
  Future<String> getPushSound() async {
    return _int.api.getPushSound();
  }

  /// Sets push template with [name]
  Future<void> setPushTemplate(String name) async {
    return _int.api.setPushTemplate(name);
  }

  /// Get push template
  Future<String> getPushTemplate() async {
    return _int.api.getPushTemplate();
  }

  // TBD
  // Future<PushTokenResponse> getMyPushToken(String next, PushTokenType tokenType) async {
  //   return null;
  // }

  // Channels

  /// Get current user's group channel change logs with [params]
  ///
  /// Provide either [token] or [timestamp] to retrieve change logs. Return value
  /// may contains updated or deleted channels along with next token if there
  /// are more to load
  Future<ChannelChangeLogsResponse> getMyGroupChannelChangeLogs({
    @required GroupChannelChangeLogsParams params,
    String token,
    int timestamp,
  }) async {
    return _int.api.getGroupChannelChangeLogs(
      params: params,
      userId: _int.state.userId,
      token: token,
      timestamp: timestamp,
    );
  }

  /// Mark current user's all group channels as read.
  Future<void> markAsReadAll() async {
    await _int.api.markAsRead(userId: _int.state.userId);
  }

  /// Mark list of group channels with [channelUrls] as read.
  Future<void> markAsRead({@required List<String> channelUrls}) async {
    if (channelUrls == null || channelUrls.isEmpty)
      throw InvalidParameterError();
    await _int.api.markAsRead(
      channelUrls: channelUrls,
      userId: _int.state.userId,
    );
  }

  /// Mark a message as delivered with given payload from push notification
  Future<void> markAsDelivered({Map<String, dynamic> payload}) async {
    if (payload == null) throw InvalidParameterError();

    Map<String, dynamic> sendbird = payload['sendbird'];
    String appId, userId, channelUrl, sessionKey;
    int createdAt;

    if (sendbird != null) {
      Map<String, dynamic> recipient = sendbird['recipient'];
      Map<String, dynamic> channel = sendbird['channel'];
      Map<String, dynamic> session = sendbird['session_key'];

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
        createdAt > 0) {
      SendbirdSdk(appId: appId);

      _int.sessionManager
          .setUserId(_int.state.userId != null ? _int.state.userId : userId);
      _int.sessionManager.setSessionKey(sessionKey);
      await _int.api.markAsDelivered(channelUrl: channelUrl, userId: userId);
    } else {
      throw InvalidParameterError();
    }
  }

  /// Returns number of group channel with given [filter].
  Future<int> getGroupChannelCount(MemberStateFilter filter) async {
    return _int.api.getGroupChannelCount(
      memberFilter: filter,
      userId: _int.state.userId,
    );
  }

  /// Returns total number of group channels that contains unread messages.
  Future<int> getTotalUnreadChannelCount() async {
    return _int.api.getTotalUnreadChannelCount(userId: _int.state.userId);
  }

  /// Returns total number of unrad messages.
  Future<int> getTotalUnreadMessageCount() async {
    final params = GroupChannelTotalUnreadMessageCountParams();
    params.superChannelFilter = GroupChannelSuperChannelFilter.all;
    return getTotalUnreadMessageCountWithParams(params);
  }

  /// Returns total number of unread messages with given [params].
  Future<int> getTotalUnreadMessageCountWithParams(
      GroupChannelTotalUnreadMessageCountParams params) async {
    return _int.api.getTotalUnreadMessageCount(
      customTypes: params?.customTypes,
      filter: params?.superChannelFilter,
    );
  }

  /// Returns [UnreadItemCount] with given [keys].
  ///
  /// [UnreadItemCount] will only contain values that associated with [keys],
  /// otherwise null.
  Future<UnreadItemCount> getUnreadItemCount(List<UnreadItemKey> keys) async {
    return _int.api.getUnreadItemCount(keys: keys, userId: _int.state.userId);
  }

  /// Returns total unread message count for subscribed
  int get subscribedTotalUnreadMessageCount {
    return _int.state.unreadCountInfo.all;
  }

  /// Returns total unread message count for subscribed custom types
  int get subscribedCustomTypeTotalUnreadMessageCount {
    return _int.state.unreadCountInfo.customTypes.values
        .reduce((a, b) => a + b);
  }

  /// Returns total unread messgea count for given custom type
  int subscribedCustomTypeUnreadMessageCount(String customType) {
    return _int.state.unreadCountInfo.customTypes[customType];
  }

  /// Returns a stream to listen message count has been changed
  Stream<int> get totalUnreadMessageCountStream {
    if (getCurrentUser() == null) return null;
    return _int.streamManager.unread.stream;
  }

  /// Retruns a stream to listen message update event with given [channelUrl].
  ///
  /// It will be triggered every message update if [channelUrl] is not provided.
  Stream<BaseMessage> messageUpdateStream({String channelUrl}) async* {
    if (getCurrentUser() == null) yield null;
    await for (final res in _int.streamManager.msgUpdated.stream) {
      if (channelUrl != null) {
        if (res.channel.channelUrl == channelUrl) yield res.message;
      } else {
        yield res.message;
      }
    }
  }

  /// Returns a stream to listen new messsage event with given [channelUrl].
  ///
  /// It will be triggered every new message if [channelUrl] is not provided
  Stream<BaseMessage> messageReceiveStream({String channelUrl}) async* {
    if (getCurrentUser() == null) yield null;
    await for (final res in _int.streamManager.msgReceived.stream) {
      if (channelUrl != null) {
        if (res.channel.channelUrl == channelUrl) yield res.message;
      } else {
        yield res.message;
      }
    }
  }

  /// Returns a stream to listen messsage delete event with given [channelUrl].
  ///
  /// It will be triggered every message deletion if [channelUrl] is not provided
  Stream<int> messageDeleteStream({String channelUrl}) async* {
    if (getCurrentUser() == null) yield null;
    await for (final res in _int.streamManager.msgDeletd.stream) {
      if (channelUrl != null) {
        if (res.channel.channelUrl == channelUrl) yield res.deletedId;
      } else {
        yield res.deletedId;
      }
    }
  }

  /// Returns a stream to listen channel change event with given [channelUrl]
  ///
  /// It will be triggered every channel chaange if [channelUrl] is not provided
  Stream<BaseChannel> channelChangedStream({String channelUrl}) async* {
    if (getCurrentUser() == null) yield null;
    await for (final res in _int.streamManager.channelChanged.stream) {
      if (channelUrl != null) {
        if (res.channelUrl == channelUrl) yield res;
      } else {
        yield res;
      }
    }
  }

  /// Returns a stream to listen read event with given [channelUrl]
  ///
  /// It will be triggered every read event if [channelUrl] is not provided
  Stream<GroupChannel> readStream({String channelUrl}) async* {
    if (getCurrentUser() == null) yield null;
    await for (final res in _int.streamManager.read.stream) {
      if (channelUrl != null) {
        if (res.channelUrl == channelUrl) yield res;
      } else {
        yield res;
      }
    }
  }

  /// Returns a stream to listen delivery event with given [channelUrl]
  ///
  /// It will be triggered every delivery event if [channelUrl] is not provided
  Stream<Map<String, int>> deliveryStream({String channelUrl}) async* {
    if (getCurrentUser() == null) yield null;
    await for (final res in _int.streamManager.delivery.stream) {
      if (channelUrl != null) {
        if (res.channelUrl == channelUrl) {
          final status =
              _int.cache.find<DeliveryStatus>(channelKey: channelUrl);
          yield status.updatedDeliveryReceipt;
        }
      } else {
        final status =
            _int.cache.find<DeliveryStatus>(channelKey: res.channelUrl);
        yield status.updatedDeliveryReceipt;
      }
    }
  }

  /// Returns a stream to listen typing event with given [channelUrl]
  ///
  /// It will be triggered for every typing event if [channelUrl] is not provided
  Stream<List<User>> usersTypingStream({String channelUrl}) async* {
    if (getCurrentUser() == null) yield null;
    await for (final res in _int.streamManager.typing.stream) {
      if (channelUrl != null) {
        if (res.channelUrl == channelUrl) yield res.getTypingUsers();
      } else {
        yield res.getTypingUsers();
      }
    }
  }

  /// Returns a stream to listen connection events
  Stream<ConnectionEventType> get connectionStream {
    if (getCurrentUser() == null) return null;
    return _int.streamManager.connection.stream;
  }

  // Friends
  // TBD

  /// Returns [EmojiContainer] which contains all available [Emoji]
  Future<EmojiContainer> getAllEmojis() {
    return _int.api.getAllEmojis();
  }

  /// Returns an [Emoji] with given [key]
  Future<Emoji> getEmoji(String key) {
    if (key == null || key.isEmpty) throw InvalidParameterError();
    return _int.api.getEmoji(key);
  }

  /// Return an [EmojiCategory] with given [categoryId]
  Future<EmojiCategory> getEmojiCategory(int categoryId) {
    if (categoryId == null || categoryId <= 0) throw InvalidParameterError();
    return _int.api.getEmojiCategory(categoryId);
  }

  // -- internal

  void addVersionExtension(String key, String version) {
    _int.addVersionExtension(key, version);
  }
}
