import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/message/user_message.dart';
import 'package:sendbird_sdk/core/models/meta_array.dart';
import 'package:sendbird_sdk/params/base_message_params.dart';

/// An object consists a set of parameters to create/update user message.
class UserMessageParams extends BaseMessageParams {
  /// Text message
  String message;

  /// The target languages that a message will be translated into
  List<String> targetLanguages;

  /// Unique ID for a poll
  int? pollId;

  bool isChannelMention = false;

  /// Message Template
  Map<String, dynamic>? extendedMessage;

  UserMessageParams({
    required this.message,
    this.pollId,
    List<String>? targetLanguages,
    String? data,
    String? customType,
    PushNotificationDeliveryOption pushOption =
        PushNotificationDeliveryOption.normal,
    this.isChannelMention = false,
    MentionType? mentionType,
    List<String>? mentionedUserIds,
    List<MessageMetaArray>? metaArrays,
    bool? replyToChannel,
    this.extendedMessage,
    bool isPinnedMessage = false,
  })  : targetLanguages = targetLanguages ?? [],
        super(
          replyToChannel: replyToChannel ?? false,
          data: data,
          customType: customType,
          pushOption: pushOption,
          mentionType: isChannelMention ? MentionType.channel : mentionType,
          mentionedUserIds: mentionedUserIds,
          metaArrays: metaArrays,
          isPinnedMessage: isPinnedMessage,
        );

  UserMessageParams.withMessage(UserMessage userMessage, {bool? deepCopy})
      : message = userMessage.message,
        pollId = userMessage.poll?.id,
        targetLanguages = userMessage.translations.keys.toList(),
        super.withMessage(userMessage, deepCopy: deepCopy);

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

    ret['poll_id'] = pollId;
    ret['message'] = message;
    ret['target_langs'] = targetLanguages;
    if (targetLanguages.isNotEmpty) {
      ret['translations'] = {for (var e in targetLanguages) e: ''};
    }
    ret['extended_message'] = extendedMessage;
    ret.removeWhere((key, value) => value == null);
    return ret;
  }
}
