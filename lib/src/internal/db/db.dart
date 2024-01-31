// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:isar/isar.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/channel/c_feed_channel.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/channel/c_group_channel.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/channel/meta/c_channel_info.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/channel/meta/channel_info.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/chunk/c_channel_chunk.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/chunk/c_message_chunk.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/chunk/channel_chunk.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/chunk/chunk.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/chunk/message_chunk.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/login/c_login.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/login/login.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_admin_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_file_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_notification_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_user_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/meta/c_channel_access.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/meta/c_channel_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/meta/c_message_changelog_info.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/meta/channel_access.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/meta/channel_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/meta/message_changelog_info.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/user/c_user.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/feed_channel/feed_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/admin_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/file_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/notification_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/user_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/message_list_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/query/channel/feed_channel_list_query.dart';
import 'package:sendbird_chat_sdk/src/public/main/query/channel/group_channel_list_query.dart';

class DB {
  final Chat _chat;
  final Isar _isar;

  DB({
    required Chat chat,
    required Isar isar,
  })  : _chat = chat,
        _isar = isar;

  // DB
  Future<void> write(Function writeFunc) async {
    await _isar.writeTxn(() async {
      await writeFunc();
    });
  }

  Future<void> clear() async {
    await _isar.writeTxn(() async {
      await _isar.clear();
    });
  }

  // Login
  Future<void> upsertLogin(Login login) async {
    await CLogin.upsert(_chat, _isar, login);
  }

  Future<Login?> getLogin(String userId) async {
    return await CLogin.get(_chat, _isar, userId);
  }

  Future<void> deleteLogin(String userId) async {
    await CLogin.delete(_chat, _isar, userId);
  }

  Future<int> getLoginCount() async {
    return await _isar.cLogins.count();
  }

  // ChannelChunk
  Future<void> upsertChannelChunk(ChannelChunk chunk) async {
    await CChannelChunk.upsert(_chat, _isar, chunk);
  }

  Future<ChannelChunk?> getChannelChunk(ChannelChunkType chunkType) async {
    return await CChannelChunk.get(_chat, _isar, chunkType);
  }

  Future<void> deleteChannelChunk(ChannelChunkType chunkType) async {
    await CChannelChunk.delete(_chat, _isar, chunkType);
  }

  Future<int> getChannelChunkCount() async {
    return await _isar.cChannelChunks.count();
  }

  // MessageChunk
  Future<void> upsertMessageChunk(MessageChunk chunk) async {
    await CMessageChunk.upsert(_chat, _isar, chunk);
  }

  Future<MessageChunk?> getMessageChunk(String channelUrl) async {
    return await CMessageChunk.get(_chat, _isar, channelUrl);
  }

  Future<void> deleteMessageChunk(String channelUrl) async {
    await CMessageChunk.delete(_chat, _isar, channelUrl);
  }

  Future<void> deleteMessagesInChunk({
    required String channelUrl,
    required List<String> rootIds,
  }) async {
    if (rootIds.isEmpty) {
      return;
    }

    final messageChunk = await getMessageChunk(channelUrl);
    if (messageChunk != null) {
      final List<Chunk> chunks = [];

      for (final rootId in rootIds) {
        final message = await getChannelMessage(rootId);

        if (message?.createdAt != null) {
          final Chunk? chunk = messageChunk.getChunk(message!.createdAt);
          if (chunk != null && !chunks.contains(chunk)) {
            chunks.add(chunk);
          }
        }
      }

      bool isChanged = false;
      for (final chunk in chunks) {
        final cChannelMessages = await _isar.cChannelMessages
            .where()
            .createdAtBetween(
              chunk.oldestTs,
              chunk.latestTs,
              includeLower: true,
              includeUpper: true,
            )
            .sortByCreatedAt()
            .findAll();
        final newCChannelMessages = [...cChannelMessages];

        if (cChannelMessages.isNotEmpty) {
          for (final cChannelMessage in cChannelMessages) {
            for (final rootId in rootIds) {
              if (cChannelMessage.rootId == rootId) {
                newCChannelMessages.remove(cChannelMessage);
                isChanged = true;
                break;
              }
            }
          }

          messageChunk.removeChunk(chunk);

          if (newCChannelMessages.isNotEmpty) {
            messageChunk.add(Chunk(
              oldestTs: newCChannelMessages.first.createdAt,
              latestTs: newCChannelMessages.last.createdAt,
            ));
          }
        }
      }

      if (isChanged) {
        await upsertMessageChunk(messageChunk);
      }
    }
  }

  Future<int> getMessageChunkCount() async {
    return await _isar.cMessageChunks.count();
  }

  // ChannelChangeLogInfo
  Future<void> upsertChannelInfo(ChannelInfo info) async {
    await CChannelInfo.upsert(_chat, _isar, info);
  }

