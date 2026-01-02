// Copyright (c) 2025 Sendbird, Inc. All rights reserved.

import 'dart:ui';

import '../../../../../../sendbird_chat_sdk.dart';

/// Represents the parameters for creating a multiple files message.
/// @since 4.8.0
class MultipleFilesMessageCreateParams extends BaseMessageCreateParams {
  List<UploadableFileInfo?> uploadableFileInfoList = [];

  MultipleFilesMessageCreateParams(
    List<UploadableFileInfo?> uploadableFileInfoList, {
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
    this.uploadableFileInfoList.addAll(uploadableFileInfoList);
  }

  /// withMessage
  MultipleFilesMessageCreateParams.withMessage(MultipleFilesMessage message)
      : super.withMessage(message) {
    for (final uploadedFileInfo in message.files) {
      FileInfo? fileInfo;

      if (uploadedFileInfo.file != null) {
        fileInfo = FileInfo.fromFile(
          file: uploadedFileInfo.file,
          fileName: uploadedFileInfo.name,
          mimeType: uploadedFileInfo.type,
        );
      } else if (uploadedFileInfo.url.isNotEmpty) {
        fileInfo = FileInfo.fromFileUrl(
          fileUrl: uploadedFileInfo.url,
          fileName: uploadedFileInfo.name,
          mimeType: uploadedFileInfo.type,
          fileSize: uploadedFileInfo.size,
        );
      }

      if (fileInfo != null) {
        List<Size> thumbnailSizes = [];
        if (uploadedFileInfo.thumbnails != null &&
            uploadedFileInfo.thumbnails!.isNotEmpty) {
          for (final thumbnail in uploadedFileInfo.thumbnails!) {
            if (thumbnail.width != null && thumbnail.height != null) {
              thumbnailSizes.add(Size(thumbnail.width!, thumbnail.height!));
            }
          }
        }

        uploadableFileInfoList.add(UploadableFileInfo(
          fileInfo: fileInfo,
          thumbnailSizes: thumbnailSizes,
        ));
      }
    }
  }
}
