// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/read_status.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/sendbird_statistics.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/feed_channel/feed_channel_mark_as_read_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/feed_channel/feed_channel_refresh_request.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/notification_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/member.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/channel/notification_category.dart';

/// Represents a feed channel.
/// @since 4.0.3
class FeedChannel extends BaseChannel {
  static const _markAsClickedMessagesLimit = 30;
  static const _logImpressionMessagesLimit = 30;
  static const _logCustomMessagesLimit = 30;
  static const _logCustomTopicLengthLimit = 15;

  /// The unique channel URL.
  /// @since 4.0.3
  @override
  String get channelUrl => groupChannel.channelUrl;

  @override
  set channelUrl(value) => groupChannel.channelUrl = value;

  /// The topic or name of the channel.
  /// @since 4.0.3
  @override
  String get name => groupChannel.name;

  @override
  set name(value) => groupChannel.name = value;

  /// The creation time of the channel.
  /// @since 4.0.3
  @override
  int? get createdAt => groupChannel.createdAt;

  @override
  set createdAt(value) => groupChannel.createdAt = value;

  /// Member list for this channel.
  /// @since 4.0.3
  List<Member> get members => groupChannel.members;

  /// The total member count for this channel.
  /// @since 4.0.3
  int get memberCount => groupChannel.memberCount;

  /// My member state.
  /// @since 4.0.3
  MemberState get myMemberState => groupChannel.myMemberState;

  /// Current user's last read receipt timestamp in channel.
  /// @since 4.0.3
  int get myLastRead => groupChannel.myLastRead;

  /// The unread message count for this channel for the current [User].
  /// @since 4.0.3
  int get unreadMessageCount => groupChannel.unreadMessageCount;

  /// The last message of the channel.
  /// @since 4.1.0
  NotificationMessage? lastMessage;

  /// isTemplateLabelEnabled
  /// @since 4.0.6
  bool? isTemplateLabelEnabled;

  /// isCategoryFilterEnabled
  /// @since 4.0.6
  bool? isCategoryFilterEnabled;

  /// notificationCategories
  /// @since 4.0.6
  @JsonKey(name: 'categories')
  List<NotificationCategory> notificationCategories;

  GroupChannel groupChannel;

  FeedChannel({
    required this.groupChannel,
    this.lastMessage,
    this.isTemplateLabelEnabled,
    this.isCategoryFilterEnabled,
    List<NotificationCategory>? notificationCategories,
  })  : notificationCategories = notificationCategories ?? [],
        super(
          channelUrl: groupChannel.channelUrl,
          name: groupChannel.name,
          coverUrl: groupChannel.coverUrl,
          createdAt: groupChannel.createdAt,
          data: groupChannel.data,
          customType: groupChannel.customType,
          isFrozen: groupChannel.isFrozen,
          isEphemeral: groupChannel.isEphemeral,
          fromCache: false,
          dirty: false,
        );

  factory FeedChannel.fromJsonWithChat(Chat chat, Map<String, dynamic> json) {
    return _fromJson(chat, json)..set(chat);
  }

  factory FeedChannel.fromJson(Map<String, dynamic> json) {
    return _fromJson(SendbirdChat().chat, json)
      ..set(SendbirdChat().chat); // Set the singleton chat
  }

  @override
  Map<String, dynamic> toJson() {
    final json = groupChannel.toJson();
    json['channel_type'] = ChannelType.feed.name; // Check
    return json;
  }

