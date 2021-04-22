import 'dart:io';
import 'dart:ui';

import 'package:mime/mime.dart';
import 'package:sendbird_sdk/core/message/file_message.dart';
import 'package:sendbird_sdk/core/models/file_info.dart';
import 'package:sendbird_sdk/params/base_message_params.dart';

/// An object consists a set of parameters for file message.
class FileMessageParams extends BaseMessageParams {
  /// Binary file data.
  FileInfo uploadFile;

  /// Thumbnail sizes. This parameter is the array of `Size` and works for image file only
  List<Size> thumbnailSizes;

  /// NOTE: should use this constructor when updating message
  FileMessageParams.withMessage(FileMessage fileMessage, {bool deepCopy})
      : super.withMessage(fileMessage, deepCopy: deepCopy) {
    uploadFile = FileInfo.fromUrl(
      url: fileMessage?.url,
      mimeType: fileMessage?.type,
    );
  }

  FileMessageParams.withFile(
    File file, {
    String name,
    FileMessage fileMessage,
  }) : super.withMessage(fileMessage, deepCopy: false) {
    uploadFile = FileInfo.fromData(
      name: name ?? 'my_file',
      file: file,
      mimeType: file != null ? lookupMimeType(file.path) : null,
    );
  }

  FileMessageParams.withUrl(
    String fileUrl, {
    String mimeType,
    int size,
    String name,
    FileMessage fileMessage,
  }) : super.withMessage(fileMessage, deepCopy: false) {
    uploadFile = FileInfo.fromUrl(
      name: name ?? 'image',
      mimeType: mimeType ?? 'image/jpeg',
      url: fileUrl,
      fileSize: size,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final ret = super.toJson();
    ret['url'] = uploadFile?.url;
    ret['file_name'] = uploadFile?.name;
    ret['file_size'] = uploadFile?.fileSize;
    ret['file_type'] = uploadFile?.mimeType;
    ret['thumbnails'] = thumbnailSizes?.map((e) => e.toString())?.toList();
    ret.removeWhere((key, value) => value == null);
    return ret;
  }
}
