import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/message/admin_message.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/models/member.dart';
import 'package:sendbird_sdk/core/models/sender.dart';
import 'package:sendbird_sdk/core/message/base_message_internal.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/events/channel_event.dart';
import 'package:sendbird_sdk/features/delivery/delivery_status.dart';
import 'package:sendbird_sdk/features/delivery/read_status.dart';
import 'package:sendbird_sdk/features/typing/typing_status.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:sendbird_sdk/services/db/cache_service.dart';

/// Set of functionality for internal usage to update a channel
extension GroupChannelInternal on GroupChannel {
  bool shouldUpdateLastMessage(BaseMessage message, Sender? sender) {
    final lm = lastMessage;
    if (!message.isSilent ||
        sender?.isCurrentUser == true ||
        message.forceUpdateLastMessage) {
      if (lm == null) {
        return true;
      } else if (lm.createdAt < message.createdAt) {
        return true;
      } else if (lm.createdAt == message.createdAt &&
          lm.messageId == message.messageId &&
          lm.updatedAt < message.updatedAt) {
        return true;
      }
    }
    return false;
  }

  bool updateUnreadCount(BaseMessage message) {
    final currentUser = SendbirdSdk().currentUser;

    if (!message.isSilent) {
      if (message is AdminMessage) {
        increaseUnreadMessageCount();
        return true;
      }

      if (message.sender?.isCurrentUser == false) {
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

  void setBlockedByMe({required String targetId, required bool blocked}) {
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

  void addMember(Member? newMember) {
    if (newMember == null) return;

    removeMember(newMember.userId);
    members.add(newMember);
    members.sort((a, b) => a.nickname.compareTo(b.nickname));

    final ts = DateTime.now().millisecondsSinceEpoch;
    final delivery = DeliveryStatus(
      channelUrl: channelUrl,
      updatedDeliveryReceipt: {newMember.userId: ts},
    );
    final read = ReadStatus(
      channelType: channelType,
      channelUrl: channelUrl,
      timestamp: ts,
      userId: newMember.userId,
    );

    delivery.saveToCache();
    read.saveToCache();

    _refreshMemberCounts();
  }

  Member? removeMember(String? userId) {
    if (userId == null) return null;

    final index = members.indexWhere((element) => element.userId == userId);
    if (index != -1) {
      final member = members.removeAt(index);
      _refreshMemberCounts();
      return member;
    }
    return null;
  }

  void updateMember(User? user) {
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

  void updateTypingStatus(Member? member, {bool typing = false}) {
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

  void updateWithSystemEventData(Map<String, dynamic> data) {
    memberCount = data['member_count'] ?? 0;
    joinedMemberCount = data['joined_member_count'] ?? 0;
  }
}
