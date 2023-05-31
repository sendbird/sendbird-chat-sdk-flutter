// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/core/message/user_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/base_message_update_params.dart';

/// Represents a user message update params.
class UserMessageUpdateParams extends BaseMessageUpdateParams {
  /// The message text of the message. Defaults to null.
  String? message;

  /// [extendedMessage] is used for Sendbird UiKit.
  /// Only featured in [GroupChannel]
  Map<String, dynamic>? extendedMessage;

  UserMessageUpdateParams({
    this.message,
    this.extendedMessage,
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

  UserMessageUpdateParams.withMessage(UserMessage userMessage)
      : message = userMessage.message,
        super.withMessage(userMessage);

  @override
  Map<String, dynamic> toJson() {
    final ret = super.toJson();
    ret['message'] = message;
    ret['extended_message'] = extendedMessage;

    ret.removeWhere((key, value) => value == null);
    return ret;
  }
}
