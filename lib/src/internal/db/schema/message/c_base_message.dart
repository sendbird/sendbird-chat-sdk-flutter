// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_admin_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_file_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_root_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_user_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/user/c_sender.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/user/c_user.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/admin_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/file_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/user_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/info/scheduled_info.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/og/og_image.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/og/og_meta_data.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/reaction/reaction.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/thread/thread_info.dart';

part 'c_base_message.g.dart';

class CBaseMessage extends CRootMessage {
  late int messageId;
  String? requestId;
  late String message;

  @enumerated
  late SendingStatus sendingStatus;

  late bool isReplyToChannel;
  int? parentMessageId;

  @enumerated
  late MessageType parentMessageType; // parentMessage
  String? parentMessageRootId; // parentMessage

  CThreadInfo? threadInfo;
  int? messageSurvivalSeconds;
  late bool isSilent;
  int? errorCode;
  late bool isOperatorMessage;
  COGMetaData? ogMetaData;
  List<CReaction>? reactions;
  CScheduledInfo? scheduledInfo;
  CSender? sender;

  CBaseMessage();

  factory CBaseMessage.fromBaseMessage(BaseMessage message) {
    return CBaseMessage()..setBaseMessage(message);
  }

  void setBaseMessage(BaseMessage baseMessage) {
    setRootMessage(baseMessage);

    messageId = baseMessage.messageId;
    requestId = baseMessage.requestId;
    message = baseMessage.message;
    sendingStatus = baseMessage.sendingStatus ?? SendingStatus.none;
    isReplyToChannel = baseMessage.isReplyToChannel;
    parentMessageId = baseMessage.parentMessageId;
    parentMessageType = baseMessage.messageType;
    parentMessageRootId = parentMessageId?.toString();
    threadInfo = baseMessage.threadInfo != null
        ? CThreadInfo.fromThreadInfo(baseMessage.threadInfo!)
        : null;
    messageSurvivalSeconds = baseMessage.messageSurvivalSeconds;
    isSilent = baseMessage.isSilent;
    errorCode = baseMessage.errorCode;
    isOperatorMessage = baseMessage.isOperatorMessage;
    ogMetaData = baseMessage.ogMetaData != null
        ? COGMetaData.fromOGMetaData(baseMessage.ogMetaData!)
        : null;
    reactions = baseMessage.reactions != null
        ? baseMessage.reactions!
            .map((reaction) => CReaction.fromReaction(reaction))
            .toList()
        : null;
    scheduledInfo = baseMessage.scheduledInfo != null
        ? CScheduledInfo.fromScheduledInfo(baseMessage.scheduledInfo!)
        : null;
    sender = baseMessage.sender != null
        ? CSender.fromSender(baseMessage.sender!)
        : null;
  }

  Future<BaseMessage> toBaseMessage(Chat chat, Isar isar) async {
    final baseMessage = BaseMessage(
      // RootMessage
      channelUrl: channelUrl,
      channelType: channelType,
      // BaseMessage
      message: message,
      sendingStatus: sendingStatus,
    )..set(chat);
    return await setCBaseMessage(chat, isar, baseMessage, this);
  }

  static Future<BaseMessage> setCBaseMessage(
    Chat chat,
    Isar isar,
    BaseMessage baseMessage,
    CBaseMessage cBaseMessage,
  ) async {
    await CRootMessage.setCRootMessage(chat, isar, baseMessage, cBaseMessage);

    baseMessage
      ..messageId = cBaseMessage.messageId
      ..requestId = cBaseMessage.requestId
      ..sendingStatus = cBaseMessage.sendingStatus
      ..isReplyToChannel = cBaseMessage.isReplyToChannel
      ..parentMessageId = cBaseMessage.parentMessageId
      ..parentMessage = await getMessage(chat, isar,
          cBaseMessage.parentMessageType, cBaseMessage.parentMessageRootId)
      ..threadInfo = await cBaseMessage.threadInfo?.toThreadInfo(chat, isar)
      ..messageSurvivalSeconds = cBaseMessage.messageSurvivalSeconds
      ..isSilent = cBaseMessage.isSilent
      ..errorCode = cBaseMessage.errorCode
      ..isOperatorMessage = cBaseMessage.isOperatorMessage
      ..ogMetaData = cBaseMessage.ogMetaData?.toOGMetaData()
      ..reactions = cBaseMessage.reactions
          ?.map((reaction) => reaction.toReaction())
          .toList()
      ..scheduledInfo = cBaseMessage.scheduledInfo?.toScheduledInfo()
      ..sender = cBaseMessage.sender != null
          ? await cBaseMessage.sender?.toSender(chat, isar)
          : null;

    for (final userId in cBaseMessage.mentionedUsers) {
      final user = await CUser.get(chat, isar, userId);
      if (user != null) {
        baseMessage.mentionedUsers.add(user);
      }
    }
    return baseMessage;
  }

