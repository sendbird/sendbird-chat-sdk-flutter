import 'package:json_annotation/json_annotation.dart';

import 'base_message.dart';

import '../constant/enums.dart';
import '../features/og_image/og_meta_data.dart';
import '../features/reaction/reaction.dart';
import '../features/thread/thread_info.dart';
import '../models/meta_array.dart';
import '../models/sender.dart';
import '../models/user.dart';

part 'user_message.g.dart';

/// Represents a basic text message
@JsonSerializable(createToJson: false)
class UserMessage extends BaseMessage {
  /// translation map for this user message. Key is language code and value is
  /// translated text
  final Map<String, String> translations;

  UserMessage({
    this.translations,
    String requestId,
    int messageId,
    String message,
    MessageSendingStatus sendingStatus,
    Sender sender,
    String channelUrl,
    ChannelType channelType,
    List<User> mentionedUsers,
    MentionType mentionType,
    List<String> requestedMentionUserIds,
    int createdAt,
    int updatedAt,
    int parentMessageId,
    String parentMessageText,
    ThreadInfo threadInfo,
    List<MessageMetaArray> metaArrays,
    String customType,
    int messageSurvivalSeconds,
    bool forceUpdateLastMessage,
    bool isSilent,
    int errorCode,
    bool isOperatorMessage,
    String data,
    OGMetaData ogMetaData,
  }) : super(
          requestId: requestId,
          messageId: messageId,
          message: message,
          sendingStatus: sendingStatus,
          sender: sender,
          channelType: channelType,
          channelUrl: channelUrl,
          mentionedUsers: mentionedUsers,
          mentionType: mentionType,
          requestedMentionUserIds: requestedMentionUserIds,
          createdAt: createdAt,
          updatedAt: updatedAt,
          parentMessageId: parentMessageId,
          parentMessageText: parentMessageText,
          threadInfo: threadInfo,
          metaArrays: metaArrays,
          customType: customType,
          messageSurvivalSeconds: messageSurvivalSeconds,
          forceUpdateLastMessage: forceUpdateLastMessage,
          isSilent: isSilent,
          errorCode: errorCode,
          isOperatorMessage: isOperatorMessage,
          data: data,
          ogMetaData: ogMetaData,
        );

  // @override
  // bool operator ==(other) {
  //   Function eq = const MapEquality().equals;

  //   if (identical(other, this)) return true;
  //   if (!eq(translations, other.translations)) return false;
  //   if (!(super == (other))) return false;

  //   return false;
  // }

  // @override
  // int get hashCode => super.hashCode;

  factory UserMessage.fromJson(Map<String, dynamic> json) =>
      _$UserMessageFromJson(json);
}
