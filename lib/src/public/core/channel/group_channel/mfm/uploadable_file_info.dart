// Copyright (c) 2025 Sendbird, Inc. All rights reserved.

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

/// The uploadable file info.
/// @since 4.8.0
class UploadableFileInfo {
  late FileInfo fileInfo;
  List<Size>? thumbnailSizes;

  UploadableFileInfo({
    required this.fileInfo,
    this.thumbnailSizes,
  });

  /// fromFile
  UploadableFileInfo.fromFile({
    required File file,
    String? fileName,
    this.thumbnailSizes,
  }) {
    fileInfo = FileMessageCreateParams.createFileInfoFromFile(
      file: file,
      fileName: fileName,
    );
  }

  /// fromBytes for Web
  UploadableFileInfo.fromFileBytes({
    required Uint8List fileBytes,
    String? fileName,
    String? mimeType,
    this.thumbnailSizes,
  }) {
    fileInfo = FileMessageCreateParams.createFileInfoFromFileBytes(
      fileBytes: fileBytes,
      fileName: fileName,
      mimeType: mimeType,
    );
  }

  /// fromFileUrl
  UploadableFileInfo.fromFileUrl({
    required String fileUrl,
    String? fileName,
    String? mimeType,
    int? fileSize,
    this.thumbnailSizes,
  }) {
    fileInfo = FileMessageCreateParams.createFileInfoFromFileUrl(
      fileUrl: fileUrl,
      fileName: fileName,
      mimeType: mimeType,
      fileSize: fileSize,
    );
  }
}