  static FeedChannel _fromJson(Chat chat, Map<String, dynamic> json) {
    List<NotificationCategory>? notificationCategories;
    List<dynamic>? categories = json['categories'] as List<dynamic>?;

    if (categories != null) {
      notificationCategories = [];

      for (final category in categories) {
        final id = category['id'] as int?;
        final name = category['name'] as String?;
        final isDefault = category['is_default'] as bool?;

        if (id != null && name != null && isDefault != null) {
          final customType = isDefault ? '*' : id.toString();
          final notificationCategory = NotificationCategory(
            id: id,
            customType: customType,
            name: name,
            isDefault: isDefault,
          );
          notificationCategories.add(notificationCategory);
        }
      }
    }

    return FeedChannel(
      groupChannel: GroupChannel.fromJsonWithChat(chat, json),
      lastMessage: json['last_message'] != null
          ? NotificationMessage.fromJsonWithChat(chat, json['last_message'])
          : null,
      isTemplateLabelEnabled: json['is_template_label_enabled'] as bool?,
      isCategoryFilterEnabled: json['is_category_filter_enabled'] as bool?,
      notificationCategories: notificationCategories,
    );
  }

  static Future<FeedChannel> getChannel(
    String channelUrl, {
    Chat? chat,
  }) async {
    sbLog.i(StackTrace.current, 'channelUrl: $channelUrl');
    chat ??= SendbirdChat().chat;

    final channel = chat.channelCache.find<FeedChannel>(channelKey: channelUrl);
    if (channel != null && !channel.dirty) {
      channel.fromCache = true;
      channel.groupChannel.fromCache = true;
      return channel;
    }
    return await FeedChannel.refresh(channelUrl, chat: chat);
  }

  /// Refreshes all the data of this channel.
  /// @since 4.0.3
  static Future<FeedChannel> refresh(
    String channelUrl, {
    Chat? chat,
  }) async {
    sbLog.i(StackTrace.current, 'channelUrl: $channelUrl');
    chat ??= SendbirdChat().chat;

    return await chat.apiClient.send<FeedChannel>(
      FeedChannelRefreshRequest(
        chat,
        channelUrl,
        options: [
          ChannelListQueryIncludeOption.includeMember,
          ChannelListQueryIncludeOption.includeMetadata,
          ChannelListQueryIncludeOption.includeReadReceipt,
          ChannelListQueryIncludeOption.includeDeliveryReceipt,
        ],
        passive: false,
      ),
    );
  }

  /// Sends mark as read all to this channel.
  /// If [messages] is not null, the [messages] will be marked as read to this channel.
  /// @since 4.1.0
  Future<void> markAsRead({List<NotificationMessage>? messages}) async {
    sbLog.i(StackTrace.current);

    List<String>? messageIds;
    if (messages != null) {
      messageIds = [];
      for (final message in messages) {
        if (message.messageStatus == NotificationMessageStatus.sent) {
          messageIds.add(message.notificationId);
        }
      }
      if (messageIds.isEmpty) return;
    }

    final res = await chat.apiClient
        .send<Map<String, dynamic>>(FeedChannelMarkAsReadRequest(
      chat,
      channelUrl: channelUrl,
      messageIds: messageIds,
    ));

    chat.collectionManager.markAsReadForFeedChannel(channelUrl, messageIds);

    if (messageIds == null) {
      final ts = res['ts'] ?? 0;

      if (chat.currentUser != null) {
        final status = ReadStatus(
          userId: chat.currentUser!.userId,
          timestamp: ts,
          channelUrl: channelUrl,
          channelType: channelType,
        );
        status.saveToCache(chat);
      }
      groupChannel.myLastRead = ts;

      if (groupChannel.unreadMessageCount > 0 ||
          groupChannel.unreadMentionCount > 0) {
        groupChannel.clearUnreadCount();
        // chat.eventManager.notifyChannelChanged(this); // Refer to [_processChannelPropChanged]
      }
    } else {
      final unreadMessageCount = res['unread_message_count'] ?? 0;

      if (unreadMessageCount != null &&
          unreadMessageCount != groupChannel.unreadMessageCount) {
        groupChannel.unreadMessageCount = unreadMessageCount;
        // chat.eventManager.notifyChannelChanged(this); // Refer to [_processChannelPropChanged]
      }
    }
  }

