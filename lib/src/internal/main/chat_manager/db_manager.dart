// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:isar/isar.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_sdk/src/internal/db/db.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/channel/c_feed_channel.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/channel/c_group_channel.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/channel/meta/c_channel_info.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/channel/meta/channel_info.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/chunk/c_channel_chunk.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/chunk/c_message_chunk.dart';
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
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/meta/message_changelog_info.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/user/c_user.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_context/chat_context.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/collection_manager/collection_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/reconnect_task.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/model/default/local_cache_event_stat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/sendbird_statistics.dart';
import 'package:sendbird_chat_sdk/src/internal/main/stats/stat_utils.dart';
import 'package:universal_io/io.dart';

class DBManager {
  final _dbName = 'sendbird_chat';
  final _maxDBFileSize = 256; // MB

  late final Isar _isar;
  bool _isInitialized = false;

  final Chat _chat;
  late final DB _db;
  late final Directory _dbDir;

  DBManager({required Chat chat}) : _chat = chat;

  DB getDB() {
    return _db;
  }

  Future<bool> init() async {
    try {
      if (_chat.isTest) {
        // https://github.com/isar/isar#unit-tests
        await Isar.initializeIsarCore(download: true);
        _dbDir = Directory.systemTemp.createTempSync();
      } else {
        _dbDir = await getApplicationDocumentsDirectory();
      }

      _isar = await Isar.open(
        [
          // Login
          CLoginSchema,
          // Chunk
          CChannelChunkSchema,
          CMessageChunkSchema,
          // Channel
          CChannelInfoSchema,
          CFeedChannelSchema,
          CGroupChannelSchema,
          // Message
          CAdminMessageSchema,
          CMessageChangeLogInfoSchema,
          CChannelAccessSchema,
          CChannelMessageSchema,
          CFileMessageSchema,
          CNotificationMessageSchema,
          CUserMessageSchema,
          // User
          CUserSchema,
        ],
        directory: _dbDir.path,
        name: _dbName,
        maxSizeMiB: Isar.defaultMaxSizeMiB, // 1024 MB
      );
    } catch (e) {
      sbLog.e(StackTrace.current, 'e: $e');
      return false;
    }

    _db = DB(chat: _chat, isar: _isar);
    _isInitialized = true;
    return true;
  }

  bool isEnabled() {
    return _chat.chatContext.options.useCollectionCaching && _isInitialized;
  }

  Future<int?> getDBFileSize() async {
    int? dbFileSize;
    try {
      final path = p.join(_dbDir.path, '$_dbName.isar');
      final file = File(path);
      if (await file.exists()) {
        dbFileSize = await file.length();
        sbLog.i(StackTrace.current, '$dbFileSize');
      }
    } catch (e) {
      sbLog.e(StackTrace.current, 'e: $e');
    }
    return dbFileSize;
  }

  Future<void> write(Function writeFunc, {bool force = false}) async {
    if (isEnabled() || force) {
      try {
        await _db.write(writeFunc);
      } catch (e) {
        sbLog.e(StackTrace.current, e.toString());

        _chat.chatContext.options.useCollectionCaching = false;
        await clear();
      }
    }
  }

  Future<void> clear() async {
    if (isEnabled()) {
      try {
        await _db.clear();
      } catch (e) {
        sbLog.e(StackTrace.current, e.toString());
      }
    }
  }

  Future<void> checkDBFileSize() async {
    if (isEnabled()) {
      final dbFileSize = await getDBFileSize();
      if (dbFileSize != null && dbFileSize > _maxDBFileSize * 1024 * 1024) {
        List<String> channelUrls = await _db.getOrderedChannelUrlsToDelete();

        int? size;
        for (final channelUrl in channelUrls) {
          size = await getDBFileSize();
          // Delete until the half of it. (Initial DB file size is 1MB.)
          if (size != null &&
              size > (_maxDBFileSize / 2) * 1024 * 1024 &&
              size > 1024 * 1024) {
            await deleteMessagesInChannel(channelUrl);
          } else {
            break;
          }
        }
      }
    }
  }

  // Login
  Future<void> setLoginInfo(ChatContext context, User user) async {
    if (isEnabled()) {
      final login = await _db.getLogin(user.userId);
      if (login == null) {
        await _db.clear(); // Defensive
      }

      await _db.upsertUser(user);
      await _db.upsertLogin(Login(
        userId: user.userId,
        services: context.services,
        appInfo: context.appInfo,
        uploadSizeLimit: context.uploadSizeLimit,
        maxUnreadCountOnSuperGroup: context.maxUnreadCountOnSuperGroup,
        lastConnectedAt: context.lastConnectedAt,
        reconnectConfig: context.reconnectConfig,
      ));
    }
  }

