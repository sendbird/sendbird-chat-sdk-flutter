import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/models/meta_array.dart';
import 'package:sendbird_sdk/utils/extensions.dart';

/// Represents base class for message parameters.
class BaseMessageParams {
  /// Message data. The default value is `null`
  String? data;

  /// Customize message's type to filter
  String? customType;

  /// The push notification delivery option that determines how to deliver
  /// the push notification when sending a user or a file message.
  PushNotificationDeliveryOption pushOption =
      PushNotificationDeliveryOption.normal;

  /// Meta array with keys and values
  List<MessageMetaArray>? metaArrays;

  /// Mention type
  MentionType? mentionType;

  /// Mention to specific users. If sends a message with this field,
  /// the message will be arrived to mentioned users.
  List<String>? mentionedUserIds;

  /// The unique ID of a parent message. A parent message is a message
  /// that has a thread of replies. If the message sent through the
  /// [BaseChannel.sendUserMessage] or [BaseChannel.sendFileMessage] method
  /// is a parent message, the value of this property is 0. If the message
  /// is a reply to a parent message, the value is the message ID of the
  /// parent message.
  int? parentMessageId;

  /// Allow Reply to Channel The default is `false`
  bool replyToChannel = false;

  BaseMessageParams({
    this.data,
    this.customType,
    this.pushOption = PushNotificationDeliveryOption.normal,
    this.metaArrays,
    this.mentionType,
    this.mentionedUserIds,
    this.parentMessageId,
    this.replyToChannel = false,
  });

  BaseMessageParams.withMessage(BaseMessage message, {bool? deepCopy}) {
    data = message.data;
    customType = message.customType;
    metaArrays = message.metaArrays;
    mentionType = message.mentionType;
    mentionedUserIds = message.mentionedUsers.map((e) => e.userId).toList();
    if (deepCopy != null && deepCopy) {
      parentMessageId = message.parentMessageId;
    }
  }

  Map<String, dynamic> toJson() {
    final ret = <String, dynamic>{
      'custom_type': customType,
      'data': data,
      'mention_type': mentionType?.asString(),
      if (mentionType == MentionType.users)
        'mentioned_user_ids': mentionedUserIds,
      'metaarray': metaArrays?.map((e) => e.toJson()).toList(),
      if (pushOption == PushNotificationDeliveryOption.suppress)
        'push_option': pushOption.asString(),
      'parent_message_id': parentMessageId,
      'reply_to_channel': replyToChannel,
    };

    ret.removeWhere((key, value) => value == null);
    return ret;
  }
}
