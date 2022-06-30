import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/constant/types.dart';
import 'package:sendbird_sdk/core/channel/base/base_channel.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel_internal.dart';
import 'package:sendbird_sdk/core/message/admin_message.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/models/command.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/member.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/features/delivery/delivery_status.dart';
import 'package:sendbird_sdk/features/delivery/read_status.dart';
import 'package:sendbird_sdk/features/typing/typing_status.dart';
import 'package:sendbird_sdk/params/group_channel_params.dart';
import 'package:sendbird_sdk/request/channel/group_channel_create_request.dart';
import 'package:sendbird_sdk/request/channel/group_channel_delete_request.dart';
import 'package:sendbird_sdk/request/channel/group_channel_refresh_request.dart';
import 'package:sendbird_sdk/request/channel/group_channel_update_request.dart';
import 'package:sendbird_sdk/request/channel_operation/group_channel_accept_request.dart';
import 'package:sendbird_sdk/request/channel_operation/group_channel_decline_request.dart';
import 'package:sendbird_sdk/request/channel_operation/group_channel_invite_request.dart';
import 'package:sendbird_sdk/request/channel_operation/group_channel_join_request.dart';
import 'package:sendbird_sdk/request/channel_operation/group_channel_leave_request.dart';
import 'package:sendbird_sdk/request/channel_operation/group_channel_reset_history_request.dart';
import 'package:sendbird_sdk/request/channel_preference/group_channel_count_preference_request.dart';
import 'package:sendbird_sdk/request/channel_preference/group_channel_freeze_request.dart';
import 'package:sendbird_sdk/request/channel_preference/group_channel_hide_request.dart';
import 'package:sendbird_sdk/request/channel_preference/group_channel_push_trigger_option_request.dart';
import 'package:sendbird_sdk/request/channel_preference/group_channel_screen_shot_request.dart';
import 'package:sendbird_sdk/sdk/internal/sendbird_sdk_internal.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:sendbird_sdk/services/db/cache_utils.dart';
import 'package:sendbird_sdk/services/db/cache_service.dart';
import 'package:sendbird_sdk/utils/json_from_parser.dart';

