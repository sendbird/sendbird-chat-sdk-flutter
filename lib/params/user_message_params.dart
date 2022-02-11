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

  UserMessageParams({
    required this.message,
    List<String>? targetLanguages,
    String? data,
    String? customType,
    PushNotificationDeliveryOption pushOption =
        PushNotificationDeliveryOption.normal,
    MentionType? mentionType,
    List<String>? mentionedUserIds,
    List<MessageMetaArray>? metaArrays,
    bool? replyToChannel,
  })  : targetLanguages = targetLanguages ?? [],
        super(
          replyToChannel: replyToChannel ?? false,
          data: data,
          customType: customType,
          pushOption: pushOption,
          mentionType: mentionType,
          mentionedUserIds: mentionedUserIds,
          metaArrays: metaArrays,
        );

  UserMessageParams.withMessage(UserMessage userMessage, {bool? deepCopy})
      : message = userMessage.message,
        targetLanguages = userMessage.translations.keys.toList(),
        super.withMessage(userMessage, deepCopy: deepCopy);

  @override
  Map<String, dynamic> toJson() {
    final ret = super.toJson();
    ret['message'] = message;
    ret['target_langs'] = targetLanguages;
    if (targetLanguages.isNotEmpty) {
      ret['translations'] = {for (var e in targetLanguages) e: ''};
    }
    ret.removeWhere((key, value) => value == null);
    return ret;
  }
}