  Future<ChannelInfo?> getChannelInfo() async {
    return await CChannelInfo.get(_chat, _isar);
  }

  Future<void> deleteChannelInfo() async {
    await CChannelInfo.delete(_chat, _isar);
  }

  Future<int> getChannelInfoCount() async {
    return await _isar.cChannelInfos.count();
  }

  // MessageChangeLogInfo
  Future<void> upsertMessageChangeLogInfo(MessageChangeLogInfo info) async {
    await CMessageChangeLogInfo.upsert(_chat, _isar, info);
  }

  Future<MessageChangeLogInfo?> getMessageChangeLogInfo(
      String channelUrl) async {
    return await CMessageChangeLogInfo.get(_chat, _isar, channelUrl);
  }

  Future<void> deleteMessageChangeLogInfo(String channelUrl) async {
    await CMessageChangeLogInfo.delete(_chat, _isar, channelUrl);
  }

  Future<int> getMessageChangeLogInfoCount() async {
    return await _isar.cMessageChangeLogInfos.count();
  }

  // ChannelAccess
  Future<void> upsertChannelAccess(ChannelAccess channelAccess) async {
    await CChannelAccess.upsert(_chat, _isar, channelAccess);
  }

  Future<List<String>> getOrderedChannelUrlsToDelete() async {
    final channelUrls =
        (await _isar.cChannelAccess.where().sortByLastAccessedAt().findAll())
            .map((cChannelAccess) => cChannelAccess.channelUrl)
            .toList();
    return channelUrls;
  }

  Future<void> deleteChannelAccess(String channelUrl) async {
    await CChannelAccess.delete(_chat, _isar, channelUrl);
  }

  Future<int> getChannelAccessCount() async {
    return await _isar.cChannelAccess.count();
  }

  // GroupChannel
  Future<void> upsertGroupChannel(GroupChannel channel) async {
    await CGroupChannel.upsert(_chat, _isar, channel);
  }

  Future<GroupChannel?> getGroupChannel(String channelUrl) async {
    return await CGroupChannel.get(_chat, _isar, channelUrl);
  }

  Future<List<GroupChannel>> getGroupChannels(
      GroupChannelListQuery query, int? offset) async {
    return await CGroupChannel.getChannels(_chat, _isar, query, offset);
  }

  Future<void> deleteGroupChannel(String channelUrl) async {
    await CGroupChannel.delete(_chat, _isar, channelUrl);
  }

  Future<int> getGroupChannelCount() async {
    return await _isar.cGroupChannels.count();
  }

  // FeedChannel
  Future<void> upsertFeedChannel(FeedChannel channel) async {
    await CFeedChannel.upsert(_chat, _isar, channel);
  }

  Future<FeedChannel?> getFeedChannel(String channelUrl) async {
    return await CFeedChannel.get(_chat, _isar, channelUrl);
  }

  Future<List<FeedChannel>> getFeedChannels(
      FeedChannelListQuery query, int? offset) async {
    return await CFeedChannel.getChannels(_chat, _isar, query, offset);
  }

  Future<void> deleteFeedChannel(String channelUrl) async {
    await CFeedChannel.delete(_chat, _isar, channelUrl);
  }

  Future<int> getFeedChannelCount() async {
    return await _isar.cFeedChannels.count();
  }

  // ChannelMessage
  Future<bool> hasMessages(String channelUrl) async {
    return await CChannelMessage.hasMessages(_chat, _isar, channelUrl);
  }

  Future<ChannelMessage?> getChannelMessage(String rootId) async {
    return await CChannelMessage.get(_chat, _isar, rootId);
  }

  Future<List<RootMessage>> getMessages(
    ChannelType channelType,
    String channelUrl,
    SendingStatus sendingStatus,
    int timestamp,
    MessageListParams params,
    bool isPrevious,
  ) async {
    return await CChannelMessage.getMessages(
      _chat,
      _isar,
      channelType,
      channelUrl,
      sendingStatus,
      timestamp,
      params,
      isPrevious,
    );
  }

  Future<List<BaseMessage>> getPendingMessages({
    required ChannelType channelType,
    required String channelUrl,
  }) async {
    return await CChannelMessage.getPendingMessages(
      _chat,
      _isar,
      channelType,
      channelUrl,
    );
  }

  Future<List<BaseMessage>> getFailedMessages({
    required ChannelType channelType,
    required String channelUrl,
    required bool reverse,
  }) async {
    return await CChannelMessage.getFailedMessages(
      _chat,
      _isar,
      channelType,
      channelUrl,
      reverse,
    );
  }

  Future<void> removeFailedMessages({
    required ChannelType channelType,
    required String channelUrl,
    required List<BaseMessage> messages,
  }) async {
    await CChannelMessage.removeFailedMessages(
      _chat,
      _isar,
      channelType,
      channelUrl,
      messages,
    );
  }

