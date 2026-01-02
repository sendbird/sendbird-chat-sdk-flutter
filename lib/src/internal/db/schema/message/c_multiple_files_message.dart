// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:io';

import 'package:isar_community/isar.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_base_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_file_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_root_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/meta/c_channel_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/user/c_sender.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';

part 'c_multiple_files_message.g.dart';

@collection
class CMultipleFilesMessage extends CBaseMessage {
  late List<CUploadedFileInfo> files;
  CMultipleFilesMessageCreateParams? messageCreateParams;
  late bool requireAuth;

  CMultipleFilesMessage();

  factory CMultipleFilesMessage.fromMultipleFilesMessage(
      MultipleFilesMessage message) {
    return CMultipleFilesMessage()
      // BaseMessage
      ..setBaseMessage(message)
      // MultipleFilesMessage
      ..files = message.files
          .map((uploadedFileInfo) =>
              CUploadedFileInfo.fromUploadedFileInfo(uploadedFileInfo))
          .toList()
      ..messageCreateParams = message.messageCreateParams != null
          ? CMultipleFilesMessageCreateParams
              .fromMultipleFilesMessageCreateParams(
                  message.messageCreateParams!)
          : null
      ..requireAuth = message.requireAuth;
  }

  Future<MultipleFilesMessage> toMultipleFilesMessage(
      Chat chat, Isar isar) async {
    List<UploadedFileInfo> uploadedFileInfos = [];
    for (final cUploadedFileInfo in files) {
      final uploadedFileInfo = cUploadedFileInfo.toUploadedFileInfo();
      if (uploadedFileInfo != null) {
        uploadedFileInfos.add(uploadedFileInfo);
      }
    }

    final multipleFilesMessage = MultipleFilesMessage(
      // RootMessage
      channelUrl: channelUrl,
      channelType: channelType,
      // BaseMessage
      messageId: messageId,
      // MultipleFilesMessage
      files: uploadedFileInfos,
    )..set(chat);

    return await CBaseMessage.setCBaseMessage(
        chat, isar, multipleFilesMessage, this) as MultipleFilesMessage
      // MultipleFilesMessage
      ..messageCreateParams =
          messageCreateParams?.toMultipleFilesMessageCreateParams()
      ..requireAuth = requireAuth;
  }

  static Future<CMultipleFilesMessage> upsert(
      Chat chat, Isar isar, MultipleFilesMessage message) async {
    final cMultipleFilesMessage =
        CMultipleFilesMessage.fromMultipleFilesMessage(message);

    // RootMessage
    await CRootMessage.upsert(chat, isar, message);

    // BaseMessage
    await CBaseMessage.upsert(chat, isar, message);

    // MultipleFilesMessage
    await chat.dbManager.write(() async {
      await isar.cMultipleFilesMessages.put(cMultipleFilesMessage);
    });

    // ChannelMessage
    await CChannelMessage.upsert(chat, isar, message);

    return cMultipleFilesMessage;
  }

  static Future<MultipleFilesMessage?> get(
      Chat chat, Isar isar, String rootId) async {
    final cMultipleFilesMessage = await isar.cMultipleFilesMessages
        .where()
        .rootIdEqualTo(rootId)
        .findFirst();
    return await cMultipleFilesMessage?.toMultipleFilesMessage(chat, isar);
  }

  static Future<void> delete(Chat chat, Isar isar, String rootId) async {
    // MultipleFilesMessage
    await chat.dbManager.write(() async {
      await isar.cMultipleFilesMessages.deleteByRootId(rootId);
    });

    // ChannelMessage
    await CChannelMessage.delete(chat, isar, rootId);
  }
}

@embedded
class CUploadedFileInfo {
  late String url;
  String? name;
  int? size;
  String? type;
  List<CThumbnail>? thumbnails;
  late bool requireAuth;

  CUploadedFileInfo();

