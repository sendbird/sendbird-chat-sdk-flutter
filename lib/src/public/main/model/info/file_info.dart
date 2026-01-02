// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:universal_io/io.dart';

part 'file_info.g.dart';

/// The file info.
@JsonSerializable()
class FileInfo {
  @JsonKey(includeFromJson: false, includeToJson: false)
  File? file;

  @JsonKey(includeFromJson: false, includeToJson: false)
  Uint8List? fileBytes;

  @JsonKey(name: 'url')
  String? fileUrl;

  @JsonKey(name: 'name')
  final String? fileName;

  @JsonKey(name: 'type')
  final String? mimeType;

  @JsonKey(name: 'size')
  int? fileSize;

  FileInfo({
    this.file,
    this.fileBytes,
    this.fileUrl,
    this.fileName,
    this.mimeType,
    this.fileSize,
  });

  /// fromFile
  FileInfo.fromFile({
    required this.file,
    required this.fileName,
    required this.mimeType,
  })  : fileSize = file?.lengthSync() ?? 0,
        fileBytes = null,
        fileUrl = null;

  /// fromBytes for Web
  FileInfo.fromFileBytes({
    required this.fileBytes,
    required this.fileName,
    required this.mimeType,
  })  : file = null,
        fileUrl = null;

  /// fromFileUrl
  FileInfo.fromFileUrl({
    required this.fileUrl,
    this.fileName,
    this.mimeType,
    this.fileSize,
  })  : file = null,
        fileBytes = null;

  factory FileInfo.fromJson(Map<String, dynamic> json) =>
      _$FileInfoFromJson(json);

  Map<String, dynamic> toJson() => _$FileInfoToJson(this);

  bool get hasBinary => file != null || fileBytes != null;

  bool get hasSource =>
      file != null || (fileUrl != null && fileUrl != '') || fileBytes != null;
}
