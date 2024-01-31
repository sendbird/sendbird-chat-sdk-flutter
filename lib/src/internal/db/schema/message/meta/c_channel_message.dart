// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:isar/isar.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_admin_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_file_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_notification_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_user_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/meta/c_channel_access.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/meta/channel_access.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/meta/channel_message.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';

part 'c_channel_message.g.dart';

@collection
class CChannelMessage {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String rootId;

  @Index(composite: [CompositeIndex('rootId')])
  @enumerated
  late MessageType messageType;

  @Index()
  late String channelUrl;

  @Index(composite: [CompositeIndex('channelUrl')])
  @enumerated
  late ChannelType channelType;

  @Index()
  late int createdAt;

  @Index()
  @enumerated
  late SendingStatus sendingStatus; // sendingStatus for filtering

  late String? customType; // customType for filtering
  late String? senderId; // senderId for filtering

  CChannelMessage();

  factory CChannelMessage.fromChannelMessage(ChannelMessage message) {
    return CChannelMessage()
      ..rootId = message.rootId
      ..messageType = message.messageType
      ..channelUrl = message.channelUrl
      ..channelType = message.channelType
      ..createdAt = message.createdAt
      ..sendingStatus = message.sendingStatus
      ..customType = message.customType
      ..senderId = message.senderId;
  }

  Future<ChannelMessage?> toChannelMessage(Chat chat, Isar isar) async {
    late RootMessage? message;
    if (messageType == MessageType.user) {
      final cUserMessage = await isar.cUserMessages.getByRootId(rootId);
      message = await cUserMessage?.toUserMessage(chat, isar);
    } else if (messageType == MessageType.file) {
      final cFileMessage = await isar.cFileMessages.getByRootId(rootId);
      message = await cFileMessage?.toFileMessage(chat, isar);
    } else if (messageType == MessageType.admin) {
      final cAdminMessage = await isar.cAdminMessages.getByRootId(rootId);
      message = await cAdminMessage?.toAdminMessage(chat, isar);
    } else if (messageType == MessageType.notification) {
      final cNotificationMessage =
          await isar.cNotificationMessages.getByRootId(rootId);
      message = await cNotificationMessage?.toNotificationMessage(chat, isar);
    }

    return message != null
        ? ChannelMessage(
            rootId: rootId,
            messageType: messageType,
            channelUrl: channelUrl,
            channelType: channelType,
            createdAt: createdAt,
            sendingStatus: sendingStatus,
            customType: customType,
            senderId: senderId,
            message: message,
          )
        : null;
  }

  static Future<bool> hasMessages(
      Chat chat, Isar isar, String channelUrl) async {
    return await isar.cChannelMessages
        .where()
        .channelUrlEqualTo(channelUrl)
        .isNotEmpty();
  }

