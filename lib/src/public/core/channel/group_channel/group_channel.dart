// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/delivery_status.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/read_status.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/typing_status.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/json_converter.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/group_channel_create_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/group_channel_delete_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/group_channel_refresh_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/group_channel_update_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/operation/group_channel_accept_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/operation/group_channel_decline_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/operation/group_channel_invite_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/operation/group_channel_join_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/operation/group_channel_leave_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/operation/group_channel_reset_history_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/pinned_message/group_channel_pin_create_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/pinned_message/group_channel_pin_delete_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/preference/group_channel_count_preference_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/preference/group_channel_freeze_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/preference/group_channel_hide_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/preference/group_channel_push_trigger_option_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/preference/group_channel_screen_shot_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/scheduled_message/group_channel_scheduled_file_message_send_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/scheduled_message/group_channel_scheduled_file_message_update_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/scheduled_message/group_channel_scheduled_file_upload_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/scheduled_message/group_channel_scheduled_message_cancel_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/scheduled_message/group_channel_scheduled_message_send_now_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/scheduled_message/group_channel_scheduled_user_message_send_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/scheduled_message/group_channel_scheduled_user_message_update_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/poll/poll_changelogs_get_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/poll/poll_close_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/poll/poll_delete_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/poll/poll_option_add_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/poll/poll_option_delete_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/poll/poll_option_update_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/poll/poll_update_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/command/command.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/event/channel_event.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/admin_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/file_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/notification_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/user_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/member.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/sender.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/sendbird_error.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/poll/poll.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/poll/poll_change_logs.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/poll/poll_vote_event.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/channel/group_channel_create_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/channel/group_channel_update_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/scheduled_file_message_create_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/scheduled_file_message_update_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/scheduled_user_message_create_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/scheduled_user_message_update_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/poll/poll_update_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/query/channel/public_group_channel_list_query.dart';

part 'group_channel.g.dart';
part 'group_channel_configuration.dart';
part 'group_channel_operation.dart';
part 'group_channel_pinned_message.dart';
part 'group_channel_poll.dart';
part 'group_channel_read.dart';
part 'group_channel_scheduled_message.dart';
part 'group_channel_typing.dart';
part 'package:sendbird_chat_sdk/src/internal/main/extensions/group_channel_extensions.dart';

/// Represents a group channel.
@JsonSerializable()
class GroupChannel extends BaseChannel {
  /// The last message of the channel.
  @JsonKey(fromJson: toNullableBaseMessage)
  BaseMessage? lastMessage;

  /// Checks whether this channel is a super [GroupChannel].
  bool isSuper;

  /// Checks whether this channel is a broadcast [GroupChannel].
  bool isBroadcast;

  /// Checks whether this channel is a public [GroupChannel].
  bool isPublic;

  /// Checks whether this channel is a distinct [GroupChannel].
  /// For a distinct [GroupChannel], later when you create [GroupChannel] with same [User] and [isDistinct] flag being `true`
  /// (refer to [createChannel]),
  /// the channel URL does not change, which means the messages between [User]s remain at the channel.
  /// If the channel is not distinct one, a new [GroupChannel] is created even though [User]s are same.
  /// As a result, you get a totally new channel URL (the old channel still remains), which means the [User]s start new conversation.
  bool isDistinct;

  /// Checks whether this channel is discoverable in the result of [PublicGroupChannelListQuery].
  /// If it is false, it will not appear on the result of [PublicGroupChannelListQuery].
  bool isDiscoverable;

  /// Checks whether this channel is an exclusive [GroupChannel].
  bool isExclusive;

  /// Whether this channel requires access code to join.
  /// This value is valid only if this channel is a public [GroupChannel].
  bool isAccessCodeRequired;

  /// The unread message count for this channel for the current [User].
  int unreadMessageCount;

  /// The unread mention count for this channel for the current [User].
  int unreadMentionCount;

  /// Member list for this channel.
  List<Member> members;

  /// The total member count for this channel.
  int memberCount;

  /// The total joined member count for this channel.
  int joinedMemberCount;