  Future<User?> getLoginInfoByException(
      String userId, SendbirdException e) async {
    User? user;
    if (isEnabled()) {
      if (e.code == SendbirdError.userNotExist ||
          e.code == SendbirdError.accessTokenNotValid ||
          e.code == SendbirdError.accessTokenRevoked) {
        await _db.clear();
      } else {
        final login = await _db.getLogin(userId);
        if (login != null) {
          user = await _db.getUser(userId);
          if (user != null) {
            _chat.chatContext.currentUser = user;
            _chat.chatContext.currentUserId = user.userId;
            _chat.chatContext.services = login.services;
            _chat.chatContext.appInfo = login.appInfo;
            _chat.chatContext.uploadSizeLimit = login.uploadSizeLimit;
            _chat.chatContext.maxUnreadCountOnSuperGroup =
                login.maxUnreadCountOnSuperGroup;
            _chat.chatContext.lastConnectedAt = login.lastConnectedAt;
            _chat.chatContext.reconnectConfig = login.reconnectConfig;

            // sessionKey
            _chat.chatContext.sessionKey =
                await _chat.sessionManager.getSessionKey();

            // reconnectTask
            if (_chat.chatContext.reconnectConfig != null) {
              _chat.chatContext.reconnectTask =
                  ReconnectTask(_chat.chatContext.reconnectConfig!);
            }
          }
        }
      }
    }
    return user;
  }

  // Channel
  Future<void> deleteMessagesInChannel(channelUrl) async {
    if (isEnabled()) {
      // Messages
      await deleteMessagesInDeletedChannel(channelUrl);

      // MessageChangeLogInfo
      await _db.deleteMessageChangeLogInfo(channelUrl);
    }
  }

  // GroupChannel
  Future<bool> hasGroupChannels() async {
    return (await _db.getGroupChannelCount() > 0);
  }

  Future<void> upsertGroupChannels(List<GroupChannel> channels) async {
    if (isEnabled()) {
      for (final channel in channels) {
        await _db.upsertGroupChannel(channel);
      }
    }
  }

  Future<List<GroupChannel>> getGroupChannels({
    required GroupChannelListQuery query,
    int? offset,
  }) async {
    if (isEnabled()) {
      return await _db.getGroupChannels(query, offset);
    }
    return [];
  }

  Future<bool> canAddChannel({
    required GroupChannelListQuery query,
    required String channelUrl,
  }) async {
    if (isEnabled()) {
      return await _db.canAddChannel(query, channelUrl);
    }
    return true;
  }

  Future<GroupChannel?> getGroupChannel(String channelUrl) async {
    if (isEnabled()) {
      return await _db.getGroupChannel(channelUrl);
    }
    return null;
  }

  Future<void> deleteGroupChannels(List<String> channelUrls) async {
    if (isEnabled()) {
      for (final channelUrl in channelUrls) {
        await _db.deleteGroupChannel(channelUrl);

        // ChannelAccess
        await _db.deleteChannelAccess(channelUrl);

        // ChannelChangeLogInfo
        await _db.deleteChannelInfo();

        // Messages
        await deleteMessagesInDeletedChannel(channelUrl);

        // MessageChangeLogInfo
        await _db.deleteMessageChangeLogInfo(channelUrl);
      }
    }
  }

  // FeedChannel
  Future<void> upsertFeedChannels(List<FeedChannel> channels) async {
    if (isEnabled()) {
      for (final channel in channels) {
        await _db.upsertFeedChannel(channel);
      }
    }
  }

  Future<List<FeedChannel>> getFeedChannels({
    required FeedChannelListQuery query,
    int? offset,
  }) async {
    if (isEnabled()) {
      return await _db.getFeedChannels(query, offset);
    }
    return [];
  }

  Future<FeedChannel?> getFeedChannel(String channelUrl) async {
    if (isEnabled()) {
      return await _db.getFeedChannel(channelUrl);
    }
    return null;
  }

  Future<void> deleteFeedChannels(List<String> channelUrls) async {
    if (isEnabled()) {
      for (final channelUrl in channelUrls) {
        await _db.deleteFeedChannel(channelUrl);

        // ChannelAccess
        await _db.deleteChannelAccess(channelUrl);

        // ChannelChangeLogInfo
        await _db.deleteChannelInfo();

        // Messages
        await deleteMessagesInDeletedChannel(channelUrl);

        // MessageChangeLogInfo
        await _db.deleteMessageChangeLogInfo(channelUrl);
      }
    }
  }

