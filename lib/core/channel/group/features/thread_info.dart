import 'package:json_annotation/json_annotation.dart';

import '../../../models/user.dart';

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
  final List<User> mostRepliesUsers;

  /// Time that the last reply was created, in Unix milliseconds
  /// format. A value of 0 indicates there is no reply in the thread.
  final int lastRepliedAt;

  /// Time that this information was updated at
  int updatedAt;

  ThreadInfo({
    this.replyCount,
    this.mostRepliesUsers,
    this.lastRepliedAt,
    this.updatedAt,
  });

  factory ThreadInfo.fromJson(Map<String, dynamic> json) =>
      _$ThreadInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ThreadInfoToJson(this);
}
