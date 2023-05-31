// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/sendbird_chat.dart';

/// Represents a file message params.
class FileMessageUpdateParams extends BaseMessageUpdateParams {
  FileMessageUpdateParams({
    String? data,
    String? customType,
    MentionType? mentionType,
    List<String>? mentionedUserIds,
  }) : super(
          data: data,
          customType: customType,
          mentionType: mentionType,
          mentionedUserIds: mentionedUserIds,
        );

  // withMessage
  FileMessageUpdateParams.withMessage(FileMessage fileMessage)
      : super.withMessage(fileMessage);

  @override
  Map<String, dynamic> toJson() {
    final ret = super.toJson();

    ret.removeWhere((key, value) => value == null);
    return ret;
  }
}
