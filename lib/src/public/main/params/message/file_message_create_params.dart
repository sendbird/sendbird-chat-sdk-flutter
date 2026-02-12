// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:mime/mime.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:universal_io/io.dart';

/// Represents a file message params.
class FileMessageCreateParams extends BaseMessageCreateParams {
  /// The file info.
  late FileInfo fileInfo;

  /// The file's thumbnail sizes of the messages. Defaults to null.
  List<Size>? thumbnailSizes;

  /// The message text.
  /// @since 4.9.0
  String? message;

  /// withFile
  FileMessageCreateParams.withFile(
    File file, {
    String? fileName,
    String? data,
    String? customType,
    MentionType? mentionType,
    List<String>? mentionedUserIds,
    List<MessageMetaArray>? metaArrays,
    int? parentMessageId,
    bool? replyToChannel,
    PushNotificationDeliveryOption pushNotificationDeliveryOption =
        PushNotificationDeliveryOption.normal,
    bool isPinnedMessage = false,
    this.message,
  }) : super(
          data: data,
          customType: customType,
          mentionType: mentionType ?? MentionType.users,
          mentionedUserIds: mentionedUserIds,
          metaArrays: metaArrays,
          parentMessageId: parentMessageId,
          replyToChannel: replyToChannel ?? false,
          pushNotificationDeliveryOption: pushNotificationDeliveryOption,
          isPinnedMessage: isPinnedMessage,
        ) {
    fileInfo = createFileInfoFromFile(
      file: file,
      fileName: fileName,
    );
  }

  static FileInfo createFileInfoFromFile({
    required File file,
    String? fileName,
  }) {
    if (kIsWeb) {
      sbLog.e(StackTrace.current,
          'FileMessageCreateParams.withFile() is not supported for web');
      throw SendbirdException(
          message: 'FileMessageParams.withFile() is not supported for web');
    }

    String? fileMimeType;
    if (lookupMimeType(file.path) == null) {
      switch (getFileExtension(file.path)) {
        case '.HEIC':
          fileMimeType = 'image/heic';
          break;
        case '.HEIF':
          fileMimeType = 'image/heif';
          break;
        default:
          sbLog.w(StackTrace.current, 'Unknown file mimeType');
          break;
      }
    } else {
      fileMimeType = lookupMimeType(file.path);
    }

    return FileInfo.fromFile(
      fileName: fileName ?? 'file',
      file: file,
      mimeType: fileMimeType ?? 'application/octet-stream',
    );
  }

  /// withFileBytes
  FileMessageCreateParams.withFileBytes(
    Uint8List fileBytes, {
    String? fileName,
    String? mimeType,
    String? data,
    String? customType,
    MentionType? mentionType,
    List<String>? mentionedUserIds,
    List<MessageMetaArray>? metaArrays,
    int? parentMessageId,
    bool? replyToChannel,
    PushNotificationDeliveryOption pushNotificationDeliveryOption =
        PushNotificationDeliveryOption.normal,
    bool isPinnedMessage = false,
    this.message,
  }) : super(
          data: data,
          customType: customType,
          mentionType: mentionType ?? MentionType.users,
          mentionedUserIds: mentionedUserIds,
          metaArrays: metaArrays,
          parentMessageId: parentMessageId,
          replyToChannel: replyToChannel ?? false,
          pushNotificationDeliveryOption: pushNotificationDeliveryOption,
          isPinnedMessage: isPinnedMessage,
        ) {
    fileInfo = createFileInfoFromFileBytes(
      fileBytes: fileBytes,
      fileName: fileName,
      mimeType: mimeType,
    );
  }

  static FileInfo createFileInfoFromFileBytes({
    required Uint8List fileBytes,
    String? fileName,
    String? mimeType,
  }) {
    final fileMimeType = lookupMimeType('', headerBytes: fileBytes);

    if (fileMimeType != null) {
      mimeType = fileMimeType;
    } else if (mimeType == null) {
      sbLog.w(StackTrace.current, 'Unknown file mimeType');
    }

    return FileInfo.fromFileBytes(
      fileBytes: fileBytes,
      fileName: fileName ?? 'file',
      mimeType: mimeType ?? 'application/octet-stream',
    );
  }

  /// withFileUrl
  FileMessageCreateParams.withFileUrl(
    String fileUrl, {
    String? fileName,
    String? mimeType,
    int? fileSize,
    String? data,
    String? customType,
    MentionType? mentionType,
    List<String>? mentionedUserIds,
    List<MessageMetaArray>? metaArrays,
    int? parentMessageId,
    bool? replyToChannel,
    PushNotificationDeliveryOption pushNotificationDeliveryOption =
        PushNotificationDeliveryOption.normal,
    bool isPinnedMessage = false,
    this.message,
  })  : fileInfo = createFileInfoFromFileUrl(
          fileName: fileName ?? 'file',
          mimeType: mimeType ?? 'application/octet-stream',
          fileUrl: fileUrl,
          fileSize: fileSize,
        ),
        super(
          data: data,
          customType: customType,
          pushNotificationDeliveryOption: pushNotificationDeliveryOption,
          metaArrays: metaArrays,
          mentionType: mentionType ?? MentionType.users,
          mentionedUserIds: mentionedUserIds,
          parentMessageId: parentMessageId,
          replyToChannel: replyToChannel ?? false,
          isPinnedMessage: isPinnedMessage,
        );

  static FileInfo createFileInfoFromFileUrl({
    required String fileUrl,
    String? fileName,
    String? mimeType,
    int? fileSize,
  }) {
    return FileInfo.fromFileUrl(
      fileName: fileName ?? 'file',
      mimeType: mimeType ?? 'application/octet-stream',
      fileUrl: fileUrl,
      fileSize: fileSize,
    );
  }

  /// withMessage
  FileMessageCreateParams.withMessage(FileMessage fileMessage)
      : super.withMessage(fileMessage) {
    message = fileMessage.message;

    if (fileMessage.url.isNotEmpty) {
      fileInfo = FileInfo.fromFileUrl(
        fileUrl: fileMessage.url,
        mimeType: fileMessage.type,
      );
    } else if (fileMessage.file != null) {
      fileInfo = FileInfo.fromFile(
        file: fileMessage.file,
        fileName: fileMessage.name,
        mimeType: fileMessage.type,
      );
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final ret = super.toJson();
    ret['url'] = fileInfo.fileUrl;
    ret['name'] = fileInfo.fileName;
    ret['size'] = fileInfo.fileSize;
    ret['type'] = fileInfo.mimeType;
    ret['message'] = message;

    ret.removeWhere((key, value) => value == null);
    return ret;
  }
}
