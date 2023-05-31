// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

/// Represents a base message params.
class BaseMessageUpdateParams {
  /// The data of the message. Defaults to null.
  String? data;

  /// The custom type of the message. Defaults to null.
  String? customType;

  /// The mention type of the message.
  MentionType? mentionType;

  /// The mentioned user ids of the message. Defaults to null.
  List<String>? mentionedUserIds;

  BaseMessageUpdateParams({
    this.data,
    this.customType,
    this.mentionType,
    this.mentionedUserIds,
  });

  BaseMessageUpdateParams.withMessage(BaseMessage message) {
    data = message.data;
    customType = message.customType;
    mentionType = message.mentionType;
    mentionedUserIds = message.mentionedUsers.map((e) => e.userId).toList();
  }

  Map<String, dynamic> toJson() {
    final ret = <String, dynamic>{
      'data': data,
      'custom_type': customType,
      'mention_type': mentionType?.asString(),
      if (mentionType == MentionType.users)
        'mentioned_user_ids': mentionedUserIds,
    };

    ret.removeWhere((key, value) => value == null);
    return ret;
  }
}