  /// My push trigger option.
  /// The push trigger setting can be updated by [GroupChannelConfiguration.setMyPushTriggerOption].
  @JsonKey(name: 'push_trigger_option')
  GroupChannelPushTriggerOption myPushTriggerOption;

  /// Checks whether this channel is a chat notification [GroupChannel].
  /// @since 4.0.3
  bool isChatNotification;

  /// My member state.
  @JsonKey(name: 'member_state')
  MemberState myMemberState;

  /// My [Role] in this channel.
  @JsonKey(unknownEnumValue: Role.none)
  Role myRole;

  /// My muted state in this channel.
  @JsonKey(fromJson: boolToMuteState, toJson: muteStateToBool, name: 'is_muted')
  MuteState myMutedState;

  /// Checks whether unread message count is enabled for this channel.
  /// This count preference can be set by [GroupChannelConfiguration.setMyCountPreference].
  @JsonKey(name: 'count_preference')
  CountPreference myCountPreference;

  /// The creator of this channel.
  @JsonKey(name: 'created_by')
  User? creator;

  /// The inviter of the current [User] to this channel.
  Member? inviter;

  /// My invitation timestamp.
  int invitedAt;

  /// The timestamp when the current user joined.
  @JsonKey(name: 'joined_ts')
  int joinedAt;

  /// Checks whether this channel is hidden.
  bool isHidden;

  /// The [hiddenState] of this channel.
  @JsonKey(unknownEnumValue: GroupChannelHiddenState.unhidden)
  GroupChannelHiddenState hiddenState;

  /// Current user's last read receipt timestamp in channel.
  @JsonKey(name: 'user_last_read')
  int myLastRead;

  /// This property is set when [GroupChannelOperation.resetMyHistory] and [GroupChannelConfiguration.hide] is called.
  @JsonKey(name: 'ts_message_offset')
  int? messageOffsetTimestamp;

  /// The message survival seconds in this channel.
  int messageSurvivalSeconds;

  /// The pinned message ids of the channel.
  List<int> pinnedMessageIds;

  /// The last message among channel's pinned messages.
  @JsonKey(fromJson: toNullableBaseMessage, name: 'latest_pinned_message')
  BaseMessage? lastPinnedMessage;

  @JsonKey(includeFromJson: false, includeToJson: false)
  int pinnedMessageUpdatedAt;

  int _lastStartTypingTimestamp;
  int _lastEndTypingTimestamp;

  GroupChannel({
    required String channelUrl,
    this.lastMessage,
    this.isSuper = false,
    this.isBroadcast = false,
    this.isPublic = false,
    this.isDistinct = false,
    this.isDiscoverable = false,
    this.isExclusive = false,
    this.isAccessCodeRequired = false,
    this.unreadMessageCount = 0,
    this.unreadMentionCount = 0,
    this.members = const [],
    this.memberCount = 0,
    this.joinedMemberCount = 0,
    this.myPushTriggerOption = GroupChannelPushTriggerOption.defaultValue,
    this.isChatNotification = false,
    this.myMemberState = MemberState.none,
    this.myRole = Role.none,
    this.myMutedState = MuteState.unmuted,
    this.myCountPreference = CountPreference.all,
    this.creator,
    this.inviter,
    this.invitedAt = 0,
    this.joinedAt = 0,
    this.isHidden = false,
    this.hiddenState = GroupChannelHiddenState.unhidden,
    this.myLastRead = 0,
    this.messageOffsetTimestamp,
    this.messageSurvivalSeconds = -1,
    this.pinnedMessageIds = const [],
    this.lastPinnedMessage,
    this.pinnedMessageUpdatedAt = 0,
    String name = '',
    String coverUrl = '',
    int? createdAt,
    String data = '',
    String customType = '',
    bool isFrozen = false,
    bool isEphemeral = false,
  })  : _lastStartTypingTimestamp = 0,
        _lastEndTypingTimestamp = 0,
        super(
          channelUrl: channelUrl,
          name: name,
          coverUrl: coverUrl,
          createdAt: createdAt,
          data: data,
          customType: customType,
          isFrozen: isFrozen,
          isEphemeral: isEphemeral,
          fromCache: false,
          dirty: false,
        );

