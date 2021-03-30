import 'base_message.dart';

import '../models/user.dart';
import '../../constant/enums.dart';

extension BaseMessageInternal on BaseMessage {
  bool containsMentionedUser(User user) {
    if (user == null || mentionedUsers == null) {
      return false;
    }

    return mentionedUsers
            .where((element) => element.userId == user.userId)
            .toList()
            .length !=
        0;
  }

  bool mentioned({User user, User byOtherUser}) {
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
    return this.hasCreatedLaterThan(time) && updatedAt > time;
  }
}