  // Message
  Future<bool> hasMessages(String channelUrl) async {
    return await _db.hasMessages(channelUrl);
  }

  Future<void> upsertMessages(List<RootMessage> messages) async {
    if (isEnabled()) {
      for (final message in messages) {
        switch (message.messageType) {
          case MessageType.user:
            await _db.upsertUserMessage(message as UserMessage);
            break;
          case MessageType.file:
            // withFileBytes() is not supported.
            final params = (message as FileMessage).messageCreateParams;
            if (params == null || params.fileInfo.fileBytes == null) {
              await _db.upsertFileMessage(message);
            }
            break;
          case MessageType.admin:
            await _db.upsertAdminMessage(message as AdminMessage);
            break;
          case MessageType.notification:
            await _db.upsertNotificationMessage(message as NotificationMessage);
            break;
        }
      }
    }
  }

  Future<List<RootMessage>> getMessages({
    required ChannelType channelType,
    required String channelUrl,
    required SendingStatus sendingStatus,
    required int timestamp,
    required MessageListParams params,
    required bool isPrevious,
  }) async {
    if (isEnabled()) {
      return await _db.getMessages(
        channelType,
        channelUrl,
        sendingStatus,
        timestamp,
        params,
        isPrevious,
      );
    }
    return [];
  }

  Future<List<BaseMessage>> getPendingMessages({
    required ChannelType channelType,
    required String channelUrl,
  }) async {
    if (isEnabled()) {
      return await _db.getPendingMessages(
        channelType: channelType,
        channelUrl: channelUrl,
      );
    }
    return [];
  }

  Future<List<BaseMessage>> getFailedMessages({
    required ChannelType channelType,
    required String channelUrl,
    bool reverse = false,
  }) async {
    if (isEnabled()) {
      return await _db.getFailedMessages(
        channelType: channelType,
        channelUrl: channelUrl,
        reverse: reverse,
      );
    }
    return [];
  }

  Future<void> removeFailedMessages({
    required ChannelType channelType,
    required String channelUrl,
    required List<BaseMessage> messages,
  }) async {
    if (isEnabled()) {
      final failedMessages = messages
          .where((message) => message.sendingStatus == SendingStatus.failed)
          .toList();

      await _db.removeFailedMessages(
        channelType: channelType,
        channelUrl: channelUrl,
        messages: failedMessages,
      );

      // Event
      for (final messageCollection
          in _chat.collectionManager.baseMessageCollections) {
        if (messageCollection.baseChannel.channelUrl == channelUrl) {
          _chat.collectionManager.sendEventsToMessageCollection(
            messageCollection: messageCollection,
            baseChannel: messageCollection.baseChannel,
            eventSource: CollectionEventSource.eventMessageDeleted,
            sendingStatus: SendingStatus.failed,
            deletedMessageIds:
                failedMessages.map((message) => message.rootId).toList(),
          );
          break;
        }
      }
    }
  }

  Future<void> removeAllFailedMessages({
    required ChannelType channelType,
    required String channelUrl,
  }) async {
    if (isEnabled()) {
      await _db.removeAllFailedMessages(
        channelType: channelType,
        channelUrl: channelUrl,
      );

      // Event
      for (final messageCollection
          in _chat.collectionManager.baseMessageCollections) {
        if (messageCollection.baseChannel.channelUrl == channelUrl) {
          final failedMessages = messageCollection.messageList
              .where((message) =>
                  message is! BaseMessage ||
                  message.sendingStatus == SendingStatus.failed)
              .toList();

          _chat.collectionManager.sendEventsToMessageCollection(
            messageCollection: messageCollection,
            baseChannel: messageCollection.baseChannel,
            eventSource: CollectionEventSource.eventMessageDeleted,
            sendingStatus: SendingStatus.failed,
            deletedMessageIds:
                failedMessages.map((message) => message.rootId).toList(),
          );
          break;
        }
      }
    }
  }

  Future<void> removeAllPendingMessages({
    required ChannelType channelType,
    required String channelUrl,
  }) async {
    if (isEnabled()) {
      await _db.removeAllPendingMessages(
        channelType: channelType,
        channelUrl: channelUrl,
      );
    }
  }

  Future<List<RootMessage>> getStartingPointMessages({
    required ChannelType channelType,
    required String channelUrl,
    required int timestamp,
  }) async {
    if (isEnabled()) {
      return await _db.getStartingPointMessages(
          channelType, channelUrl, timestamp);
    }
    return [];
  }

