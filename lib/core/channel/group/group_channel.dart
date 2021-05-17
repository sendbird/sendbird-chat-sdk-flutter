import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/constant/types.dart';
import 'package:sendbird_sdk/core/channel/base/base_channel.dart';
import 'package:sendbird_sdk/core/channel/group/features/delivery_status.dart';
import 'package:sendbird_sdk/core/channel/group/features/read_status.dart';
import 'package:sendbird_sdk/core/channel/group/features/typing_status.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel_internal.dart';
import 'package:sendbird_sdk/core/message/admin_message.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/message/scheduled_user_message.dart';
import 'package:sendbird_sdk/core/models/command.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/member.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/params/group_channel_params.dart';
import 'package:sendbird_sdk/params/scheduled_user_message_params.dart';
import 'package:sendbird_sdk/sdk/internal/sendbird_sdk_internal.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:sendbird_sdk/services/db/cache_utils.dart';
import 'package:sendbird_sdk/services/db/cache_service.dart';
import 'package:sendbird_sdk/utils/json_from_parser.dart';

part 'group_channel.g.dart';
part 'group_channel_operations.dart';
part 'group_channel_typing.dart';
part 'group_channel_read.dart';
part 'group_channel_configuration.dart';

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

  /// Timestamp when current user got a invitation
  /// from other user in the channel
  @JsonKey(defaultValue: 0)
  int invitedAt;

  /// Timestamp when current user joined on this channel
  @JsonKey(name: 'joined_ts', defaultValue: 0)
  int joinedAt;

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
  int _lastMarkAsReadTimestamp = 0;

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
    this.joinedAt,
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
        ChannelQueryIncludeOption.metaData,
      ],
    );
    return result;
  }

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
    params.channelUrl ??= channelUrl;

    if (params.channelUrl != channelUrl) {
      throw InvalidParameterError();
    }

    return _sdk.api.updateGroupChannel(params, progress: progress);
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

  /// Returns [Member] with given [userId]. It will return `null` if [userId]
  /// is not exist in members.
  Member getMember(String userId) {
    return members?.firstWhere((element) => element.userId == userId,
        orElse: () => null);
  }

  // json serialization

  factory GroupChannel.fromJson(Map<String, dynamic> json) {
    final channel = _$GroupChannelFromJson(json);
    json.cacheMetaData(channel: channel);
    json.cacheDeliveryReceipt(channel);
    json.cacheReadReceipt(channel);
    return channel;
  }

  factory GroupChannel.fromJsonAndCached(Map<String, dynamic> json, {int ts}) {
    final channel = _$GroupChannelFromJson(json);
    channel.saveToCache();
    json.cacheMetaData(channel: channel, ts: ts);
    json.cacheDeliveryReceipt(channel);
    json.cacheReadReceipt(channel);
    return channel;
  }

  Map<String, dynamic> toJson() => _$GroupChannelToJson(this);

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;
    if (!(super == (other))) return false;

    final eq = ListEquality().equals;
    return other is GroupChannel &&
        other.lastMessage == lastMessage &&
        other.isSuper == isSuper &&
        other.isStrict == isStrict &&
        other.isBroadcast == isBroadcast &&
        other.isPublic == isPublic &&
        other.isDistinct == isDistinct &&
        other.isDiscoverable == isDiscoverable &&
        other.accessCodeRequired == accessCodeRequired &&
        other.unreadMentionCount == unreadMentionCount &&
        other.unreadMessageCount == unreadMessageCount &&
        eq(other.members, members) &&
        other.memberCount == memberCount &&
        other.joinedMemberCount == joinedMemberCount &&
        other.myPushTriggerOption == myPushTriggerOption &&
        other.myMemberState == myMemberState &&
        other.myRole == myRole &&
        other.myMutedState == myMutedState &&
        other.myCountPreference == myCountPreference &&
        other.inviter == inviter &&
        other.hiddenState == hiddenState &&
        other.isHidden == isHidden &&
        other.myLastRead == myLastRead &&
        other.messageOffsetTimestamp == messageOffsetTimestamp &&
        other.messageSurvivalSeconds == messageSurvivalSeconds;
  }

  @override
  int get hashCode => hashValues(
        super.hashCode,
        lastMessage,
        myMutedState,
        myLastRead,
        messageSurvivalSeconds,
        isHidden,
        invitedAt,
        inviter,
        members,
        memberCount,
        unreadMessageCount,
        unreadMentionCount,
        myRole,
      );

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
}
