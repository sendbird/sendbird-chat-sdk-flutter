// Copyright (c) 2025 Sendbird, Inc. All rights reserved.

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/file_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:universal_io/io.dart';

part 'uploaded_file_info.g.dart';

/// Represents the uploaded file information.
/// @since 4.8.0
@JsonSerializable()
class UploadedFileInfo {
  @JsonKey(includeFromJson: false, includeToJson: false)
  Chat? chat;

  /// The file URL.
  final String url;

  /// The secure file URL.
  String get secureUrl {
    final eKey = chat?.chatContext.eKey;
    if (requireAuth && eKey != null) {
      // https://github.com/flutter/flutter/issues/25107
      // final urlString = url.replaceAll('https://', 'http://');
      return '$url?auth=$eKey';
    }
    return url;
  }

  /// Represents the name of the file.
  String? name;

  /// Represents the size of the file.
  int? size;

  /// Represents the type of the file. **MIME preferred.**
  String? type;

  /// Represents the thumbnail information of image file.
  /// To make thumbnail of image when you send it,
  /// please refer to [BaseChannelMessage.sendFileMessage].
  List<Thumbnail>? thumbnails;

  bool requireAuth;

  File? file;

  UploadedFileInfo({
    required this.url,
    this.chat,
    this.name,
    this.size = 0,
    this.type,
    this.thumbnails,
    this.requireAuth = false,
  });

  factory UploadedFileInfo.fromJson(Map<String, dynamic> json) {
    final uploadedFileInfo = _$UploadedFileInfoFromJson(json)
      ..chat = SendbirdChat().chat;

    //+ for MultipleFilesMessage
    if (uploadedFileInfo.name == null && json['file_name'] != null) {
      uploadedFileInfo.name = json['file_name'] as String;
    }
    if (uploadedFileInfo.size == 0 && json['file_size'] != null) {
      uploadedFileInfo.size = json['file_size'] as int;
    }
    if (uploadedFileInfo.type == null && json['file_type'] != null) {
      uploadedFileInfo.type = json['file_type'] as String;
    }
    //- for MultipleFilesMessage

    return uploadedFileInfo;
  }

  Map<String, dynamic> toJson() => _$UploadedFileInfoToJson(this);

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;

    final eq = const ListEquality().equals;
    return other is UploadedFileInfo &&
        other.url == url &&
        other.name == name &&
        other.size == size &&
        other.type == type &&
        eq(other.thumbnails, thumbnails) &&
        other.requireAuth == requireAuth;
  }

  @override
  int get hashCode => Object.hash(
        url,
        name,
        size,
        type,
        thumbnails,
        requireAuth,
      );
}
