import '../constant/enums.dart';
import '../core/models/meta_array.dart';
import '../params/user_message_params.dart';

/// An object consists a set of parameters to create scheduled user message.
class ScheduledUserMessageParams extends UserMessageParams {
  /// The scheduled date time to send a message format (YYYY-MM-DD hh:mm)
  String scheduledDateString;

  /// The timezone for the scheduled  date to send a message.
  String timezone;

  /// Initializes this params instance with a text message and
  /// the date to send the message.
  ScheduledUserMessageParams({
    this.scheduledDateString,
    this.timezone,
    String message,
    List<String> targetLanguages,
    String data,
    String customType,
    PushNotificationDeliveryOption pushOption,
    MentionType mentionType,
    List<String> mentionedUserIds,
    List<MessageMetaArray> metaArrays,
    int parentMessageId,
  }) : super(
          message: message,
          targetLanguages: targetLanguages,
          data: data,
          customType: customType,
          pushOption: pushOption,
          mentionType: mentionType,
          mentionedUserIds: mentionedUserIds,
          metaArrays: metaArrays,
        );

  Map<String, dynamic> toJson() {
    final ret = super.toJson();
    ret['scheduled_dt'] = '$scheduledDateString $timezone';
    return ret;
  }
}
