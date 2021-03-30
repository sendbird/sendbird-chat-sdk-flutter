import 'dart:io';
import 'dart:ui';

import 'package:mime/mime.dart';

import '../core/message/file_message.dart';
import '../core/models/image_info.dart';
import '../params/base_message_params.dart';

/// An object consists a set of parameters for file message.
class FileMessageParams extends BaseMessageParams {
  /// Binary file data.
  ImageInfo uploadFile;

  /// Thumbnail sizes. This parameter is the array of `Size` and works for image file only
  List<Size> thumbnailSizes;

  /// NOTE: should use this constructor when updating message
  FileMessageParams.withMessage(FileMessage fileMessage, {bool deepCopy})
      : super.withMessage(fileMessage, deepCopy: deepCopy) {
    uploadFile = ImageInfo.fromUrl(
      url: fileMessage?.url,
      mimeType: fileMessage?.type,
    );
  }

  FileMessageParams.withFile(
    File file, {
    String name,
    FileMessage fileMessage,
  }) : super.withMessage(fileMessage, deepCopy: false) {
    uploadFile = ImageInfo.fromData(
      name: name ?? 'my_file',
      file: file,
      mimeType: file != null ? lookupMimeType(file.path) : null,
    );
  }

  FileMessageParams.withUrl(
    String fileUrl,
    String mimeType, {
    int size,
    String name,
    FileMessage fileMessage,
  }) : super.withMessage(fileMessage, deepCopy: false) {
    uploadFile = ImageInfo.fromUrl(
      name: name ?? 'image',
      mimeType: mimeType,
      url: fileUrl,
      fileSize: size,
    );
  }

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
