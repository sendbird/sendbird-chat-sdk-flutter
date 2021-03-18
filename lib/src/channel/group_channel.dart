import 'package:json_annotation/json_annotation.dart';

import '../channel/base_channel.dart';
import '../constant/enums.dart';
import '../constant/types.dart';
import '../models/command.dart';
import '../features/delivery/delivery_status.dart';
import '../features/read/read_status.dart';
import '../features/typing/typing_status.dart';
import '../message/admin_message.dart';
import '../message/base_message.dart';
import '../message/scheduled_user_message.dart';
import '../models/error.dart';
import '../models/member.dart';
import '../models/user.dart';
import '../params/group_channel_params.dart';
import '../params/scheduled_user_message_params.dart';
import '../sdk/sendbird_sdk_api.dart';
import '../sdk/sendbird_sdk_internal.dart';
import '../services/db/cache_service.dart';
import '../utils/json_from_parser.dart';

import 'group_channel_internal.dart';

part 'group_channel.g.dart';

/// Represents group channel
///
/// In most case, any static or instance method will throw a [SBError] if
/// anything goes wrong such as parameter is not provided or connection has not
/// been maded. Use method with try/catch block or then/catchError callback
///
/// ```
/// try {
///    final channel = GroupChannel.getChannel('1234');
///    //do something with channel
/// } catch (e) {
///    //handle error
/// }
/// ```
/// or
/// ```
/// GroupChannel.getChannel('1234').then((channel) {
///   //do seomthing with channel
/// }).catchError((e) {
///   //handle error
/// })
/// ```
///
@JsonSerializable()
class GroupChannel extends BaseChannel {
  /// Last message of the channel
  BaseMessage lastMessage;

  /// True if this channel is super channel
  final bool isSuper;

  /// True if this channel is strict
  @JsonKey(defaultValue: false)
  final bool isStrict;

  /// True if this channel is broadcast
  final bool isBroadcast;

  /// True if this channel is public
  bool isPublic;

  /// True if this channel is distinct
  bool isDistinct;

  /// True if this channel is discoverable
  /// It is only for a public group channel.
  bool isDiscoverable;

  /// True if this channel is required access code
  bool accessCodeRequired;

  /// Unread message count of the channel
  int unreadMessageCount;

  /// The number of mentions that user does not read yet in the channel
  int unreadMentionCount;

  /// Channel members
  /// Note: Number of member for SuperGroupChannel is limited to 10
  List<Member> members;

  /// Number of members
  int memberCount;

  /// Number of joined member
  int joinedMemberCount;

  /// Push notification option for the current user to receive in the group channel
  @JsonKey(name: 'push_trigger_option')
  GroupChannelPushTriggerOption myPushTriggerOption;

  /// Member state of current user in this channel
  @JsonKey(name: 'member_state')
  MemberState myMemberState;

  /// Role of current user in this channel
  @JsonKey(unknownEnumValue: Role.none)
  Role myRole;

  /// Muted state of current user in this channel
  @JsonKey(fromJson: booltoMuteState, name: 'is_muted')
  MuteState myMutedState;

  /// Message count preference of current user in this channel
  /// The default value is all
  @JsonKey(name: 'count_preference')
  CountPreference myCountPreference;

  /// User who invited
  Member inviter;

  /// The time stamp when current user got a invitation
  /// from other user in the channel
  int invitedAt;

  /// True if this channel is hidden
  bool isHidden;

  /// Hidden state of this channel
  GroupChannelHiddenState hiddenState;

  /// A last read information for the current user
  @JsonKey(name: 'user_last_read')
  int myLastRead;

  /// Message offset of this channel. User can only see messages after this offset
  @JsonKey(name: 'ts_message_offset')
  int messageOffsetTimestamp;

  /// A value that sets the message survival time in seconds. In the channel
  /// that is created or updated with this option, the read messages are
  /// automatically deleted after a determined amount of time. The default
  /// value is `-1` that represents the disappearing message is disabled.
  /// Note: This feature is available in a 1-on-1 group channel.
  int messageSurvivalSeconds;

  int _lastStartTypingTimestamp = 0;
  int _lastEndTypingTimestamp = 0;

