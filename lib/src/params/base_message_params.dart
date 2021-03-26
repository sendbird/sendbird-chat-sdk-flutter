import '../constant/enums.dart';
import '../core/message/base_message.dart';
import '../core/models/meta_array.dart';
import '../utils/extensions.dart';

/// Represents base class for message parameters.
class BaseMessageParams {
  /// Message data. The default value is `null`
  String data;

  /// Customize message's type to filter
  String customType;

  /// The push notification delivery option that determines how to deliver
  /// the push notification when sending a user or a file message.
  PushNotificationDeliveryOption pushOption =
      PushNotificationDeliveryOption.normal;

  /// Meta array with keys and values
  List<MessageMetaArray> metaArrays;

  /// Mention type
  MentionType mentionType;

  /// Mention to specific users. If sends a message with this field,
  /// the message will be arrived to mentioned users.
  List<String> mentionedUserIds;

  /// The unique ID of a parent message. A parent message is a message
  /// that has a thread of replies. If the message sent through the
  /// [BaseChannel.sendUserMessage] or [BaseChannel.sendFileMessage] method
  /// is a parent message, the value of this property is 0. If the message
  /// is a reply to a parent message, the value is the message ID of the
  /// parent message.
  int parentMessageId = 0;

  BaseMessageParams({
    this.data,
    this.customType,
    this.pushOption,
    this.metaArrays,
    this.mentionType,
    this.mentionedUserIds,
    this.parentMessageId = 0,
  });

  BaseMessageParams.withMessage(BaseMessage message, {bool deepCopy}) {
    data = message?.data;
    customType = message?.customType;
    metaArrays = message?.metaArrays;
    mentionType = message?.mentionType;
    mentionedUserIds = message?.mentionedUsers?.map((e) => e.userId)?.toList();
    if (deepCopy != null && deepCopy) {
      parentMessageId = message?.parentMessageId;
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> ret = {};
    ret['custom_type'] = customType;
    ret['data'] = data;
    ret['mention_type'] = mentionType?.asString();
    ret['mentioned_user_ids'] = mentionedUserIds;
    ret['sorted_metaarray'] = metaArrays?.map((e) => e.toJson())?.toList();
    if (pushOption == PushNotificationDeliveryOption.suppress)
      ret['push_option'] = pushOption.asString();
    if (parentMessageId > 0) ret['parent_message_id'] = parentMessageId;

    ret.removeWhere((key, value) => value == null);
    return ret;
  }
}
