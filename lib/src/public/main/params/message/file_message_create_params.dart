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
      fileMimeType = lookupMimeType(file.path)!;
    }

    fileInfo = FileInfo.fromFile(
      fileName: fileName ?? 'file',
      file: file,
      mimeType: fileMimeType,
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
    String? fileMimeType = lookupMimeType('', headerBytes: fileBytes);
    if (fileMimeType != null) {
      mimeType = fileMimeType;
    } else if (mimeType == null) {
      sbLog.w(StackTrace.current, 'Unknown file mimeType');
    }

    fileInfo = FileInfo.fromFileBytes(
      fileBytes: fileBytes,
      fileName: fileName ?? 'file',
      mimeType: mimeType,
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
  })  : fileInfo = FileInfo.fromFileUrl(
          fileName: fileName ?? 'image',
          mimeType: mimeType ?? 'image/jpeg',
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

  /// withMessage
  FileMessageCreateParams.withMessage(FileMessage fileMessage, {bool? deepCopy})
      : fileInfo = FileInfo.fromFileUrl(
          fileUrl: fileMessage.url,
          mimeType: fileMessage.type,
        ),
        super.withMessage(fileMessage, deepCopy: deepCopy);

  @override
  Map<String, dynamic> toJson() {
    final ret = super.toJson();
    ret['url'] = fileInfo.fileUrl;
    ret['name'] = fileInfo.fileName;
    ret['size'] = fileInfo.fileSize;
    ret['type'] = fileInfo.mimeType;

    ret.removeWhere((key, value) => value == null);
    return ret;
  }
}