  /// **WARNING:** Do not use default constructor to initialize manually
  GroupChannel({
    this.lastMessage,
    this.isSuper,
    this.isStrict,
    this.isBroadcast,
    this.isPublic,
    this.isDistinct,
    this.isDiscoverable,
    this.accessCodeRequired,
    this.unreadMessageCount,
    this.unreadMentionCount,
    this.members,
    this.memberCount,
    this.joinedMemberCount,
    this.myPushTriggerOption,
    this.myMemberState,
    this.myRole,
    this.myMutedState,
    this.myCountPreference,
    this.invitedAt,
    this.isHidden,
    this.hiddenState,
    this.myLastRead,
    this.messageOffsetTimestamp,
    this.messageSurvivalSeconds,
    String channelUrl,
    String name,
    String coverUrl,
    User creator,
    int createdAt,
    String data,
    String customType,
    bool isFrozen,
    bool isEphemeral,
  }) : super(
          channelUrl: channelUrl,
          name: name,
          coverUrl: coverUrl,
          creator: creator,
          createdAt: createdAt,
          data: data,
          customType: customType,
          isFrozen: isFrozen,
          isEphemeral: isEphemeral,
          fromCache: false,
          dirty: false,
        );

  SendbirdSdkInternal _sdk = SendbirdSdk().getInternal();

  /// Gets an [GroupChannel] with given [channelUrl]
  static Future<GroupChannel> getChannel(String channelUrl) async {
    final sdk = SendbirdSdk().getInternal();
    var channel = sdk.cache.find<GroupChannel>(channelKey: channelUrl);
    if (channel != null && !channel.dirty) {
      channel.fromCache = true;
      return channel;
    }

    return GroupChannel.refresh(channelUrl);
  }

  /// Refreshes an [GroupChannel] with given [channelUrl]
  static Future<GroupChannel> refresh(String channelUrl) async {
    final sdk = SendbirdSdk().getInternal();
    final result = await sdk.api.getChannel(
      channelType: ChannelType.group,
      channelUrl: channelUrl,
      passive: false,
      options: [
        ChannelQueryIncludeOption.deliveryReceipt,
        ChannelQueryIncludeOption.readReceipt,
        ChannelQueryIncludeOption.memberList,
      ],
    );
    return result;
  }

  /// Creates a channel with given [params].
  ///
  /// After this method completes successfully, channel event such as
  /// [ChannelEventHandler.onUserJoined],
  /// [ChannelEventHandler.onUserReceivedInvitation] and/or
  /// [ChannelEventHandler.onChannelOperatorsUpdated] can be invoked based
  /// on the given [params].
  static Future<GroupChannel> createChannel(
    GroupChannelParams params, {
    OnUploadProgressCallback progress,
  }) async {
    final sdk = SendbirdSdk().getInternal();
    if (params.userIds == null) {
      params.userIds = [sdk.state.userId];
    } else if (!params.userIds.contains(sdk.state.userId)) {
      params.userIds.add(sdk.state.userId);
    }
    return sdk.api.createGroupChannel(params, progress: progress);
  }

  /// Updates this channel with given [params] and optional [progress].
  ///
  /// After this method completes successfully, channel event such as
  /// [ChannelEventHandler.onChannelOperatorsUpdated] and
  /// [ChannelEventHandler.onChannelChanged] can be invoked
  /// based on given [params].
  Future<GroupChannel> updateChannel(
    GroupChannelParams params, {
    OnUploadProgressCallback progress,
  }) async {
    if (params == null) {
      throw InvalidParameterError();
    }
    if (params.channelUrl == null) {
      params.channelUrl = channelUrl;
    }
    if (params.channelUrl != channelUrl) {
      throw InvalidParameterError();
    }

    return _sdk.api.updateGroupChannel(
      params,
      progress: (sentBytes, totalBytes) {
        if (progress != null) progress(sentBytes, totalBytes);
      },
    );
  }