  static Future<CChannelMessage> upsert(
      Chat chat, Isar isar, RootMessage message) async {
    final cChannelMessage = CChannelMessage.fromChannelMessage(
      ChannelMessage(
        rootId: message.rootId,
        messageType: message.messageType,
        channelUrl: message.channelUrl,
        channelType: message.channelType,
        createdAt: message.createdAt,
        sendingStatus: message is BaseMessage
            ? (message.sendingStatus ?? SendingStatus.none)
            : SendingStatus.succeeded,
        customType: message.customType,
        senderId: message is BaseMessage ? message.sender?.userId : null,
        message: message,
      ),
    );

    // ChannelMessage
    await chat.dbManager.write(() async {
      await isar.cChannelMessages.put(cChannelMessage);
    });

    // ChannelAccess
    await CChannelAccess.upsert(
      chat,
      isar,
      ChannelAccess(
        channelUrl: message.channelUrl,
        lastAccessedAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    return cChannelMessage;
  }

  static Future<ChannelMessage?> get(
      Chat chat, Isar isar, String rootId) async {
    final cChannelMessage =
        await isar.cChannelMessages.where().rootIdEqualTo(rootId).findFirst();
    return await cChannelMessage?.toChannelMessage(chat, isar);
  }

  static Future<List<RootMessage>> getMessages(
    Chat chat,
    Isar isar,
    ChannelType channelType,
    String channelUrl,
    SendingStatus sendingStatus,
    int timestamp,
    MessageListParams params,
    bool isPrevious, // false: Next
  ) async {
    // [includeMetaArray]
    // When calling API, this value have to be `true` to make chunk.

    // [includeReactions]
    // When calling API, this value have to be `true` to make chunk.

    // [includeThreadInfo]
    // When calling API, this value have to be `true` to make chunk.

    // [includeParentMessageInfo]
    // When calling API, this value have to be `true` to make chunk.

    // [replyType]
    // Must call API, because this can not be queried with local cache.

    // [showSubChannelMessagesOnly]
    // Must call API, because this can not be queried with local cache.

    final cChannelMessages = await isar.cChannelMessages
        .where()

        // channelType & channelUrl & reverse
        .channelTypeChannelUrlEqualTo(channelType, channelUrl)
        .filter()

        // sendingStatus
        .optional(sendingStatus == SendingStatus.succeeded, (q) {
          return q.sendingStatusEqualTo(SendingStatus.succeeded);
        })
        .optional(sendingStatus == SendingStatus.failed, (q) {
          return q.sendingStatusEqualTo(SendingStatus.failed);
        })
        .optional(sendingStatus == SendingStatus.pending, (q) {
          return q.sendingStatusEqualTo(SendingStatus.pending);
        })

        // timestamp & inclusive & reverse
        .optional(isPrevious, (q) {
          return q.createdAtLessThan(timestamp, include: params.inclusive);
        })
        .optional(isPrevious == false, (q) {
          return q.createdAtGreaterThan(timestamp, include: params.inclusive);
        })

        // messageType
        .optional(params.messageType == MessageTypeFilter.user, (q) {
          return q.messageTypeEqualTo(MessageType.user);
        })
        .optional(params.messageType == MessageTypeFilter.file, (q) {
          return q.messageTypeEqualTo(MessageType.file);
        })
        .optional(params.messageType == MessageTypeFilter.admin, (q) {
          return q.messageTypeEqualTo(MessageType.admin);
        })

        // customTypes
        .optional(params.customTypes != null, (q) {
          return q.group((groupQ) {
            late QueryBuilder<CChannelMessage, CChannelMessage,
                QAfterFilterCondition> qb;
            bool isFirst = true;
            for (final customType in params.customTypes!) {
              if (isFirst) {
                qb = groupQ.customTypeEqualTo(customType);
                isFirst = false;
              } else {
                qb = qb.or().customTypeEqualTo(customType);
              }
            }
            return qb;
          });
        })

        // senderIds
        .optional(params.senderIds != null, (q) {
          return q.group((groupQ) {
            late QueryBuilder<CChannelMessage, CChannelMessage,
                QAfterFilterCondition> qb;
            bool isFirst = true;
            for (final senderId in params.senderIds!) {
              if (isFirst) {
                qb = groupQ.senderIdEqualTo(senderId);
                isFirst = false;
              } else {
                qb = qb.or().senderIdEqualTo(senderId);
              }
            }
            return qb;
          });
        })

        // isPrevious & reverse
        .optional(isPrevious, (q) {
          return q.sortByCreatedAtDesc();
        })
        .optional(isPrevious == false, (q) {
          return q.thenByCreatedAt();
        })

        // previousResultSize & params.nextResultSize
        .limit(isPrevious ? params.previousResultSize : params.nextResultSize)
        .findAll();

    List<RootMessage> messages = [];
    for (final cChannelMessage in cChannelMessages) {
      final message = await cChannelMessage.toChannelMessage(chat, isar);
      if (message != null) {
        messages.add(message.message);
      }
    }

    // reversed
    if (messages.length >= 2) {
      if ((isPrevious && !params.reverse) || (!isPrevious && params.reverse)) {
        messages = messages.reversed.toList();
      }
    }

    return messages;
  }

  static Future<List<BaseMessage>> getPendingMessages(
    Chat chat,
    Isar isar,
    ChannelType channelType,
    String channelUrl,
  ) async {
    final cChannelMessages = await isar.cChannelMessages
        .where()
        .channelTypeChannelUrlEqualTo(channelType, channelUrl)
        .filter()
        .sendingStatusEqualTo(SendingStatus.pending)
        .sortByCreatedAt()
        .findAll();

    List<BaseMessage> messages = [];
    for (final cChannelMessage in cChannelMessages) {
      final message = await cChannelMessage.toChannelMessage(chat, isar);
      if (message != null && message.message is BaseMessage) {
        messages.add(message.message as BaseMessage);
      }
    }

    return messages;
  }

  static Future<List<BaseMessage>> getFailedMessages(
    Chat chat,
    Isar isar,
    ChannelType channelType,
    String channelUrl,
    bool reverse,
  ) async {
    final cChannelMessages = await isar.cChannelMessages
        .where()
        .channelTypeChannelUrlEqualTo(channelType, channelUrl)
        .filter()
        .sendingStatusEqualTo(SendingStatus.failed)
        .optional(!reverse, (q) => q.sortByCreatedAt())
        .optional(reverse, (q) => q.thenByCreatedAtDesc())
        .findAll();

    List<BaseMessage> messages = [];
    for (final cChannelMessage in cChannelMessages) {
      final message = await cChannelMessage.toChannelMessage(chat, isar);
      if (message != null && message.message is BaseMessage) {
        messages.add(message.message as BaseMessage);
      }
    }

    return messages;
  }

  static Future<void> removeFailedMessages(
    Chat chat,
    Isar isar,
    ChannelType channelType,
    String channelUrl,
    List<BaseMessage> messages,
  ) async {
    await chat.dbManager.write(() async {
      // ChannelMessage
      await isar.cChannelMessages.deleteAllByRootId(messages
          .where((message) => message.sendingStatus == SendingStatus.failed)
          .map((message) => message.rootId)
          .toList());

      // UserMessage
      await isar.cUserMessages.deleteAllByRootId(messages
          .where((message) => message.sendingStatus == SendingStatus.failed)
          .map((message) => message.rootId)
          .toList());

      // FileMessage
      await isar.cFileMessages.deleteAllByRootId(messages
          .where((message) => message.sendingStatus == SendingStatus.failed)
          .map((message) => message.rootId)
          .toList());
    });
  }

  static Future<void> removeAllFailedMessages(
    Chat chat,
    Isar isar,
    ChannelType channelType,
    String channelUrl,
  ) async {
    await chat.dbManager.write(() async {
      // ChannelMessage
      await isar.cChannelMessages
          .where()
          .channelTypeChannelUrlEqualTo(channelType, channelUrl)
          .filter()
          .sendingStatusEqualTo(SendingStatus.failed)
          .deleteAll();

      // UserMessage
      await isar.cUserMessages
          .where()
          .channelTypeChannelUrlEqualTo(channelType, channelUrl)
          .filter()
          .sendingStatusEqualTo(SendingStatus.failed)
          .deleteAll();

      // FileMessage
      await isar.cFileMessages
          .where()
          .channelTypeChannelUrlEqualTo(channelType, channelUrl)
          .filter()
          .sendingStatusEqualTo(SendingStatus.failed)
          .deleteAll();
    });
  }

  static Future<void> removeAllPendingMessages(
    Chat chat,
    Isar isar,
    ChannelType channelType,
    String channelUrl,
  ) async {
    await chat.dbManager.write(() async {
      // ChannelMessage
      await isar.cChannelMessages
          .where()
          .channelTypeChannelUrlEqualTo(channelType, channelUrl)
          .filter()
          .sendingStatusEqualTo(SendingStatus.pending)
          .deleteAll();

      // UserMessage
      await isar.cUserMessages
          .where()
          .channelTypeChannelUrlEqualTo(channelType, channelUrl)
          .filter()
          .sendingStatusEqualTo(SendingStatus.pending)
          .deleteAll();

      // FileMessage
      await isar.cFileMessages
          .where()
          .channelTypeChannelUrlEqualTo(channelType, channelUrl)
          .filter()
          .sendingStatusEqualTo(SendingStatus.pending)
          .deleteAll();
    });
  }

  static Future<List<RootMessage>> getStartingPointMessages(
    Chat chat,
    Isar isar,
    ChannelType channelType,
    String channelUrl,
    int timestamp,
  ) async {
    // [includeMetaArray]
    // When calling API, this value have to be `true` to make chunk.

    // [includeReactions]
    // When calling API, this value have to be `true` to make chunk.

    // [includeThreadInfo]
    // When calling API, this value have to be `true` to make chunk.

    // [includeParentMessageInfo]
    // When calling API, this value have to be `true` to make chunk.

    // [replyType]
    // Must call API, because this can not be queried with local cache.

    // [showSubChannelMessagesOnly]
    // Must call API, because this can not be queried with local cache.

    final cChannelMessages = await isar.cChannelMessages
        .where()

        // channelType & channelUrl & reverse
        .channelTypeChannelUrlEqualTo(channelType, channelUrl)
        .filter()

        // timestamp
        .createdAtEqualTo(timestamp)

        // no limit
        .findAll();

    List<RootMessage> messages = [];
    for (final cChannelMessage in cChannelMessages) {
      final message = await cChannelMessage.toChannelMessage(chat, isar);
      if (message != null) {
        messages.add(message.message);
      }
    }

    return messages;
  }

  static Future<void> delete(Chat chat, Isar isar, String rootId) async {
    await chat.dbManager.write(() async {
      await isar.cChannelMessages.deleteByRootId(rootId);
    });
  }
}
