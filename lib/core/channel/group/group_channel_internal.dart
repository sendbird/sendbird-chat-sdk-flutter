import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/channel/group/features/delivery_status.dart';
import 'package:sendbird_sdk/core/channel/group/features/read_status.dart';
import 'package:sendbird_sdk/core/channel/group/features/typing_status.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/models/member.dart';
import 'package:sendbird_sdk/core/models/sender.dart';
import 'package:sendbird_sdk/core/message/base_message_internal.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/events/channel_event.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:sendbird_sdk/services/db/cache_service.dart';

/// Set of functionality for internal usage to update a channel
extension GroupChannelInternal on GroupChannel {
  bool shouldUpdateLastMessage(BaseMessage message, Sender sender) {
    if (sender == null) {
      return false;
    }

    if (!message.isSilent ||
        sender.isCurrentUser ||
        message.forceUpdateLastMessage) {
      if (lastMessage == null) {
        return true;
      } else if (lastMessage.createdAt < message.createdAt) {
        return true;
      } else if (lastMessage.createdAt == message.createdAt &&
          lastMessage.messageId == message.messageId &&
          lastMessage.updatedAt < message.updatedAt) {
        return true;
      }
    }
    return false;
  }

  bool updateUnreadCount(BaseMessage message) {
    if (message == null) return false;

    final currentUser = SendbirdSdk().getCurrentUser();

    if (!message.isSilent) {
      if (!message.sender.isCurrentUser) {
        increaseUnreadMessageCount();
        return true;
      }

      if (message.mentioned(user: currentUser, byOtherUser: message.sender)) {
        increaseUnreadMentionCount();
        return true;
      }
    }

    return false;
  }

  void setBlockedByMe({String targetId, bool blocked}) {
    members.forEach((member) {
      if (member.userId == targetId) {
        member.isBlockedByMe = blocked;
      }
    });
  }

  int myReadReceipt() {
    final sdk = SendbirdSdk().getInternal();
    final status = sdk.cache.find<ReadStatus>(
      channelKey: channelUrl,
      key: sdk.state.userId,
    );
    return status?.timestamp ?? 0;
  }

  bool get canChangeUnreadMessageCount =>
      myCountPreference == CountPreference.all ||
      myCountPreference == CountPreference.messageOnly;

  bool get canChangeUnreadMentionCount =>
      myCountPreference == CountPreference.all ||
      myCountPreference == CountPreference.mentionOnly;

  void increaseUnreadMessageCount() {
    if (canChangeUnreadMessageCount) {
      unreadMessageCount++;
    } else {}
  }

  void increaseUnreadMentionCount() {
    if (canChangeUnreadMentionCount) {
      unreadMentionCount++;
    } else {}
  }

  void decreaseUnreadMentionCount() {
    if (canChangeUnreadMentionCount && unreadMentionCount > 0) {
      unreadMentionCount--;
    } else {}
  }

  void clearUnreadCount() {
    unreadMentionCount = 0;
    unreadMessageCount = 0;
  }

  void addMember(Member newMember) {
    removeMember(newMember.userId);
    newMember.state = MemberState.joined;
    members.add(newMember);
    members.sort((a, b) => a.nickname.compareTo(b.nickname));

    final ts = DateTime.now().millisecondsSinceEpoch;
    DeliveryStatus delivery = DeliveryStatus(
      channelUrl: channelUrl,
      updatedDeliveryReceipt: {newMember.userId: ts},
    );
    ReadStatus read = ReadStatus(
      channelType: channelType,
      channelUrl: channelUrl,
      timestamp: ts,
      userId: newMember.userId,
    );

    delivery.saveToCache();
    read.saveToCache();

    _refreshMemberCounts();
  }

  void removeMember(String userId) {
    members.removeWhere((element) => element.userId == userId);
    _refreshMemberCounts();
  }

  void updateMember(User user) {
    if (user == null) return;

    final index = members.indexWhere((e) => e.userId == user.userId);
    if (index != -1) {
      final member = members[index];
      member.copyWith(user);
    }
  }

  void _refreshMemberCounts() {
    memberCount = members.length;
    joinedMemberCount = members
        .where((element) => element.state == MemberState.joined)
        .toList()
        .length;
  }

  void updateTypingStatus(Member member, {bool typing}) {
    if (member == null) return;

    final typingStatus = TypingStatus(
      channelType: channelType,
      channelUrl: channelUrl,
      user: member,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
    if (typing) {
      typingStatus.saveToCache();
    } else {
      typingStatus.removeFromCache();
    }
  }

  void updateMemberCounts(ChannelEvent event) {
    memberCount = event.memberCount;
    joinedMemberCount = event.joinedMemberCount;
  }
}
