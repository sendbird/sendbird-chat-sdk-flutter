// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/message_meta_array.dart';

/// Represents a base message params.
class BaseMessageCreateParams {
  /// The data of the message. Defaults to null.
  String? data;

  /// The custom type of the message. Defaults to null.
  String? customType;

  /// The mention type of the message. Defaults to [MentionType.users].
  MentionType mentionType = MentionType.users;

  /// The mentioned user ids of the message. If it hasn't set before, it returns null.
  List<String>? mentionedUserIds;

  /// The meta arrays of the message. Defaults to null.
  List<MessageMetaArray>? metaArrays;

  /// The parent message id of the message. Defaults to 0.
  int? parentMessageId;

  /// Whether the message should also be sent to the channel. Defaults to false.
  /// Only works when the [parentMessageId] is set.
  bool replyToChannel = false;

  /// The push notification delivery option user of the message.
  PushNotificationDeliveryOption pushNotificationDeliveryOption =
      PushNotificationDeliveryOption.normal;

  /// Whether the message should be pinned to the channel. Defaults to false.
  bool isPinnedMessage = false;

  BaseMessageCreateParams({
    this.data,
    this.customType,
    this.mentionType = MentionType.users,
    this.mentionedUserIds,
    this.metaArrays,
    this.parentMessageId,
    this.replyToChannel = false,
    this.pushNotificationDeliveryOption = PushNotificationDeliveryOption.normal,
    this.isPinnedMessage = false,
  });

  /// withMessage
  BaseMessageCreateParams.withMessage(BaseMessage message) {
    data = message.data;
    customType = message.customType;
    mentionType = message.mentionType;
    mentionedUserIds = message.mentionedUsers.map((e) => e.userId).toList();
    metaArrays = message.allMetaArrays;
    parentMessageId = message.parentMessageId;
    replyToChannel = message.isReplyToChannel;
  }

  Map<String, dynamic> toJson() {
    final ret = <String, dynamic>{
      'data': data,
      'custom_type': customType,
      'mention_type': mentionType.asString(),
      if (mentionType == MentionType.users)
        'mentioned_user_ids': mentionedUserIds,
      'metaarray': metaArrays?.map((e) => e.toJson()).toList(),
      'parent_message_id': parentMessageId,
      'reply_to_channel': replyToChannel,
      if (pushNotificationDeliveryOption ==
          PushNotificationDeliveryOption.suppress)
        'push_option': pushNotificationDeliveryOption.asString(),
      'pin_message': isPinnedMessage,
    };

    ret.removeWhere((key, value) => value == null);
    return ret;
  }
}