  Future<void> deleteMessagesInDeletedChannel(String channelUrl) async {
    if (isEnabled()) {
      // MessageChunk
      await _db.deleteMessageChunk(channelUrl);

      // Message
      await _db.deleteMessages(channelUrl);
    }
  }

  Future<void> deleteMessages(BaseChannel channel, List<String> rootIds) async {
    if (isEnabled()) {
      // Message
      if (channel is GroupChannel) {
        for (final rootId in rootIds) {
          await _db.deleteUserMessage(rootId);
          await _db.deleteFileMessage(rootId);
          await _db.deleteAdminMessage(rootId);
        }
      } else if (channel is FeedChannel) {
        for (final rootId in rootIds) {
          await _db.deleteNotificationMessage(rootId);
        }
      }
    }
  }

  Future<void> deleteUserMessage(UserMessage message) async {
    if (isEnabled()) {
      await _db.deleteUserMessage(message.rootId);
    }
  }

  Future<void> deleteFileMessage(FileMessage message) async {
    if (isEnabled()) {
      await _db.deleteFileMessage(message.rootId);
    }
  }

  // MessageChunk
  Future<void> upsertMessagesInChunk({
    required String channelUrl,
    required List<RootMessage> messages,
  }) async {
    if (messages.isEmpty) {
      return;
    }

    if (isEnabled()) {
      int oldestTs = messages.first.createdAt;
      int latestTs = messages.first.createdAt;
      for (final message in messages) {
        if (message.createdAt < oldestTs) {
          oldestTs = message.createdAt;
        }
        if (message.createdAt > latestTs) {
          latestTs = message.createdAt;
        }
      }
      final Chunk newChunk = Chunk(oldestTs: oldestTs, latestTs: latestTs);

      final messageChunk = await _db.getMessageChunk(channelUrl);
      if (messageChunk != null) {
        messageChunk.addNewChunk(newChunk);
        await _db.upsertMessageChunk(messageChunk);
      } else {
        await _db.upsertMessageChunk(
          MessageChunk(channelUrl: channelUrl, chunks: [newChunk]),
        );
      }
    }
  }

  Future<MessageChunk?> getMessageChunk(String channelUrl) async {
    if (isEnabled()) {
      return await _db.getMessageChunk(channelUrl);
    }
    return null;
  }

  Future<void> deleteMessagesInChunk({
    required String channelUrl,
    required List<String> rootIds,
  }) async {
    if (isEnabled()) {
      await _db.deleteMessagesInChunk(channelUrl: channelUrl, rootIds: rootIds);
    }
  }

  // ChannelInfo
  Future<void> upsertChannelInfo(ChannelInfo info) async {
    await _db.upsertChannelInfo(info);
  }

  Future<ChannelInfo?> getChannelInfo() async {
    return await _db.getChannelInfo();
  }

  // MessageChangeLogInfo
  Future<void> upsertMessageChangeLogInfo(MessageChangeLogInfo info) async {
    await _db.upsertMessageChangeLogInfo(info);
  }

  Future<MessageChangeLogInfo?> getMessageChangeLogInfo(
      String channelUrl) async {
    return await _db.getMessageChangeLogInfo(channelUrl);
  }

