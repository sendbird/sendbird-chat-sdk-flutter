// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';

part 'thread_info.g.dart';

/// Represents a thread info of a message.
@JsonSerializable()
class ThreadInfo {
  /// The total number of replies in a specific thread.
  /// A value of 0 indicates there is no reply in the thread.
  int replyCount;

  /// Users who left a reply in the thread, based on the time the reply was added.
  @JsonKey(name: 'most_replies')
  List<User> mostRepliesUsers;

  /// The time that the last reply was created, in Unix milliseconds format.
  /// A value of 0 indicates there is no reply in the thread.
  int lastRepliedAt;

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
  int get hashCode => Object.hash(
        replyCount,
        mostRepliesUsers,
        lastRepliedAt,
        updatedAt,
      );
}