part 'group_channel.g.dart';
part 'group_channel_operation.dart';
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
  BaseMessage? lastMessage;

  /// True if this channel is super channel
  @JsonKey(defaultValue: false)
  bool isSuper;

  /// True if this channel is strict
  @JsonKey(defaultValue: false)
  final bool isStrict;

  /// True if this channel is broadcast
  @JsonKey(defaultValue: false)
  bool isBroadcast;

  /// True if this channel is public
  @JsonKey(defaultValue: false)
  bool isPublic;

  /// True if this channel is distinct
  @JsonKey(defaultValue: false)
  bool isDistinct;

  /// True if this channel is discoverable
  /// It is only for a public group channel.
  @JsonKey(defaultValue: false)
  bool isDiscoverable;

  /// True if this channel is exclusive
  @JsonKey(defaultValue: false)
  bool isExclusive;

  /// True if this channel is required access code
  @JsonKey(defaultValue: false)
  bool accessCodeRequired;

  /// Unread message count of the channel
  @JsonKey(defaultValue: 0)
  int unreadMessageCount;

  /// The number of mentions that user does not read yet in the channel
  @JsonKey(defaultValue: 0)
  int unreadMentionCount;

  /// Channel members
  /// Note: Number of member for SuperGroupChannel is limited to 10
  @JsonKey(defaultValue: [])
  List<Member> members;

  /// Number of members
  @JsonKey(defaultValue: 0)
  int memberCount;

  /// Number of joined member
  @JsonKey(defaultValue: 0)
  int joinedMemberCount;

  /// Push notification option for the current user to receive in the group channel
  @JsonKey(
    defaultValue: GroupChannelPushTriggerOption.global,
    name: 'push_trigger_option',
  )
  GroupChannelPushTriggerOption myPushTriggerOption;

  /// Member state of current user in this channel
  @JsonKey(defaultValue: MemberState.none, name: 'member_state')
  MemberState myMemberState;

  /// Role of current user in this channel
  @JsonKey(defaultValue: Role.none, unknownEnumValue: Role.none)
  Role myRole;

  /// Muted state of current user in this channel
  @JsonKey(
    fromJson: booltoMuteState,
    name: 'is_muted',
  )
  MuteState myMutedState;

  /// Message count preference of current user in this channel
  /// The default value is all
  @JsonKey(defaultValue: CountPreference.all, name: 'count_preference')
  CountPreference myCountPreference;

  /// User who invited
  Member? inviter;

  /// Timestamp when current user got a invitation
  /// from other user in the channel
  @JsonKey(defaultValue: 0)
  int invitedAt;

  /// Timestamp when current user joined on this channel
  @JsonKey(name: 'joined_ts', defaultValue: 0)
  int joinedAt;

  /// True if this channel is hidden
  @JsonKey(defaultValue: false)
  bool isHidden;

  /// Hidden state of this channel
  @JsonKey(
    defaultValue: GroupChannelHiddenState.unhidden,
    unknownEnumValue: GroupChannelHiddenState.unhidden,
  )
  GroupChannelHiddenState hiddenState;

  /// A last read information for the current user
  @JsonKey(defaultValue: 0, name: 'user_last_read')
  int myLastRead;

  /// Message offset of this channel. User can only see messages after this offset
  @JsonKey(name: 'ts_message_offset')
  int? messageOffsetTimestamp;

  /// A value that sets the message survival time in seconds. In the channel
  /// that is created or updated with this option, the read messages are
  /// automatically deleted after a determined amount of time. The default
  /// value is `-1` that represents the disappearing message is disabled.
  /// Note: This feature is available in a 1-on-1 group channel.
  @JsonKey(defaultValue: -1)
  int messageSurvivalSeconds;

  int _lastStartTypingTimestamp = 0;
  int _lastEndTypingTimestamp = 0;
  int _lastMarkAsReadTimestamp = 0;

  /// **WARNING:** Do not use default constructor to initialize manually
  GroupChannel({
    this.lastMessage,
    this.isSuper = false,
    this.isStrict = false,
    this.isBroadcast = false,
    this.isPublic = false,
    this.isDistinct = false,
    this.isDiscoverable = false,
    this.isExclusive = false,
    this.accessCodeRequired = false,
    this.unreadMessageCount = 0,
    this.unreadMentionCount = 0,
    this.members = const [],
    this.memberCount = 0,
    this.joinedMemberCount = 0,
    this.joinedAt = 0,
    this.myPushTriggerOption = GroupChannelPushTriggerOption.all,
    this.myMemberState = MemberState.none,
    this.myRole = Role.none,
    this.myMutedState = MuteState.unmuted,
    this.myCountPreference = CountPreference.all,
    this.invitedAt = 0,
    this.inviter,
    this.isHidden = false,
    this.hiddenState = GroupChannelHiddenState.unhidden,
    this.myLastRead = 0,
    this.messageOffsetTimestamp,
    this.messageSurvivalSeconds = -1,
    required String channelUrl,
    String? name,
    String? coverUrl,
    User? creator,
    int? createdAt,
    String? data,
    String? customType,
    bool isFrozen = false,
    bool isEphemeral = false,
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
        ) {
    //If exclusive [isSuper] and [isBroadcast] are true
    if (isExclusive == true) {
      isSuper = true;
      isBroadcast = true;
    }
  }

  SendbirdSdkInternal _sdk = SendbirdSdk().getInternal();

  /// Refreshes an [GroupChannel] with given [channelUrl]
  static Future<GroupChannel> refresh(String channelUrl) async {
    final sdk = SendbirdSdk().getInternal();

    return sdk.api.send<GroupChannel>(
      GroupChannelRefreshRequest(
        channelUrl,
        options: [
          ChannelQueryIncludeOption.deliveryReceipt,
          ChannelQueryIncludeOption.readReceipt,
          ChannelQueryIncludeOption.memberList,
          ChannelQueryIncludeOption.metaData,
        ],
        passive: false,
      ),
    );
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
    OnUploadProgressCallback? progress,
  }) async {
    final sdk = SendbirdSdk().getInternal();
    final currentUserId = sdk.state.userId ?? '';
    if (params.userIds?.isEmpty ?? true) {
      params.userIds = [currentUserId];
    } else if (params.userIds?.contains(currentUserId) == false) {
      params.userIds?.add(currentUserId);
    }
    return sdk.api.send<GroupChannel>(
        GroupChannelCreateRequest(params, onProgress: progress));
  }

  /// Updates this channel with given [params] and optional [progress].
  ///
  /// After this method completes successfully, channel event such as
  /// [ChannelEventHandler.onChannelOperatorsUpdated] and
  /// [ChannelEventHandler.onChannelChanged] can be invoked
  /// based on given [params].
  Future<GroupChannel> updateChannel(
    GroupChannelParams params, {
    OnUploadProgressCallback? progress,
  }) async {
    params.channelUrl ??= channelUrl;

    if (params.channelUrl != channelUrl) {
      throw InvalidParameterError();
    }

    return _sdk.api.send<GroupChannel>(
        GroupChannelUpdateRequest(params, onProgress: progress));
  }

  /// Deletes this channel.
  ///
  /// After this method completes successfully, channel event
  /// [ChannelEventHandler.onChannelDeleted] will be invoked
  Future<void> deleteChannel() async {
    _sdk.api.send(GroupChannelDeleteRequest(channelUrl));
    if (!isPublic) removeFromCache();
  }

  /// Returns [Member] with given [userId]. It will return `null` if [userId]
  /// is not exist in members.
  Member? getMember(String userId) {
    return members.firstWhereOrNull((element) => element.userId == userId);
  }

  // json serialization

  factory GroupChannel.fromJson(Map<String, dynamic> json) {
    final channel = _$GroupChannelFromJson(json);
    json.cacheMetaData(channel: channel);
    json.cacheDeliveryReceipt(channel);
    json.cacheReadReceipt(channel);
    return channel;
  }

  factory GroupChannel.fromJsonAndCached(Map<String, dynamic> json, {int? ts}) {
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
      joinedAt = other.joinedAt;
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