  Future<void> removeAllFailedMessages({
    required ChannelType channelType,
    required String channelUrl,
  }) async {
    await CChannelMessage.removeAllFailedMessages(
      _chat,
      _isar,
      channelType,
      channelUrl,
    );
  }

  Future<void> removeAllPendingMessages({
    required ChannelType channelType,
    required String channelUrl,
  }) async {
    await CChannelMessage.removeAllPendingMessages(
      _chat,
      _isar,
      channelType,
      channelUrl,
    );
  }

  Future<List<RootMessage>> getStartingPointMessages(
    ChannelType channelType,
    String channelUrl,
    int timestamp,
  ) async {
    return await CChannelMessage.getStartingPointMessages(
        _chat, _isar, channelType, channelUrl, timestamp);
  }

  Future<void> deleteChannelMessage(String rootId) async {
    await CChannelMessage.delete(_chat, _isar, rootId);
  }

  // Message
  Future<void> deleteMessages(String channelUrl) async {
    // UserMessage
    final cUserMessages = await _isar.cUserMessages
        .where()
        .channelUrlEqualTo(channelUrl)
        .findAll();
    for (final cUserMessage in cUserMessages) {
      await deleteUserMessage(cUserMessage.rootId);
    }

    // FileMessage
    final cFileMessages = await _isar.cFileMessages
        .where()
        .channelUrlEqualTo(channelUrl)
        .findAll();
    for (final cFileMessage in cFileMessages) {
      await deleteFileMessage(cFileMessage.rootId);
    }

    // AdminMessage
    final cAdminMessages = await _isar.cAdminMessages
        .where()
        .channelUrlEqualTo(channelUrl)
        .findAll();
    for (final cAdminMessage in cAdminMessages) {
      await deleteAdminMessage(cAdminMessage.rootId);
    }

    // NotificationMessage
    final cNotificationMessages = await _isar.cNotificationMessages
        .where()
        .channelUrlEqualTo(channelUrl)
        .findAll();
    for (final cNotificationMessage in cNotificationMessages) {
      await deleteNotificationMessage(cNotificationMessage.rootId);
    }
  }

  // UserMessage
  Future<void> upsertUserMessage(UserMessage message) async {
    await CUserMessage.upsert(_chat, _isar, message);
  }

  Future<UserMessage?> getUserMessage(String rootId) async {
    return await CUserMessage.get(_chat, _isar, rootId);
  }

  Future<void> deleteUserMessage(String rootId) async {
    await CUserMessage.delete(_chat, _isar, rootId);
  }

  Future<int> getUserMessageCount() async {
    return await _isar.cUserMessages.count();
  }

  // FileMessage
  Future<void> upsertFileMessage(FileMessage message) async {
    await CFileMessage.upsert(_chat, _isar, message);
  }

  Future<FileMessage?> getFileMessage(String rootId) async {
    return await CFileMessage.get(_chat, _isar, rootId);
  }

  Future<void> deleteFileMessage(String rootId) async {
    await CFileMessage.delete(_chat, _isar, rootId);
  }

  Future<int> getFileMessageCount() async {
    return await _isar.cFileMessages.count();
  }

  // AdminMessage
  Future<void> upsertAdminMessage(AdminMessage message) async {
    await CAdminMessage.upsert(_chat, _isar, message);
  }

  Future<AdminMessage?> getAdminMessage(String rootId) async {
    return await CAdminMessage.get(_chat, _isar, rootId);
  }

  Future<void> deleteAdminMessage(String rootId) async {
    await CAdminMessage.delete(_chat, _isar, rootId);
  }

  Future<int> getAdminMessageCount() async {
    return await _isar.cAdminMessages.count();
  }

  // NotificationMessage
  Future<void> upsertNotificationMessage(NotificationMessage message) async {
    await CNotificationMessage.upsert(_chat, _isar, message);
  }

  Future<NotificationMessage?> getNotificationMessage(String rootId) async {
    return await CNotificationMessage.get(_chat, _isar, rootId);
  }

  Future<void> deleteNotificationMessage(String rootId) async {
    await CNotificationMessage.delete(_chat, _isar, rootId);
  }

  Future<int> getNotificationMessageCount() async {
    return await _isar.cNotificationMessages.count();
  }

  // User
  Future<void> upsertUser(User user) async {
    await CUser.upsert(_chat, _isar, user);
  }

  Future<User?> getUser(String userId) async {
    return await CUser.get(_chat, _isar, userId);
  }

  Future<void> deleteUser(String userId) async {
    await CUser.delete(_chat, _isar, userId);
  }

  Future<int> getUserCount() async {
    return await _isar.cUsers.count();
  }
}
