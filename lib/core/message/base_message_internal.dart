import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/user.dart';

import 'base_message.dart';

extension BaseMessageInternal on BaseMessage {
  bool containsMentionedUser(User? user) {
    if (user == null || mentionedUsers.isEmpty) {
      return false;
    }

    return mentionedUsers
        .where((element) => element.userId == user.userId)
        .toList()
        .isNotEmpty;
  }

  bool mentioned({User? user, User? byOtherUser}) {
    if (user == null || byOtherUser == null) {
      return false;
    }

    if (mentionType == MentionType.users) {
      return containsMentionedUser(user) && byOtherUser.userId != user.userId;
    } else if (mentionType == MentionType.channel) {
      return byOtherUser.userId != user.userId;
    }

    return false;
  }

  bool hasCreatedLaterThan(int time) {
    return createdAt > time;
  }

  bool hasUpdatedLaterThan(int time) {
    return hasCreatedLaterThan(time) && updatedAt > time;
  }
}