  static Future<BaseMessage?> getMessage(
    Chat chat,
    Isar isar,
    MessageType? messageType,
    String? rootId,
  ) async {
    if (messageType == null || rootId == null) return null;

    BaseMessage? message;
    if (messageType == MessageType.user) {
      message = await CUserMessage.get(chat, isar, rootId);
    } else if (messageType == MessageType.file) {
      message = await CFileMessage.get(chat, isar, rootId);
    } else if (messageType == MessageType.admin) {
      message = await CAdminMessage.get(chat, isar, rootId);
    }
    return message;
  }

  static Future<void> upsert(Chat chat, Isar isar, BaseMessage message) async {
    // BaseMessage
    await chat.dbManager.write(() async {
      if (message is UserMessage) {
        await isar.cUserMessages.put(CUserMessage.fromUserMessage(message));
      } else if (message is FileMessage) {
        await isar.cFileMessages.put(CFileMessage.fromFileMessage(message));
      } else if (message is AdminMessage) {
        await isar.cAdminMessages.put(CAdminMessage.fromAdminMessage(message));
      }

      // parentMessage
      if (message.parentMessage != null) {
        await CBaseMessage.upsert(chat, isar, message.parentMessage!);
      }

      // threadInfo
      if (message.threadInfo != null) {
        for (final user in message.threadInfo!.mostRepliesUsers) {
          await isar.cUsers.put(CUser.fromUser(user));
        }
      }

      // sender
      if (message.sender != null) {
        await isar.cUsers.put(CUser.fromUser(message.sender!));
      }
    });
  }
}

@embedded
class CThreadInfo {
  late int replyCount;
  late List<String> mostRepliesUsers; // List<CUser>
  late int lastRepliedAt;

  // Internal
  int? updatedAt;

  CThreadInfo();

  factory CThreadInfo.fromThreadInfo(ThreadInfo info) {
    return CThreadInfo()
      ..replyCount = info.replyCount
      ..mostRepliesUsers =
          info.mostRepliesUsers.map((user) => user.userId).toList()
      ..lastRepliedAt = info.lastRepliedAt
      ..updatedAt = info.updatedAt;
  }

  Future<ThreadInfo> toThreadInfo(Chat chat, Isar isar) async {
    final threadInfo = ThreadInfo()
      ..replyCount = replyCount
      ..lastRepliedAt = lastRepliedAt
      ..updatedAt = updatedAt;

    for (final userId in mostRepliesUsers) {
      final user = await CUser.get(chat, isar, userId);
      if (user != null) {
        threadInfo.mostRepliesUsers.add(user);
      }
    }

    return threadInfo;
  }
}

@embedded
class COGMetaData {
  String? title;
  String? url;
  String? description;
  COGImage? ogImage;

  COGMetaData();

  factory COGMetaData.fromOGMetaData(OGMetaData data) {
    return COGMetaData()
      ..title = data.title
      ..url = data.url
      ..description = data.description
      ..ogImage =
          data.ogImage != null ? COGImage.fromOGImage(data.ogImage!) : null;
  }

  OGMetaData toOGMetaData() {
    return OGMetaData()
      ..title = title
      ..url = url
      ..description = description
      ..ogImage = ogImage?.toOGImage();
  }
}

@embedded
class COGImage {
  String? url;
  String? secureUrl;
  String? type;
  String? alt;
  late int width;
  late int height;

  COGImage();

  factory COGImage.fromOGImage(OGImage image) {
    return COGImage()
      ..url = image.url
      ..secureUrl = image.secureUrl
      ..type = image.type
      ..alt = image.alt
      ..width = image.width
      ..height = image.height;
  }

  OGImage toOGImage() {
    return OGImage()
      ..url = url
      ..secureUrl = secureUrl
      ..type = type
      ..alt = alt
      ..width = width
      ..height = height;
  }
}

@embedded
class CReaction {
  late String key;
  late List<String> userIds;
  late int updatedAt;

  // Internal
  late String updatedAts; // Map<String, int>

  CReaction();

  factory CReaction.fromReaction(Reaction reaction) {
    return CReaction()
      ..key = reaction.key
      ..userIds = reaction.userIds
      ..updatedAt = reaction.updatedAt
      ..updatedAts = jsonEncode(reaction.updatedAts);
  }

  Reaction toReaction() {
    return Reaction(key: key, userIds: userIds, updatedAt: updatedAt)
      ..updatedAts = (jsonDecode(updatedAts) as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, int.parse(value)));
  }
}

@embedded
class CScheduledInfo {
  late int scheduledMessageId;
  late int scheduledAt;

  @enumerated
  late ScheduledStatus scheduledStatus;

  CScheduledInfo();

  factory CScheduledInfo.fromScheduledInfo(ScheduledInfo info) {
    return CScheduledInfo()
      ..scheduledMessageId = info.scheduledMessageId
      ..scheduledAt = info.scheduledAt
      ..scheduledStatus = info.scheduledStatus;
  }

  ScheduledInfo toScheduledInfo() {
    return ScheduledInfo(
      scheduledMessageId: scheduledMessageId,
      scheduledAt: scheduledAt,
      scheduledStatus: scheduledStatus,
    );
  }
}
