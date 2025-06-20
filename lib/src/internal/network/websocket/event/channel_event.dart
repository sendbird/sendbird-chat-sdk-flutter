// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/event/base_event.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/member.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

part 'channel_event.g.dart';

@JsonSerializable(createToJson: false)
class ChannelEvent extends BaseEvent {
  final String channelUrl;

  final ChannelType channelType;

  @JsonKey(fromJson: channelEventValueOf, name: 'cat')
  // NOTE: https://github.com/dart-lang/sdk/issues/33698
  final ChannelEventCategory category;

  @JsonKey(defaultValue: {})
  final Map<String, dynamic> data;

  final int? ts;

  @JsonKey(name: 'ts_message_offset')
  final int? messageOffset;

  final String? uniqueId;

  GroupChannelHiddenState get hiddenState {
    final auto = allowAutoUnhide;
    if (auto != null) {
      return auto
          ? GroupChannelHiddenState.allowAutoUnhide
          : GroupChannelHiddenState.preventAutoUnhide;
    } else {
      return GroupChannelHiddenState.unhidden;
    }
  }

  ChannelEvent({
    required this.channelType,
    required this.channelUrl,
    required this.category,
    required this.data,
    this.ts,
    this.messageOffset,
    this.uniqueId,
  });

  int get joinedAt => data['joined_ts'] ?? 0;
  int get memberCount => data['member_count'] ?? 0;
  int get joinedMemberCount => data['joined_member_count'] ?? 0;
  int get participantCount => data['participant_count'] ?? 0;
  bool? get allowAutoUnhide => data['allow_auto_unhide'];
  bool get hidePreviousMessage => data['hide_previous_messages'];

  Member? get inviter {
    if (data['inviter'] != null) {
      final user = Member.fromJsonWithChat(chat, data['inviter']);
      user.memberState = MemberState.joined;
      return user;
    }
    return null;
  }

  Member? get invitee {
    if (data['invitee'] == null) return null;
    return Member.fromJsonWithChat(chat, data['invitee']);
  }

  List<Member> get invitees {
    if (data['invitees'] == null) return [];
    final dics = data['invitees'] as List;
    final members = dics.map((e) => Member.fromJsonWithChat(chat, e)).toList();
    for (final e in members) {
      e.memberState = MemberState.invited;
    }
    return members;
  }

  User? get user {
    if (data.isEmpty) return null;
    return User.fromJsonWithChat(chat, data);
  }

  List<Member> get joinedMembers {
    if (data['users'] != null) {
      final dics = data['users'] as List<Map<String, dynamic>>;
      final users = dics.map((e) => Member.fromJsonWithChat(chat, e)).toList();
      for (final e in users) {
        e.memberState = MemberState.joined;
      }
      return users;
    } else {
      final user = Member.fromJsonWithChat(chat, data);
      user.memberState = MemberState.joined;
      return [user];
    }
  }

  List<Member> get operators {
    if (data['operators'] == null) {
      return [];
    }

    final dics = data['operators'] as List;
    final members = dics.map((e) => Member.fromJsonWithChat(chat, e)).toList();
    return members;
  }

  int get invitedAt =>
      category == ChannelEventCategory.invite ? (data['invited_at'] ?? 0) : 0;

  factory ChannelEvent.fromJsonWithChat(Chat chat, Map<String, dynamic> json) {
    return _$ChannelEventFromJson(json)..set(chat);
  }
}

ChannelEventCategory channelEventValueOf(int value) {
  switch (value) {
    case 0:
      return ChannelEventCategory.none;
    case 10000:
      return ChannelEventCategory.join;
    case 10001:
      return ChannelEventCategory.leave;
    case 10002:
      return ChannelEventCategory.updateOperators;
    case 10020:
      return ChannelEventCategory.invite;
    case 10022:
      return ChannelEventCategory.declineInvite;
    case 10102:
      return ChannelEventCategory.enter;
    case 10103:
      return ChannelEventCategory.exit;
    case 10201:
      return ChannelEventCategory.mute;
    case 10200:
      return ChannelEventCategory.unmute;
    case 10601:
      return ChannelEventCategory.ban;
    case 10600:
      return ChannelEventCategory.unban;
    case 10701:
      return ChannelEventCategory.frozen;
    case 10700:
      return ChannelEventCategory.unfrozen;
    case 10900:
      return ChannelEventCategory.typingStart;
    case 10901:
      return ChannelEventCategory.typingEnd;
    case 11000:
      return ChannelEventCategory.propChanged;
    case 12000:
      return ChannelEventCategory.deleted;
    case 11100:
      return ChannelEventCategory.metaDataChanged;
    case 11200:
      return ChannelEventCategory.metaCounterChanged;
    case 11300:
      return ChannelEventCategory.pinnedMessage;
    case 13000:
      return ChannelEventCategory.hidden;
    case 13001:
      return ChannelEventCategory.unhidden;
    default:
      return ChannelEventCategory.none;
  }
}

enum ChannelEventCategory {
  none,
  join,
  leave,
  updateOperators,
  invite,
  declineInvite,
  enter,
  exit,
  mute,
  unmute,
  ban,
  unban,
  frozen,
  unfrozen,
  typingStart,
  typingEnd,
  propChanged,
  deleted,
  metaDataChanged,
  metaCounterChanged,
  pinnedMessage,
  hidden,
  unhidden,
}
