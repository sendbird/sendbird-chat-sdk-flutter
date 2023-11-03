// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';

extension GroupChannelExtensions on GroupChannel {
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

  bool updateUnreadCount(RootMessage message) {
    final currentUser = chat.chatContext.currentUser;

    if (message is BaseMessage) {
      if (!message.isSilent) {
        if (message is AdminMessage) {
          _increaseUnreadMessageCount();
          return true;
        }

        if (message.sender?.isCurrentUser == false) {
          _increaseUnreadMessageCount();
          return true;
        }

        if (message.mentioned(user: currentUser, byOtherUser: message.sender)) {
          increaseUnreadMentionCount();
          return true;
        }
      }
    } else if (message is NotificationMessage) {
      _increaseUnreadMessageCount();
      return true;
    }
    return false;
  }

  void setBlockedByMe({required String targetId, required bool blocked}) {
    for (final member in members) {
      if (member.userId == targetId) {
        member.isBlockedByMe = blocked;
        break;
      }
    }
  }

  int myReadReceipt() {
    final status = chat.channelCache.find<ReadStatus>(
      channelKey: channelUrl,
      key: chat.chatContext.currentUserId,
    );
    return status?.timestamp ?? 0;
  }

  bool get canChangeUnreadMessageCount =>
      myCountPreference == CountPreference.all ||
      myCountPreference == CountPreference.unreadMessageCountOnly;

  bool get canChangeUnreadMentionCount =>
      myCountPreference == CountPreference.all ||
      myCountPreference == CountPreference.unrealMentionCountOnly;

  void increaseUnreadMentionCount() {
    if (canChangeUnreadMentionCount) {
      unreadMentionCount++;
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
      updatedDeliveryStatus: {newMember.userId: ts},
    );
    final read = ReadStatus(
      channelType: channelType,
      channelUrl: channelUrl,
      timestamp: ts,
      userId: newMember.userId,
    );

    delivery.saveToCache(chat);
    read.saveToCache(chat);

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

  void updateTypingStatus(Member? member, {bool typing = false}) {
    if (member == null) return;

    final typingStatus = TypingStatus(
      channelType: channelType,
      channelUrl: channelUrl,
      user: member,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
    if (typing) {
      typingStatus.saveToCache(chat);
    } else {
      typingStatus.removeFromCache(chat);
    }
  }

  void updateMemberCounts(ChannelEvent event) {
    memberCount = event.memberCount;
    joinedMemberCount = event.joinedMemberCount;
  }

  void _increaseUnreadMessageCount() {
    if (canChangeUnreadMessageCount) {
      unreadMessageCount++;
    }
  }

  void _refreshMemberCounts() {
    memberCount = members.length;
    joinedMemberCount = members
        .where((element) => element.memberState == MemberState.joined)
        .toList()
        .length;
  }
}
