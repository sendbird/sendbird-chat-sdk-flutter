// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:io';
import 'dart:ui';

import 'package:isar/isar.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_base_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_root_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/meta/c_channel_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/user/c_sender.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/file_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/info/file_info.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/file_message_create_params.dart';

part 'c_file_message.g.dart';

@collection
class CFileMessage extends CBaseMessage {
  late String url;
  String? name;
  int? size;
  String? type;
  List<CThumbnail>? thumbnails;
  CFileMessageCreateParams? messageCreateParams;
  late bool requireAuth;

  CFileMessage();

  factory CFileMessage.fromFileMessage(FileMessage message) {
    return CFileMessage()
      // BaseMessage
      ..setBaseMessage(message)
      // FileMessage
      ..url = message.url
      ..name = message.name
      ..size = message.size
      ..type = message.type
      ..thumbnails = message.thumbnails
          ?.map((thumbnail) => CThumbnail.fromThumbnail(thumbnail))
          .toList()
      ..messageCreateParams = message.messageCreateParams != null
          ? CFileMessageCreateParams.fromFileMessageCreateParams(
              message.messageCreateParams!)
          : null
      ..requireAuth = message.requireAuth;
  }

  Future<FileMessage> toFileMessage(Chat chat, Isar isar) async {
    final fileMessage = FileMessage(
      // RootMessage
      channelUrl: channelUrl,
      channelType: channelType,
      // BaseMessage
      messageId: messageId,
      // FileMessage
      url: url,
    )..set(chat);
    return await CBaseMessage.setCBaseMessage(chat, isar, fileMessage, this)
        as FileMessage
      // FileMessage
      ..name = name
      ..size = size
      ..type = type
      ..thumbnails =
          thumbnails?.map((cThumbnail) => cThumbnail.toThumbnail()).toList()
      ..messageCreateParams = messageCreateParams?.toFileMessageCreateParams()
      ..requireAuth = requireAuth;
  }

  static Future<CFileMessage> upsert(
      Chat chat, Isar isar, FileMessage message) async {
    final cFileMessage = CFileMessage.fromFileMessage(message);

    // RootMessage
    await CRootMessage.upsert(chat, isar, message);

    // BaseMessage
    await CBaseMessage.upsert(chat, isar, message);

    // FileMessage
    await chat.dbManager.write(() async {
      await isar.cFileMessages.put(cFileMessage);
    });

    // ChannelMessage
    await CChannelMessage.upsert(chat, isar, message);

    return cFileMessage;
  }

  static Future<FileMessage?> get(Chat chat, Isar isar, String rootId) async {
    final cFileMessage =
        await isar.cFileMessages.where().rootIdEqualTo(rootId).findFirst();
    return await cFileMessage?.toFileMessage(chat, isar);
  }

  static Future<void> delete(Chat chat, Isar isar, String rootId) async {
    // FileMessage
    await chat.dbManager.write(() async {
      await isar.cFileMessages.deleteByRootId(rootId);
    });

    // ChannelMessage
    await CChannelMessage.delete(chat, isar, rootId);
  }
}

@embedded
class CThumbnail {
  late String url;
  String? plainUrl;
  double? height;
  double? width;
  double? realHeight;
  double? realWidth;

  CThumbnail();

  factory CThumbnail.fromThumbnail(Thumbnail thumbnail) {
    return CThumbnail()
      ..url = thumbnail.url
      ..plainUrl = thumbnail.plainUrl
      ..height = thumbnail.height
      ..width = thumbnail.width
      ..realHeight = thumbnail.realHeight
      ..realWidth = thumbnail.realWidth;
  }

  Thumbnail toThumbnail() {
    return Thumbnail(
      url,
      plainUrl,
      height,
      width,
      realHeight,
      realWidth,
    );
  }
}

@embedded
class CFileMessageCreateParams {
  // BaseMessageCreateParams
  String? data;
  String? customType;

  @enumerated
  late MentionType mentionType;

  List<String>? mentionedUserIds;
  List<CMessageMetaArray>? metaArrays;
  int? parentMessageId;
  late bool replyToChannel;

  @enumerated
  late PushNotificationDeliveryOption pushNotificationDeliveryOption;

  late bool isPinnedMessage;

  // FileMessageCreateParams
  late CFileInfo fileInfo;
  List<CSize>? thumbnailSizes;

