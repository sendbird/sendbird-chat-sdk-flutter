import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/core/models/user.dart';

part 'thread_info.g.dart';

/// Represents thread information on [BaseMessage]
///
/// This instance is available on [BaseMessage]'s property when there are any
/// replies on the message.
@JsonSerializable()
class ThreadInfo {
  /// The total number of replies in a specific thread.
  /// A value of 0 indicates there is no reply in the thread.
  final int replyCount;

  /// Users who left most replies in the thread. The order of users
  /// is based on the number of replies they made in the thread and
  /// the maximum size of the array can be adjusted per request.
  @JsonKey(defaultValue: [], name: 'most_replies')
  final List<User> mostRepliesUsers;

  /// Time that the last reply was created, in Unix milliseconds
  /// format. A value of 0 indicates there is no reply in the thread.
  final int lastRepliedAt;

  /// Time that this information was updated at
  int? updatedAt;

  ThreadInfo({
    this.replyCount = 0,
    this.mostRepliesUsers = const [],
    this.lastRepliedAt = 0,
    this.updatedAt,
  });

  factory ThreadInfo.fromJson(Map<String, dynamic> json) =>
      _$ThreadInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ThreadInfoToJson(this);

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;

    return other is ThreadInfo &&
        other.replyCount == replyCount &&
        other.mostRepliesUsers == mostRepliesUsers &&
        other.lastRepliedAt == lastRepliedAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode =>
      Object.hash(replyCount, mostRepliesUsers, lastRepliedAt, updatedAt);
}
