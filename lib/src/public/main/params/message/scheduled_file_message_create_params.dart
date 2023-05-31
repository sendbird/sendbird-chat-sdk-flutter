// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:mime/mime.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/info/file_info.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/apple_critical_alert_options.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/message_meta_array.dart';
import 'package:universal_io/io.dart';

/// Represents a scheduled file message params.
class ScheduledFileMessageCreateParams {
  /// The schedule time to send the message, in Unix milliseconds format.
  /// The messages are scheduled in minutes, and values less than minutes are discarded.
  /// The term between current time and scheduledAt should be between 5 minutes (depending on the app attribute `minimum_interval_for_scheduling`) and 30 days
  final int scheduledAt;

  /// The file info.
  late FileInfo fileInfo;

  /// The file name of the file of the message. Defaults to null.
  String? fileName;

  /// The file size of the file of the message. Defaults to null.
  int? fileSize;

  /// The thumbnail sizes the file's thumbnail of the message. Defaults to null.
  String? mimeType;

  /// The thumbnail sizes the file's thumbnail of the message. Defaults to null.
  List<Size>? thumbnailSizes;

  /// The custom type of the message.
  String? customType;

  /// The data of the message.
  String? data;

  /// The mention type of the message. Defaults to [MentionType.users].
  final MentionType mentionType;

  /// The mentioned user ids of the message. Defaults to null.
  List<String>? mentionedUserIds;

  /// Meta arrays of the message. Defaults to null.
  List<MessageMetaArray>? metaArrays;

  /// The apple critical alert options of the message. Defaults to null.
  AppleCriticalAlertOptions? appleCriticalAlertOptions;

  /// The push notification delivery option of the message. Defaults to null.
  final PushNotificationDeliveryOption pushNotificationDeliveryOption;

  /// withFile
  ScheduledFileMessageCreateParams.withFile(
    File file, {
    required this.scheduledAt,
    this.fileName,
    this.customType,
    this.data,
    this.mentionType = MentionType.users,
    this.metaArrays,
    this.appleCriticalAlertOptions,
    this.pushNotificationDeliveryOption = PushNotificationDeliveryOption.normal,
  }) {
    if (kIsWeb) {
      sbLog.e(StackTrace.current,
          "`ScheduledFileMessageCreateParams.withFile()` is not supported for web.");
      throw SendbirdException(
          message:
              "`ScheduledFileMessageCreateParams.withFile()` is not supported for web.");
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
  ScheduledFileMessageCreateParams.withFileBytes(
    Uint8List fileBytes, {
    required this.scheduledAt,
    this.fileName,
    this.customType,
    this.data,
    this.mentionType = MentionType.users,
    this.metaArrays,
    this.appleCriticalAlertOptions,
    this.pushNotificationDeliveryOption = PushNotificationDeliveryOption.normal,
  }) {
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
  ScheduledFileMessageCreateParams.withFileUrl(
    String fileUrl, {
    this.mimeType,
    this.fileSize,
    this.fileName,
    this.data,
    required this.scheduledAt,
    this.customType,
    this.metaArrays,
    this.appleCriticalAlertOptions,
    this.pushNotificationDeliveryOption = PushNotificationDeliveryOption.normal,
    this.mentionType = MentionType.users,
  }) : fileInfo = FileInfo.fromFileUrl(
          fileName: fileName ?? 'image',
          mimeType: mimeType ?? 'image/jpeg',
          fileUrl: fileUrl,
          fileSize: fileSize,
        );

  Map<String, dynamic> toJson() {
    final ret = <String, dynamic>{
      'file': fileInfo, // Check
      'url': fileInfo.fileUrl,
      'file_name': fileInfo.fileName,
      'file_size': fileInfo.fileSize,
      'file_type': fileInfo.mimeType,
      'thumbnails': thumbnailSizes,
      'scheduled_at': scheduledAt,
      'custom_type': customType,
      'data': data,
      'mention_type': mentionType.toString().split('.').last,
      'mentionedUserIds': mentionedUserIds,
      'sorted_metaarray': metaArrays,
      'name': appleCriticalAlertOptions?.name,
      'volume': appleCriticalAlertOptions?.volume,
      'push_option': pushNotificationDeliveryOption.toString().split('.').last,
    };
    ret.removeWhere((key, value) => value == null);
    return ret;
  }
}
