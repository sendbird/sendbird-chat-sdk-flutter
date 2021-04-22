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

  final Map<String, dynamic> data;

  final int ts;

  @JsonKey(name: 'ts_message_offset')
  final int messageOffset;

  GroupChannelHiddenState get hiddenState {
    if (allowAutoUnhide != null) {
      return allowAutoUnhide
          ? GroupChannelHiddenState.allowAutoUnhide
          : GroupChannelHiddenState.preventAutoUnhide;
    } else {
      return GroupChannelHiddenState.unhidden;
    }
  }

  ChannelEvent({
    this.channelType,
    this.channelUrl,
    this.category,
    this.data,
    this.ts,
    this.messageOffset,
  });

  int get memberCount => data != null ? data['member_count'] : null;
  int get joinedMemberCount =>
      data != null ? data['joined_member_count'] : null;
  int get participantCount => data != null ? data['participant_count'] : null;
  bool get allowAutoUnhide => data != null ? data['allow_auto_unhide'] : null;
  bool get hidePreviousMessage => data['hide_previous_messages'];
  Member get inviter => data != null && data['inviter'] != null
      ? Member.fromJson(data['inviter'])
      : null;
  Member get invitee => data != null && data['invitee'] != null
      ? Member.fromJson(data['invitee'])
      : null;
  List<Member> get invitees {
    if (data != null && data['invitees'] == null) {
      return [];
    }

    final dics = data['invitees'] as List;
    final members = dics.map((e) => Member.fromJson(e)).toList();
    // members.forEach((e) => e.state = MemberState.invited);
    return members;
  }

  User get user => data != null ? User.fromJson(data) : null;

  List<Member> get users {
    if (data['users'] != null) {
      final dics = data['users'] as List<Map>;
      final users = dics.map((e) => Member.fromJson(e)).toList();
      // users.forEach((e) => e.state = MemberState.invited);
      return users;
    } else {
      return [Member.fromJson(data)];
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
      category == ChannelEventCategory.invite ? data['invited_at'] : 0;

  factory ChannelEvent.fromJson(Map<String, dynamic> json) =>
      _$ChannelEventFromJson(json);
}