  /// Gets a `GroupChannel` with given channel URL.
  static Future<GroupChannel> getChannel(
    String channelUrl, {
    Chat? chat,
  }) async {
    sbLog.i(StackTrace.current, 'channelUrl: $channelUrl');
    chat ??= SendbirdChat().chat;

    GroupChannel? channel =
        chat.channelCache.find<GroupChannel>(channelKey: channelUrl);
    if (channel != null && !channel.dirty) {
      channel.fromCache = true;
      return channel;
    }

    try {
      final channel = await GroupChannel.refresh(channelUrl, chat: chat);
      return channel;
    } catch (e) {
      //+ [DBManager]
      if (chat.dbManager.isEnabled()) {
        if (chat.currentUser != null) {
          final channel = await chat.dbManager.getGroupChannel(channelUrl);
          if (channel != null) {
            channel.fromCache = true;
            return channel;
          }
        }
      }
      //- [DBManager]
      rethrow;
    }
  }

  /// Refreshes all the data of this channel.
  static Future<GroupChannel> refresh(
    String channelUrl, {
    Chat? chat,
  }) async {
    sbLog.i(StackTrace.current, 'channelUrl: $channelUrl');
    chat ??= SendbirdChat().chat;

    final channel = await chat.apiClient.send<GroupChannel>(
      GroupChannelRefreshRequest(
        chat,
        channelUrl,
        options: [
          ChannelListQueryIncludeOption.includeMember,
          ChannelListQueryIncludeOption.includeMetadata,
          ChannelListQueryIncludeOption.includeReadReceipt,
          ChannelListQueryIncludeOption.includeDeliveryReceipt,
        ],
        passive: false,
      ),
    );

    //+ [DBManager]
    if (chat.dbManager.isEnabled()) {
      await chat.dbManager.upsertGroupChannels([channel]);
    }
    //- [DBManager]

    return channel;
  }

  /// Creates `GroupChannel` with GroupChannelCreateParams.
  ///
  /// #################### SECURITY TIPS ####################
  /// Before launching, you should review "Allow creating group channels from SDK" under ⚙️ Sendbird Dashboard -> Settings -> Security.
  /// It's turned on at first to simplify running samples and implementing your first code.
  /// Most apps will want to disable "Allow creating group channels from SDK" as that could cause unwanted operations.
  /// #################### SECURITY TIPS ####################
  static Future<GroupChannel> createChannel(
    GroupChannelCreateParams params, {
    ProgressHandler? progressHandler,
    Chat? chat,
  }) async {
    sbLog.i(StackTrace.current, 'params.userIds: ${params.userIds}');
    chat ??= SendbirdChat().chat;

    final currentUserId = chat.chatContext.currentUserId ?? '';
    if (params.userIds?.isEmpty ?? true) {
      params.userIds = [currentUserId];
    } else if (params.userIds?.contains(currentUserId) == false) {
      params.userIds?.add(currentUserId);
    }

    return await chat.apiClient.send<GroupChannel>(GroupChannelCreateRequest(
      chat,
      params,
      progressHandler: progressHandler,
    ));
  }

  /// Update this channel with GroupChannelUpdateParams.
  Future<GroupChannel> updateChannel(
    GroupChannelUpdateParams params, {
    ProgressHandler? progressHandler,
  }) async {
    sbLog.i(StackTrace.current, 'params.name: ${params.name}');

    return await chat.apiClient.send<GroupChannel>(GroupChannelUpdateRequest(
      chat,
      channelUrl,
      params,
      progressHandler: progressHandler,
    ));
  }

  /// Deletes this `GroupChannel`.
  /// Note that only operators of a channel are able to delete it or else,
  /// an error will be returned to the handler.
  Future<void> deleteChannel() async {
    sbLog.i(StackTrace.current);

    await chat.apiClient.send(GroupChannelDeleteRequest(chat, channelUrl));
    if (!isPublic) removeFromCache(chat);
  }

