import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:universal_io/io.dart';

part 'file_info.g.dart';

/// Represents information about image that will be used to upload
@JsonSerializable()
class FileInfo {
  /// name of this file
  final String? name;

  /// url of this file
  String? url;

  /// file data
  @JsonKey(ignore: true)
  final File? file;

  /// mime file type
  @JsonKey(name: 'type')
  final String? mimeType;

  /// file size
  @JsonKey(name: 'size')
  int? fileSize;

  /// file bytes
  @JsonKey(ignore: true)
  Uint8List? fileBytes;

  FileInfo(
      {this.name,
      this.url,
      this.mimeType,
      this.fileSize,
      this.file,
      this.fileBytes});

  FileInfo.fromData({
    required this.name,
    required this.file,
    required this.mimeType,
  })  : fileSize = file?.lengthSync(),
        url = null;

  FileInfo.fromBytes({
    required this.name,
    required this.fileBytes,
    required this.mimeType,
    this.file = null,
  }) : url = null;

  FileInfo.fromUrl({
    required this.url,
    this.mimeType,
    this.fileSize,
    this.name,
  }) : file = null;

  factory FileInfo.fromJson(Map<String, dynamic> json) =>
      _$FileInfoFromJson(json);

  Map<String, dynamic> toJson() => _$FileInfoToJson(this);

  bool get hasBinary => file != null || fileBytes != null;
  bool get hasSource =>
      file != null || (url != null && url != '') || fileBytes != null;
}
