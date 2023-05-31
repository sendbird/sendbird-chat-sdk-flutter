// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'package:sendbird_chat/src/public/core/message/base_message.dart';

extension BaseMessageExtensions on BaseMessage {
  bool hasUpdatedLaterThan(int timestamp) {
    return createdAt > timestamp && updatedAt > timestamp;
  }

  bool mentioned({User? user, User? byOtherUser}) {
    if (user == null || byOtherUser == null) {
      return false;
    }

    if (mentionType == MentionType.users) {
      return _containsMentionedUser(user) && byOtherUser.userId != user.userId;
    } else if (mentionType == MentionType.channel) {
      return byOtherUser.userId != user.userId;
    }
    return false;
  }

  bool _containsMentionedUser(User? user) {
    if (user == null || mentionedUsers.isEmpty) {
      return false;
    }

    return mentionedUsers
        .where((element) => element.userId == user.userId)
        .toList()
        .isNotEmpty;
  }
}