  static GroupChannel? getChannelFromCache(
    String channelUrl, {
    Chat? chat,
  }) {
    chat ??= SendbirdChat().chat;

    final channel =
        chat.channelCache.find<GroupChannel>(channelKey: channelUrl);
    if (channel != null) {
      channel.fromCache = true;
      return channel;
    }
    return null;
  }

  Member? getMember(String userId) {
    return members.firstWhereOrNull((element) => element.userId == userId);
  }

  factory GroupChannel.fromJson(Map<String, dynamic> json) {
    return _$GroupChannelFromJson(json)
      ..set(SendbirdChat().chat); // Set the singleton chat
  }

  factory GroupChannel.fromJsonWithChat(Chat chat, Map<String, dynamic> json) {
    return GroupChannel.fromJson(json)..set(chat);
  }

  @override
  Map<String, dynamic> toJson() {
    final json = _$GroupChannelToJson(this);
    json['channel_type'] = ChannelType.group.name; // Check
    return json;
  }

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;
    if (!(super == (other))) return false;

    final eq = const ListEquality().equals;
    return other is GroupChannel &&
        other.lastMessage == lastMessage &&
        other.isSuper == isSuper &&
        other.isBroadcast == isBroadcast &&
        other.isPublic == isPublic &&
        other.isDistinct == isDistinct &&
        other.isDiscoverable == isDiscoverable &&
        other.isExclusive == isExclusive &&
        other.isAccessCodeRequired == isAccessCodeRequired &&
        other.unreadMessageCount == unreadMessageCount &&
        other.unreadMentionCount == unreadMentionCount &&
        eq(other.members, members) &&
        other.memberCount == memberCount &&
        other.joinedMemberCount == joinedMemberCount &&
        other.myPushTriggerOption == myPushTriggerOption &&
        other.isChatNotification == isChatNotification &&
        other.myMemberState == myMemberState &&
        other.myRole == myRole &&
        other.myMutedState == myMutedState &&
        other.myCountPreference == myCountPreference &&
        other.creator == creator &&
        other.inviter == inviter &&
        other.invitedAt == invitedAt &&
        other.joinedAt == joinedAt &&
        other.isHidden == isHidden &&
        other.hiddenState == hiddenState &&
        other.myLastRead == myLastRead &&
        other.messageOffsetTimestamp == messageOffsetTimestamp &&
        other.messageSurvivalSeconds == messageSurvivalSeconds;
  }

  @override
  int get hashCode => Object.hash(
        super.hashCode,
        lastMessage,
        unreadMessageCount,
        unreadMentionCount,
        members,
        memberCount,
        myMutedState,
        messageSurvivalSeconds,
        myRole,
        inviter,
        invitedAt,
        joinedAt,
        isHidden,
        myLastRead,
      );

  @override
  void copyWith(dynamic other) {
    super.copyWith(other);
    if (other is GroupChannel) {
      lastMessage = other.lastMessage;
      isSuper = other.isSuper;
      isBroadcast = other.isBroadcast;
      isPublic = other.isPublic;
      isDistinct = other.isDistinct;
      isDiscoverable = other.isDiscoverable;
      isExclusive = other.isExclusive;
      isAccessCodeRequired = other.isAccessCodeRequired;
      unreadMessageCount = other.unreadMessageCount;
      unreadMentionCount = other.unreadMentionCount;
      members = List<Member>.from(other.members);
      memberCount = other.memberCount;
      joinedMemberCount = other.joinedMemberCount;
      myPushTriggerOption = other.myPushTriggerOption;
      isChatNotification = other.isChatNotification;
      myMemberState = other.myMemberState;
      myRole = other.myRole;
      myMutedState = other.myMutedState;
      myCountPreference = other.myCountPreference;
      creator = other.creator;
      inviter = other.inviter;
      invitedAt = other.invitedAt;
      joinedAt = other.joinedAt;
      isHidden = other.isHidden;
      hiddenState = other.hiddenState;
      myLastRead = other.myLastRead;
      messageOffsetTimestamp = other.messageOffsetTimestamp;
      messageSurvivalSeconds = other.messageSurvivalSeconds;
    }
  }
}
