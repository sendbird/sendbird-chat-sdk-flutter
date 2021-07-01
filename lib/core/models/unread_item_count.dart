import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';

part 'unread_item_count.g.dart';

@JsonSerializable(createToJson: false)
class UnreadItemCount {
  /// Count of invitation of all group channels
  final int? groupChannelInvitationCount;

  /// Count of unread mention in all of group channels
  final int? groupChannelUnreadMentionCount;

  /// Count of unread message in all of group channels
  final int? groupChannelUnreadMessageCount;

  /// Count of invitation of all non super group channels
  final int? nonSuperGroupChannelInvitationCount;

  /// Count of unread mention in all of non super group channels
  final int? nonSuperGroupChannelUnreadMentionCount;

  /// Count of unread message in all of non super group channels
  final int? nonSuperGroupChannelUnreadMessageCount;

  /// Count of invitation of all super group channels
  final int? superGroupChannelInvitationCount;

  /// count of unread mention in all of super group channels
  final int? superGroupChannelUnreadMentionCount;

  /// Count of unread message in all of non super group channels
  final int? superGroupChannelUnreadMessageCount;

  UnreadItemCount({
    this.groupChannelInvitationCount,
    this.groupChannelUnreadMentionCount,
    this.groupChannelUnreadMessageCount,
    this.superGroupChannelInvitationCount,
    this.superGroupChannelUnreadMentionCount,
    this.superGroupChannelUnreadMessageCount,
    this.nonSuperGroupChannelInvitationCount,
    this.nonSuperGroupChannelUnreadMentionCount,
    this.nonSuperGroupChannelUnreadMessageCount,
  });

  bool has(List<UnreadItemKey> keys) {
    return false;
  }

  static UnreadItemCount fromJson(Map<String, dynamic> json) =>
      _$UnreadItemCountFromJson(json);
}