  /// markAsClicked
  /// @since 4.1.2
  Future<bool> markAsClicked(List<NotificationMessage> messages) async {
    if (messages.isNotEmpty && messages.length <= _markAsClickedMessagesLimit) {
      bool result = true;
      for (final message in messages) {
        final Map<String, dynamic> data = {
          'action': 'clicked',
          'template_key': message.notificationData?.templateKey ?? '',
          'channel_url': message.channelUrl,
          'tags': message.notificationData?.tags ?? [],
          'message_id': message.notificationId,
          'source': 'notification',
          'message_ts': message.createdAt,
        };

        if (!await SendbirdStatistics.appendStat(
          type: 'noti:stats',
          data: data,
        )) {
          result = false;
        }
      }
      return result;
    }
    return false;
  }

  /// logImpression
  /// @since 4.1.0
  Future<bool> logImpression(List<NotificationMessage> messages) async {
    if (messages.isNotEmpty && messages.length <= _logImpressionMessagesLimit) {
      bool result = true;
      for (final message in messages) {
        final Map<String, dynamic> data = {
          'action': 'impression',
          'template_key': message.notificationData?.templateKey ?? '',
          'channel_url': message.channelUrl,
          'tags': message.notificationData?.tags ?? [],
          'message_id': message.notificationId,
          'source': 'notification',
          'message_ts': message.createdAt,
        };

        if (!await SendbirdStatistics.appendStat(
          type: 'noti:stats',
          data: data,
        )) {
          result = false;
        }
      }
      return result;
    }
    return false;
  }

  /// logCustom
  /// @since 4.1.0
  Future<bool> logCustom(
    List<NotificationMessage> messages,
    String topic,
  ) async {
    if (messages.isNotEmpty &&
        messages.length <= _logCustomMessagesLimit &&
        topic.isNotEmpty &&
        topic.length <= _logCustomTopicLengthLimit) {
      bool result = true;
      for (final message in messages) {
        final Map<String, dynamic> data = {
          'action': 'custom',
          'topic': topic,
          'template_key': message.notificationData?.templateKey ?? '',
          'channel_url': message.channelUrl,
          'tags': message.notificationData?.tags ?? [],
          'message_id': message.notificationId,
          'source': 'notification',
          'message_ts': message.createdAt,
        };

        if (!await SendbirdStatistics.appendStat(
          type: 'noti:stats',
          data: data,
        )) {
          result = false;
        }
      }
      return result;
    }
    return false;
  }

  bool shouldUpdateLastMessage(NotificationMessage message) {
    final lm = lastMessage;
    if (lm == null) {
      return true;
    } else if (lm.createdAt < message.createdAt) {
      return true;
    } else if (lm.createdAt == message.createdAt &&
        lm.notificationId == message.notificationId &&
        lm.updatedAt < message.updatedAt) {
      return true;
    }
    return false;
  }

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;
    if (!(super == (other))) return false;

    final eq = const ListEquality().equals;
    return other is FeedChannel &&
        other.groupChannel == groupChannel &&
        other.lastMessage == lastMessage &&
        other.isTemplateLabelEnabled == isTemplateLabelEnabled &&
        other.isCategoryFilterEnabled == isCategoryFilterEnabled &&
        eq(other.notificationCategories, notificationCategories);
  }

  @override
  int get hashCode => Object.hash(
        super.hashCode,
        groupChannel.hashCode,
        lastMessage,
        isTemplateLabelEnabled,
        isCategoryFilterEnabled,
        notificationCategories,
      );

  @override
  void copyWith(dynamic other) {
    super.copyWith(other);
    if (other is FeedChannel) {
      groupChannel.copyWith(other.groupChannel);
      lastMessage = other.lastMessage;
      isTemplateLabelEnabled = other.isTemplateLabelEnabled;
      isCategoryFilterEnabled = other.isCategoryFilterEnabled;
      notificationCategories =
          List<NotificationCategory>.from(other.notificationCategories);
    }
  }
}