  CFileMessageCreateParams();

  factory CFileMessageCreateParams.fromFileMessageCreateParams(
      FileMessageCreateParams params) {
    return CFileMessageCreateParams()
      // BaseMessageCreateParams
      ..data = params.data
      ..customType = params.customType
      ..mentionType = params.mentionType
      ..mentionedUserIds = params.mentionedUserIds
      ..metaArrays = params.metaArrays
          ?.map(
              (metaArray) => CMessageMetaArray.fromMessageMetaArray(metaArray))
          .toList()
      ..parentMessageId = params.parentMessageId
      ..replyToChannel = params.replyToChannel
      ..pushNotificationDeliveryOption = params.pushNotificationDeliveryOption
      ..isPinnedMessage = params.isPinnedMessage

      // FileMessageCreateParams
      ..fileInfo = CFileInfo.fromFileInfo(params.fileInfo)
      ..thumbnailSizes = params.thumbnailSizes
          ?.map((thumbnailSize) => CSize.fromSize(thumbnailSize))
          .toList();
  }

  FileMessageCreateParams? toFileMessageCreateParams() {
    // withFileBytes() is not supported.
    if (fileInfo.fileUrl != null && fileInfo.fileUrl!.isNotEmpty) {
      return FileMessageCreateParams.withFileUrl(
        // FileMessageCreateParams
        fileInfo.fileUrl ?? '',
        fileName: fileInfo.fileName,
        mimeType: fileInfo.mimeType,
        fileSize: fileInfo.fileSize,

        // BaseMessageCreateParams
        data: data,
        customType: customType,
        mentionType: mentionType,
        mentionedUserIds: mentionedUserIds,
        metaArrays: metaArrays != null
            ? metaArrays!
                .map((metaArray) => metaArray.toMessageMetaArray())
                .toList()
            : null,
        parentMessageId: parentMessageId,
        replyToChannel: replyToChannel,
        pushNotificationDeliveryOption: pushNotificationDeliveryOption,
        isPinnedMessage: isPinnedMessage,
      );
    }
    if (fileInfo.localFilePath != null && fileInfo.localFilePath!.isNotEmpty) {
      return FileMessageCreateParams.withFile(
        // FileMessageCreateParams
        File(fileInfo.localFilePath!),
        fileName: fileInfo.fileName,

        // BaseMessageCreateParams
        data: data,
        customType: customType,
        mentionType: mentionType,
        mentionedUserIds: mentionedUserIds,
        metaArrays: metaArrays != null
            ? metaArrays!
                .map((metaArray) => metaArray.toMessageMetaArray())
                .toList()
            : null,
        parentMessageId: parentMessageId,
        replyToChannel: replyToChannel,
        pushNotificationDeliveryOption: pushNotificationDeliveryOption,
        isPinnedMessage: isPinnedMessage,
      );
    }
    return null;
  }
}

@embedded
class CFileInfo {
  // Uint8List? fileBytes; // Not supported
  String? fileUrl;
  String? fileName;
  String? mimeType;
  int? fileSize;
  String? localFilePath; // Added for File support

  CFileInfo();

  factory CFileInfo.fromFileInfo(FileInfo info) {
    final fileInfo = CFileInfo()
      ..fileUrl = info.fileUrl
      ..fileName = info.fileName
      ..mimeType = info.mimeType
      ..fileSize = info.fileSize;
    if (info.file != null) {
      fileInfo.localFilePath = info.file!.path;
    }
    return fileInfo;
  }

  FileInfo? toFileInfo() {
    if (fileUrl != null && fileUrl!.isNotEmpty) {
      return FileInfo.fromFileUrl(
        fileUrl: fileUrl,
        fileName: fileName,
        mimeType: mimeType,
        fileSize: fileSize,
      );
    }
    if (localFilePath != null && localFilePath!.isNotEmpty) {
      return FileInfo.fromFile(
        file: File(localFilePath!),
        fileName: fileName,
        mimeType: mimeType,
      );
    }
    return null;
  }
}

@embedded
class CSize {
  late double width;
  late double height;

  CSize();

  factory CSize.fromSize(Size size) {
    return CSize()
      ..width = size.width
      ..height = size.height;
  }

  Size? toSize() {
    return Size(width, height);
  }
}