  /// Deletes this channel.
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onChannelDeleted] will be invoked
  Future<void> deleteChannel() async {
    await _sdk.api.deleteChannel(
      channelType: channelType,
      channelUrl: channelUrl,
    );
    if (!isPublic) removeFromCache();
  }

  /// Hides this channel.
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onChannelHidden] will be invoked.
  Future<void> hideChannel({
    bool hidePreviousMessage = false,
    bool allowAutoUnhide = true,
  }) async {
    final offset = await _sdk.api.hideGroupChannel(
      channelUrl: channelUrl,
      hidePreviousMessages: hidePreviousMessage,
      allowAutoUnhide: allowAutoUnhide,
    );

    if (offset != null) messageOffsetTimestamp = offset;
    if (hidePreviousMessage) this.clearUnreadCount();

    isHidden = true;
    hiddenState = allowAutoUnhide
        ? GroupChannelHiddenState.allowAutoUnhide
        : GroupChannelHiddenState.preventAutoUnhide;
  }

  /// Unhides this channel
  Future<void> unhideChannel() async {
    await _sdk.api.unhideGroupChannel(channelUrl: channelUrl);
    isHidden = false;
    hiddenState = GroupChannelHiddenState.unhidden;
  }

  /// Resets (clear) any previous messages on this channel.
  Future<void> resetMyHistory() async {
    final offset =
        await _sdk.api.resetGroupChannelHistory(channelUrl: channelUrl);
    if (offset != null) {
      messageOffsetTimestamp = offset;
    }
  }

  /// Registers a [ScheduledUserMessage] with given [params].
  Future<ScheduledUserMessage> registerScheduledUserMessage(
      ScheduledUserMessageParams params) async {
    if (params == null) {
      throw InvalidParameterError();
    }

    return _sdk.api.registerScheduleUserMessage(
      channelType: channelType,
      channelUrl: channelUrl,
      params: params,
      userId: _sdk.state.userId,
    );
  }

  /// Invites one or more [User] with given `userIds` to this channel.
  ///
  /// After this method completes successfully,
  /// [ChannelEventHandler.onUserReceivedInvitation]
  /// will be invoked on each invited user's end and
  /// [ChannelEventHandler.onUserJoined] can be
  /// invoked based on their channel invitation preference which can be set
  /// through [SendbirdSdk.setChannelInvitationPreference]
  Future<void> inviteUsers(List<String> userIds) async {
    if (userIds == null || userIds.isEmpty) {
      throw InvalidParameterError();
    }

    await _sdk.api.inviteUsers(
      userIds: userIds,
      channelUrl: channelUrl,
      inviterId: _sdk.state.userId,
    );
  }

  /// Accepts received invitation to join on this channel.
  ///
  /// If this channel sets [accessCode] to join, you have to provide
  /// [accessCode] as parameter. After this method completes successfully,
  /// channel event [ChannelEventHandler.onUserJoined] will be invoked.
  Future<void> acceptInvitation({String accessCode}) async {
    //await or return?
    await _sdk.api.acceptInvitation(
      channelUrl: channelUrl,
      accessCode: accessCode,
    );
  }

  /// Declines received invitation to join this channel.
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onUserDeclinedInvitation] will be invoked.
  Future<void> declineInvitation() async {
    await _sdk.api.declineInvitation(channelUrl: channelUrl);
  }

  /// Joins this channel
  ///
  /// If this channel sets [accessCode] to join, you have to provide
  /// [accessCode] as parameter. After this method completes successfully,
  /// channel event [ChannelEventHandler.onUserJoined] will be invoked.
  Future<void> join({String accessCode}) async {
    await _sdk.api.joinGroupChannel(
      channelUrl: channelUrl,
      accessCode: accessCode,
    );
  }

  /// Leaves this channel
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onUserLeaved] will be invoked.
  Future<void> leave() async {
    await _sdk.api.leaveGroupChannel(channelUrl: channelUrl);
  }

  /// Returns [Member] with given [userId]. It will return `null` if [userId]
  /// is not exist in members.
  Member getMember(String userId) {
    return members?.firstWhere((element) => element.userId == userId,
        orElse: () => null);
  }

  /// Starts to send typing signal.
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onTypingStatusUpdated] will be invoked.
  void startTyping() {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastStartTypingTimestamp >
        _sdk.options.typingIndicatorThrottle) {
      final cmd = Command.buildStartTyping(channelUrl, now);
      _sdk.cmdManager.sendCommand(cmd);
      _lastStartTypingTimestamp = now;
      _lastEndTypingTimestamp = 0;
    }
  }

  /// Stops to send typing signal.
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onTypingStatusUpdated] will be invoked.
  void endTyping() {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastEndTypingTimestamp > _sdk.options.typingIndicatorThrottle) {
      final cmd = Command.buildEndTyping(channelUrl, now);
      _sdk.cmdManager.sendCommand(cmd);
      _lastStartTypingTimestamp = 0;
      _lastEndTypingTimestamp = now;
    }
  }

  /// Returns `true` if any members has been typing.
  bool get isTyping {
    final typingStatuses =
        _sdk.cache.findAll<TypingStatus>(channelKey: channelUrl);
    return typingStatuses != null && typingStatuses.length > 0;
  }

  /// Returns a list of [User] who are currently typing.
  List<User> getTypingUsers() {
    final typingStatuses =
        _sdk.cache.findAll<TypingStatus>(channelKey: channelUrl);
    return typingStatuses.map((e) => e.user).toList();
  }

  /// Marks as read with current time.
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onReadReceiptUpdated] can be invoked
  void markAsRead() {
    final cmd = Command.buildRead(channelUrl);
    _sdk.cmdManager.sendCommand(cmd);
  }

  /// Returns a list of [Member] who has read given [message]. If [includeAll]
  /// is provided as `true` then current user will be included as well.
  List<Member> getReadMembers(BaseMessage message, bool includeAll) {
    if (message is AdminMessage) return [];
    if (isSuper) return [];
    if (message == null) {
      throw InvalidParameterError();
    }
    // if (_sdk.state.currentUser == null) return []; //check connection

    return members.where((m) {
      if (!includeAll && m.isCurrentUser) return false;
      if (message.sender.userId == m.userId) return false;
      final readStatus = _sdk.cache.find<ReadStatus>(
        channelKey: channelUrl,
        key: m.userId,
      );
      if (readStatus == null || readStatus.timestamp == null) return false;
      return readStatus.timestamp >= message.createdAt;
    }).toList();
  }

  /// Returns a list of [Member] who has not read given [message]. If
  /// [includeAll] is provided as `true` then current user will be included
  /// as well.
  List<Member> getUnreadMembers(BaseMessage message, bool includeAll) {
    if (message is AdminMessage) return [];
    if (isSuper) return [];
    if (message == null) {
      throw InvalidParameterError();
    }
    // if (_sdk.state.currentUser == null) return []; //check connection

    return members.where((m) {
      if (!includeAll && m.isCurrentUser) return false;
      if (message.sender.userId == m.userId) return false;
      final readStatus = _sdk.cache.find<ReadStatus>(
        channelKey: channelUrl,
        key: m.userId,
      );
      if (readStatus == null) return false;
      return readStatus.timestamp < message.createdAt;
    }).toList();
  }

  /// Returns `Map` with key as userId String and value as `Map` that conatins
  /// two keys: `user` and `last_seen_at`. If [includeAll] is provided as
  /// `true` then current user will be included as well.
  ///
  /// ```
  /// {
  ///   'userId1': {
  ///     'user': User(),
  ///     'last_seen_at': 1682131232
  ///   }
  /// }
  /// ```
  Map<String, Map<String, dynamic>> getReadStatus(bool includeAll) {
    if (isSuper) return {};
    // if (_sdk.state.currentUser == null) return []; //check connection
    return Map.fromIterable(
        members.where((m) {
          if (!includeAll && m.isCurrentUser) return false;
          return true;
        }),
        key: (m) => m.userId,
        value: (m) {
          final readStatus = _sdk.cache.find<ReadStatus>(
            channelKey: channelUrl,
            key: m.userId,
          );
          return {'user': m, 'last_seen_at': readStatus.timestamp};
        });
  }

  /// Returns unread member count as [int] with given [message].
  // int getUnreadMemberCount(BaseMessage message) {
  //   return getUnreadMembers(message, false)
  //       .where((e) => e.state == MemberState.joined)
  //       .length;
  // }

  /// Returns undelivered member count as [int] with given [message].
  List<Member> getUndeliveredMembers(BaseMessage message) {
    if (message is AdminMessage) return [];
    if (isSuper) return [];
    // if (_sdk.state.currentUser == null) return []; //check connection

    final deliveryStatus =
        _sdk.cache.find<DeliveryStatus>(channelKey: channelUrl);

    // delivery receipt feature is not on, throw?
    if (deliveryStatus == null) return [];

    return members.where((m) {
      if (m.isCurrentUser) return false;
      if (message.sender.userId == m.userId) return false;
      if (m.state != MemberState.joined) return false;
      final deliveredAt = deliveryStatus.updatedDeliveryReceipt[m.userId] ?? 0;
      return deliveredAt < message.createdAt;
    }).toList();
  }

  /// Returns current user's [GroupChannelPushTriggerOption] on this channel.
  Future<GroupChannelPushTriggerOption> getMyPushTriggerOption() async {
    return _sdk.api.getGroupChannelPushTriggerOption(channelUrl);
  }

  /// Sets current user's push trigger [option] on this channel.
  Future<void> setMyPushTriggerOption(
    GroupChannelPushTriggerOption option,
  ) async {
    if (option == null) {
      throw InvalidParameterError();
    }

    final result = await _sdk.api.setGroupChannelPushTriggerOption(
      channelUrl: channelUrl,
      option: option,
    );
    myPushTriggerOption = result;
  }

  /// Sets current user's count preference with [countPreference].
  Future<void> setMyCountPreference(CountPreference countPreference) async {
    if (countPreference == null) {
      throw InvalidParameterError();
    }

    final result = await _sdk.api.setCountPreference(
      channelUrl: channelUrl,
      prefs: countPreference,
    );
    myCountPreference = result;
    if (canChangeUnreadMessageCount) unreadMessageCount = 0;
    if (canChangeUnreadMentionCount) unreadMentionCount = 0;
  }

  /// Freezes this channel.
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onChannelFrozen] will be invoked. Operator only
  Future<void> freeze() async {
    return _sdk.api.freezeChannel(
      channelType: channelType,
      channelUrl: channelUrl,
      freeze: true,
    );
  }

  /// Unfreezes this channel.
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onChannelUnfrozen] will be invoked. Operator only
  Future<void> unfreeze() async {
    return _sdk.api.freezeChannel(
      channelType: channelType,
      channelUrl: channelUrl,
      freeze: false,
    );
  }

  /// Notifies screenshot was taken on this channel.
  Future<void> notifyScreenshotWasTaken() async {
    return _sdk.api.notifyScreenshotWasTaken(channelUrl);
  }

  /// json serialization
  factory GroupChannel.fromJson(Map<String, dynamic> json) {
    final channel = _$GroupChannelFromJson(json);
    // channel.saveToCache();

    if (json['read_receipt'] != null) {
      final data = Map<String, int>.from(json['read_receipt']);
      data.forEach((key, value) {
        final read = ReadStatus(
          channelType: channel.channelType,
          channelUrl: channel.channelUrl,
          userId: key,
          timestamp: value,
        );
        read.saveToCache();
      });
    }

    if (json['delivery_receipt'] != null) {
      final delivery = DeliveryStatus(
        channelUrl: channel.channelUrl,
        updatedDeliveryReceipt: Map<String, int>.from(json['delivery_receipt']),
      );
      delivery.saveToCache();
    }

    return channel;
  }
  // Map<String, dynamic> toJson() => _$GroupChannelToJson(this);

  factory GroupChannel.fromJsonAndCached(Map<String, dynamic> json) {
    final channel = _$GroupChannelFromJson(json);
    channel.saveToCache();

    if (json['read_receipt'] != null) {
      final data = Map<String, int>.from(json['read_receipt']);
      data.forEach((key, value) {
        final status = ReadStatus(
          channelType: channel.channelType,
          channelUrl: channel.channelUrl,
          userId: key,
          timestamp: value,
        );
        status.saveToCache();
      });
    }

    if (json['delivery_receipt'] != null) {
      final status = DeliveryStatus(
        channelUrl: channel.channelUrl,
        updatedDeliveryReceipt: Map<String, int>.from(json['delivery_receipt']),
      );
      status.saveToCache();
    }

    return channel;
  }

  @override
  void copyWith(dynamic other) {
    super.copyWith(other);
    if (other is GroupChannel) {
      lastMessage = other.lastMessage;
      unreadMentionCount = other.unreadMentionCount;
      unreadMessageCount = other.unreadMessageCount;
      isPublic = other.isPublic;
      isDiscoverable = other.isDiscoverable;
      accessCodeRequired = other.accessCodeRequired;
      members = List<Member>.from(other.members);
      memberCount = other.memberCount;
      joinedMemberCount = other.joinedMemberCount;
      myPushTriggerOption = other.myPushTriggerOption;
      myMemberState = other.myMemberState;
      myRole = other.myRole;
      myMutedState = other.myMutedState;
      inviter = other.inviter;
      invitedAt = other.invitedAt;
      isHidden = other.isHidden;
      hiddenState = other.hiddenState;
      myLastRead = other.myLastRead;
      messageOffsetTimestamp = other.messageOffsetTimestamp;
      messageSurvivalSeconds = other.messageSurvivalSeconds;
    }
  }

  ///
  /// Builds a message object from serialized data
  // static GroupChannel buildFromSeralizedData(ByteData data) {
  //   return null;
  // }

  // /// Serializes message object
  // ByteData serialize() {
  //   return null;
  // }
}
