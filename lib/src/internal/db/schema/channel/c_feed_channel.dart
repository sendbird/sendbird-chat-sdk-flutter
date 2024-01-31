// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:isar/isar.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/channel/c_base_channel.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/channel/c_group_channel.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_notification_message.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';

part 'c_feed_channel.g.dart';

@collection
class CFeedChannel extends CBaseChannel {
  String? lastMessageRootId; // lastMessage
  bool? isTemplateLabelEnabled;
  bool? isCategoryFilterEnabled;
  late List<CNotificationCategory> notificationCategories;

  CFeedChannel();

  factory CFeedChannel.fromFeedChannel(FeedChannel channel) {
    return CFeedChannel()
      // BaseChannel
      ..setBaseChannel(channel)
      // FeedChannel
      ..lastMessageRootId = channel.lastMessage?.rootId
      ..isTemplateLabelEnabled = channel.isTemplateLabelEnabled
      ..isCategoryFilterEnabled = channel.isCategoryFilterEnabled
      ..notificationCategories = channel.notificationCategories
          .map((category) =>
              CNotificationCategory.fromNotificationCategory(category))
          .toList();
  }

  Future<FeedChannel?> toFeedChannel(Chat chat, Isar isar) async {
    final groupChannel = await CGroupChannel.get(chat, isar, channelUrl);
    if (groupChannel == null) {
      return null;
    }

    final feedChannel = FeedChannel(groupChannel: groupChannel)..set(chat);

    CBaseChannel.setCBaseChannel(chat, isar, feedChannel, this) as FeedChannel
      // FeedChannel
      ..lastMessage = lastMessageRootId != null
          ? await CNotificationMessage.get(chat, isar, lastMessageRootId!)
          : null
      ..isTemplateLabelEnabled = isTemplateLabelEnabled
      ..isCategoryFilterEnabled = isCategoryFilterEnabled
      ..notificationCategories = notificationCategories
          .map((category) => category.toNotificationCategory())
          .toList();

    return feedChannel;
  }

  static Future<CFeedChannel> upsert(
      Chat chat, Isar isar, FeedChannel channel) async {
    final cFeedChannel = CFeedChannel.fromFeedChannel(channel);
    final cGroupChannel = CGroupChannel.fromGroupChannel(channel.groupChannel)
      ..channelType = ChannelType.feed; // Check

    // GroupChannel
    await chat.dbManager.write(() async {
      await isar.cGroupChannels.put(cGroupChannel);
    });

    // FeedChannel
    await chat.dbManager.write(() async {
      await isar.cFeedChannels.put(cFeedChannel);
    });

    // [lastMessage] There are many empty values from server.
    // if (channel.lastMessage != null) {
    //   await CNotificationMessage.upsert(chat, isar, channel.lastMessage!);
    // }

    return cFeedChannel;
  }

  static Future<FeedChannel?> get(
      Chat chat, Isar isar, String channelUrl) async {
    final cFeedChannel = await isar.cFeedChannels
        .where()
        .channelUrlEqualTo(channelUrl)
        .findFirst();
    return await cFeedChannel?.toFeedChannel(chat, isar);
  }

  static Future<List<FeedChannel>> getChannels(
    Chat chat,
    Isar isar,
    FeedChannelListQuery query,
    int? offset,
  ) async {
    final cFeedChannels = await isar.cFeedChannels
        .where()
        .filter()

        // includeEmpty
        .optional(query.includeEmpty == false, (q) {
          return q.lastMessageRootIdIsNotNull();
        })

        // sort
        .optional(true, (q) {
          return q.sortByCreatedAt();
        })

        // offset
        .optional(offset != null, (q) {
          return q.offset(offset!);
        })

        // limit
        .limit(query.limit)
        .findAll();

    List<FeedChannel> channels = [];
    for (final cFeedChannel in cFeedChannels) {
      final channel = await cFeedChannel.toFeedChannel(chat, isar);
      if (channel != null) {
        channels.add(channel);
      }
    }
    return channels;
  }

  static Future<void> delete(Chat chat, Isar isar, String channelUrl) async {
    await chat.dbManager.write(() async {
      await isar.cFeedChannels.deleteByChannelUrl(channelUrl);
    });
  }
}

@embedded
class CNotificationCategory {
  late int id;
  late String customType;
  late String name;
  late bool isDefault;

  CNotificationCategory();

  factory CNotificationCategory.fromNotificationCategory(
      NotificationCategory category) {
    return CNotificationCategory()
      ..id = category.id
      ..customType = category.customType
      ..name = category.name
      ..isDefault = category.isDefault;
  }

  NotificationCategory toNotificationCategory() {
    return NotificationCategory(
      id: id,
      customType: customType,
      name: name,
      isDefault: isDefault,
    );
  }
}
