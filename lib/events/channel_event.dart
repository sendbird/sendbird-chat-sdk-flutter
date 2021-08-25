import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/member.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/events/base_event.dart';

part 'channel_event.g.dart';

/// Represents channel related event
@JsonSerializable(createToJson: false)
class ChannelEvent implements BaseEvent {
  final String channelUrl;

  final ChannelType channelType;

  @JsonKey(fromJson: channelEventValueOf, name: 'cat')
  //NOTE: https://github.com/dart-lang/sdk/issues/33698
  final ChannelEventCategory category;

  @JsonKey(defaultValue: {})
  final Map<String, dynamic> data;

  final int? ts;

  @JsonKey(name: 'ts_message_offset')
  final int? messageOffset;

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
  });

  int get joinedAt => data['joined_ts'] ?? 0;
  int get memberCount => data['member_count'] ?? 0;
  int get joinedMemberCount => data['joined_member_count'] ?? 0;
  int get participantCount => data['participant_count'] ?? 0;
  bool? get allowAutoUnhide => data['allow_auto_unhide'];
  bool get hidePreviousMessage => data['hide_previous_messages'];
  Member? get inviter {
    if (data['inviter'] != null) {
      final user = Member.fromJson(data['inviter']);
      user.state = MemberState.joined;
      return user;
    }
    return null;
  }

  Member? get invitee =>
      data['invitee'] != null ? Member.fromJson(data['invitee']) : null;
  List<Member> get invitees {
    if (data['invitees'] == null) return [];
    final dics = data['invitees'] as List;
    final members = dics.map((e) => Member.fromJson(e)).toList();
    members.forEach((e) => e.state = MemberState.invited);
    return members;
  }

  User? get user => data.isEmpty ? null : User.fromJson(data);

  List<Member> get joinedMembers {
    if (data['users'] != null) {
      final dics = data['users'] as List<Map<String, dynamic>>;
      final users = dics.map((e) => Member.fromJson(e)).toList();
      users.forEach((e) => e.state = MemberState.joined);
      return users;
    } else {
      final user = Member.fromJson(data);
      user.state = MemberState.joined;
      return [user];
    }
  }

  List<Member> get operators {
    if (data['operators'] == null) {
      return [];
    }

    final dics = data['operators'] as List;
    final members = dics.map((e) => Member.fromJson(e)).toList();
    // members.forEach((e) => e.state = MemberState.invited);
    return members;
  }

  int get invitedAt =>
      category == ChannelEventCategory.invite ? (data['invited_at'] ?? 0) : 0;

  factory ChannelEvent.fromJson(Map<String, dynamic> json) =>
      _$ChannelEventFromJson(json);
}