  // Cache Hit or Miss
  Future<bool> isCacheHit({
    required BaseMessageCollection collection,
    required MessageListParams params,
    required List<RootMessage> localMessages,
    required int? lastSyncedTimeStamp,
    required MessageCollectionLoadType loadType,
  }) async {
    bool isCacheHit = true;
    String cause = '';

    try {
      // Check local message count
      switch (loadType) {
        case MessageCollectionLoadType.initialize:
          // Can not be CacheHit from initialize.
          return false;
        // int startingPointMessageCount = 0;
        // if (params.inclusive) {
        //   for (final message in localMessages) {
        //     if (message.createdAt == collection.startingPoint) {
        //       startingPointMessageCount++;
        //     }
        //   }
        // }
        //
        // // We may get the correct hasNext from server.
        // if (params.previousResultSize + params.nextResultSize !=
        //     localMessages.length - startingPointMessageCount) {
        //   isCacheHit = false; // ResultSize is not same queried cache count.
        //   cause = 'Insufficient local message count';
        // }
        // break;
        case MessageCollectionLoadType.loadPrevious:
          // Server does not support hasPrevious.
          if (params.previousResultSize != localMessages.length) {
            isCacheHit = false; // ResultSize is not same queried cache count.
            cause = 'Insufficient local message count';
          }
          break;
        case MessageCollectionLoadType.loadNext:
          // We may get the correct hasNext from server.
          if (params.nextResultSize != localMessages.length) {
            isCacheHit = false; // ResultSize is not same queried cache count.
            cause = 'Insufficient local message count';
          }
          break;
      }

      // Check params
      if (isCacheHit) {
        if (params.replyType != null) {
          isCacheHit = false; // This can not be queried in local.
          cause = 'params.replyType is not null';
        } else if (params.showSubChannelMessagesOnly) {
          isCacheHit = false; // This can not be queried in local.
          cause = 'params.showSubChannelMessagesOnly is true';
        }
      }

      if (isCacheHit) {
        // Check if the localMessages in chunk.
        final messageChunk =
            await _db.getMessageChunk(collection.baseChannel.channelUrl);
        if (messageChunk != null) {
          int oldestTs = localMessages.first.createdAt;
          int latestTs = localMessages.first.createdAt;
          for (final message in localMessages) {
            if (message.createdAt < oldestTs) {
              oldestTs = message.createdAt;
            }
            if (message.createdAt > latestTs) {
              latestTs = message.createdAt;
            }
          }

          final isInCurrentChunk = messageChunk.isInCurrentChunk(
            oldestTs: oldestTs,
            latestTs: latestTs,
            lastSyncedTimeStamp: lastSyncedTimeStamp,
          );

          if (isInCurrentChunk) {
            isCacheHit = true;
          } else {
            isCacheHit = false;
            cause = 'Not contained in current chunk';
          }
        } else {
          isCacheHit = false;
          cause = 'Not contained in current chunk';
        }
      }
    } catch (e) {
      sbLog.e(StackTrace.current, e.toString());
      isCacheHit = false;
      cause = e.toString();
    }

    // LocalCacheEvent Stat
    _appendLocalCacheEventStat(
      channelUrl: collection.baseChannel.channelUrl,
      startingPoint: collection.startingPoint,
      measuredOn: _getMeasuredOn(loadType),
      event: isCacheHit ? LocalCacheEvent.cacheHit : LocalCacheEvent.cacheMiss,
      maxDbSize: _maxDBFileSize,
      messageInitPolicy: 'cache_and_replace_by_api',
      useLocalCache: SendbirdChat.getOptions().useCollectionCaching,
      collectionId: collection.collectionId,
    );

    sbLog.d(StackTrace.current,
        '[${loadType.asString()}] ${isCacheHit ? '[HIT]' : '[MISS]($cause)'}');
    return isCacheHit;
  }

  LocalCacheEventMeasuredOn _getMeasuredOn(MessageCollectionLoadType loadType) {
    switch (loadType) {
      case MessageCollectionLoadType.initialize:
        return LocalCacheEventMeasuredOn.initialLoad;
      case MessageCollectionLoadType.loadPrevious:
        return LocalCacheEventMeasuredOn.loadPrev;
      case MessageCollectionLoadType.loadNext:
        return LocalCacheEventMeasuredOn.loadNext;
    }
  }

  void _appendLocalCacheEventStat({
    required String channelUrl,
    required int startingPoint,
    required LocalCacheEventMeasuredOn measuredOn,
    required LocalCacheEvent event,
    required int maxDbSize,
    required String messageInitPolicy,
    required bool useLocalCache,
    required String collectionId,
  }) {
    final Map<String, dynamic> data = {
      'channel_url': channelUrl,
      'starting_point': startingPoint,
      'measured_on': StatUtils.getLocalCacheEventMeasuredOnString(measuredOn),
      'event': StatUtils.getLocalCacheEventString(event),
      'max_db_size': maxDbSize,
      'message_init_policy': messageInitPolicy,
      'use_local_cache': useLocalCache,
      'collection_id': collectionId,
    };
    SendbirdStatistics.appendStat(
      type: 'feature:local_cache_event',
      data: data,
    );
  }

  void appendLocalCacheStat({
    required bool useLocalCache,
    bool? useGroupChannelCollection,
    bool? useMessageCollection,
  }) {
    final Map<String, dynamic> data = {
      'use_local_cache': useLocalCache,
    };

    if (useGroupChannelCollection != null || useMessageCollection != null) {
      data['collection_interface'] = {};

      if (useGroupChannelCollection != null) {
        data['collection_interface']['group_channel'] =
            useGroupChannelCollection;
      }

      if (useMessageCollection != null) {
        data['collection_interface']['message'] = useMessageCollection;
      }
    }

    SendbirdStatistics.appendStat(
      type: 'feature:local_cache',
      data: data,
    );
  }
}

enum MessageCollectionLoadType {
  initialize,
  loadPrevious,
  loadNext,
}
