import 'package:flutter/foundation.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbird_sdk/utils/logger.dart';
import 'package:universal_io/io.dart';
import 'dart:ui';

import 'package:mime/mime.dart';
import 'package:sendbird_sdk/params/base_message_params.dart';

/// An object consists a set of parameters for file message.
class FileMessageParams extends BaseMessageParams {
  /// Binary file data.
  late FileInfo uploadFile;

  /// Thumbnail sizes. This parameter is the array of `Size` and works for image file only
  List<Size>? thumbnailSizes;

  /// NOTE: should use this constructor when updating message
  FileMessageParams.withMessage(FileMessage fileMessage, {bool? deepCopy})
      : uploadFile = FileInfo.fromUrl(
          url: fileMessage.url,
          mimeType: fileMessage.type,
          fileSize: fileMessage.size,
          name: fileMessage.name,
        ),
        super.withMessage(fileMessage, deepCopy: deepCopy);

  /// NOTE: Not supported for Web
  FileMessageParams.withFile(File file, {String? name}) {
    if (kIsWeb) {
      throw SBError(
        message: "`FileMessageParams.withFile` is not supported for web",
      );
    }
    String fileType;

    if (lookupMimeType(file.path) == null) {
      switch (getFileExtension(file.path)) {
        case '.HEIC':
          fileType = 'imgae/heic';
          break;
        case '.HEIF':
          fileType = 'imgae/heif';
          break;
        default:
          throw SBError(message: 'Unknown File Type');
      }
    } else {
      fileType = lookupMimeType(file.path)!;
    }
    uploadFile = FileInfo.fromData(
      name: name ?? 'my_file',
      file: file,
      mimeType: fileType,
    );
  }

  FileMessageParams.withFileBytes(Uint8List data,
      {String? name, String? fileExtensionType}) {
    String fileType = "";
    final mime = lookupMimeType('', headerBytes: data);

    if (mime == null) {
      if (fileExtensionType != null) {
        fileType = fileExtensionType;
      } else {
        logger.e(StackTrace.current, "File Extension Type UNKNOWN");
        throw Exception(
            "File Extension Type UNKNOWN. Please include `fileExtensionType`");
      }
    } else {
      fileType = mime;
    }

    uploadFile = FileInfo.fromBytes(
      name: name ?? 'my_file',
      fileBytes: data,
      mimeType: fileType,
    );
  }

  FileMessageParams.withUrl(
    String fileUrl, {
    String? mimeType,
    int? size,
    String? name,
  }) : uploadFile = FileInfo.fromUrl(
          name: name ?? 'image',
          mimeType: mimeType ?? 'image/jpeg',
          url: fileUrl,
          fileSize: size,
        );

  @override
  Map<String, dynamic> toJson() {
    final ret = super.toJson();
    if (ret['mentioned_user_ids'] == null) {
      List? result = ret['mentioned_users'];

      var userList = result?.map((e) => e['user_id'].toString()).toList();

      if (userList?.isNotEmpty ?? false) {
        ret['mentioned_user_ids'] = userList;
      }
    }
    ret['url'] = uploadFile.url;
    ret['name'] = uploadFile.name;
    ret['size'] = uploadFile.fileSize;
    ret['type'] = uploadFile.mimeType;
    ret.removeWhere((key, value) => value == null);
    return ret;
  }
}

String getFileExtension(String fileName) {
  return "." + fileName.split('.').last;
}