  factory CUploadedFileInfo.fromUploadedFileInfo(UploadedFileInfo info) {
    final fileInfo = CUploadedFileInfo()
      ..url = info.url
      ..name = info.name
      ..size = info.size
      ..type = info.type
      ..thumbnails = info.thumbnails
          ?.map((thumbnail) => CThumbnail.fromThumbnail(thumbnail))
          .toList()
      ..requireAuth = info.requireAuth;
    return fileInfo;
  }

  UploadedFileInfo? toUploadedFileInfo() {
    if (url.isNotEmpty) {
      return UploadedFileInfo(
        url: url,
        name: name,
        size: size,
        type: type,
        thumbnails:
            thumbnails?.map((cThumbnail) => cThumbnail.toThumbnail()).toList(),
        requireAuth: requireAuth,
      )..chat = SendbirdChat().chat;
    }
    return null;
  }
}

@embedded
class CMultipleFilesMessageCreateParams {
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

  // MultipleFilesMessageCreateParams
  late List<CUploadableFileInfo> uploadableFileInfoList;

  CMultipleFilesMessageCreateParams();

  factory CMultipleFilesMessageCreateParams.fromMultipleFilesMessageCreateParams(
      MultipleFilesMessageCreateParams params) {
    final List<CUploadableFileInfo> cUploadableFileInfoList = [];
    for (final uploadableFileInfo in params.uploadableFileInfoList) {
      if (uploadableFileInfo != null) {
        cUploadableFileInfoList.add(
            CUploadableFileInfo.fromUploadableFileInfo(uploadableFileInfo));
      }
    }

    return CMultipleFilesMessageCreateParams()
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

      // MultipleFilesMessageCreateParams
      ..uploadableFileInfoList = cUploadableFileInfoList;
  }

  MultipleFilesMessageCreateParams? toMultipleFilesMessageCreateParams() {
    List<UploadableFileInfo> uploadableFileInfos = [];
    for (final cUploadableFileInfo in uploadableFileInfoList) {
      final uploadableFileInfo = cUploadableFileInfo.toUploadableFileInfo();
      if (uploadableFileInfo != null) {
        uploadableFileInfos.add(uploadableFileInfo);
      }
    }

    return MultipleFilesMessageCreateParams(
      uploadableFileInfos,
      // BaseMessageCreateParams
      data: data,
      customType: customType,
      mentionType: mentionType,
      mentionedUserIds: mentionedUserIds,
      metaArrays: metaArrays
          ?.map((metaArray) => metaArray.toMessageMetaArray())
          .toList(),
      parentMessageId: parentMessageId,
      replyToChannel: replyToChannel,
      pushNotificationDeliveryOption: pushNotificationDeliveryOption,
      isPinnedMessage: isPinnedMessage,
    );
  }
}

@embedded
class CUploadableFileInfo {
  late CFileInfo fileInfo;
  List<CSize>? thumbnailSizes;

  CUploadableFileInfo();

  factory CUploadableFileInfo.fromUploadableFileInfo(UploadableFileInfo info) {
    final fileInfo = CUploadableFileInfo()
      ..fileInfo = CFileInfo.fromFileInfo(info.fileInfo)
      ..thumbnailSizes = info.thumbnailSizes
          ?.map((thumbnailSize) => CSize.fromSize(thumbnailSize))
          .toList();
    return fileInfo;
  }

  UploadableFileInfo? toUploadableFileInfo() {
    if (fileInfo.fileUrl != null && fileInfo.fileUrl!.isNotEmpty) {
      return UploadableFileInfo.fromFileUrl(
        fileUrl: fileInfo.fileUrl!,
        fileName: fileInfo.fileName,
        mimeType: fileInfo.mimeType,
        fileSize: fileInfo.fileSize,
      );
    }
    if (fileInfo.localFilePath != null && fileInfo.localFilePath!.isNotEmpty) {
      return UploadableFileInfo.fromFile(
        file: File(fileInfo.localFilePath!),
        fileName: fileInfo.fileName,
      );
    }
    return null;
  }
}
