// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/core/message/user_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/message_meta_array.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/base_message_create_params.dart';

/// Represents a user message params.
class UserMessageCreateParams extends BaseMessageCreateParams {
  /// The message text of the message. Defaults to an empty string.
  String message;

  /// The translation target languages.
  List<String> translationTargetLanguages;

  /// Unique ID for a poll
  int? pollId;

  /// [extendedMessage] is used for Sendbird UiKit.
  /// Only featured in [GroupChannel]
  Map<String, dynamic>? extendedMessage;

  UserMessageCreateParams({
    required this.message,
    List<String>? translationTargetLanguages,
    this.pollId,
    this.extendedMessage,
    String? data,
    String? customType,
    MentionType? mentionType,
    List<String>? mentionedUserIds,
    List<MessageMetaArray>? metaArrays,
    int? parentMessageId,
    bool? replyToChannel,
    PushNotificationDeliveryOption pushNotificationDeliveryOption =
        PushNotificationDeliveryOption.normal,
    bool isPinnedMessage = false,
  })  : translationTargetLanguages = translationTargetLanguages ?? [],
        super(
          data: data,
          customType: customType,
          mentionType: mentionType ?? MentionType.users,
          mentionedUserIds: mentionedUserIds,
          metaArrays: metaArrays,
          parentMessageId: parentMessageId,
          replyToChannel: replyToChannel ?? false,
          pushNotificationDeliveryOption: pushNotificationDeliveryOption,
          isPinnedMessage: isPinnedMessage,
        );

  /// withMessage
  UserMessageCreateParams.withMessage(UserMessage userMessage)
      : message = userMessage.message,
        translationTargetLanguages = userMessage.translations.keys.toList(),
        pollId = userMessage.poll?.id,
        extendedMessage = userMessage.extendedMessage,
        super.withMessage(userMessage);

  @override
  Map<String, dynamic> toJson() {
    final ret = super.toJson();
    ret['message'] = message;
    ret['target_langs'] = translationTargetLanguages;
    if (translationTargetLanguages.isNotEmpty) {
      ret['translations'] = {for (var e in translationTargetLanguages) e: ''};
    }
    ret['poll_id'] = pollId;
    ret['extended_message'] = extendedMessage;

    ret.removeWhere((key, value) => value == null);
    return ret;
  }
}
