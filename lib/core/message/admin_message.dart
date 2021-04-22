import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/channel/group/features/thread_info.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/models/meta_array.dart';
import 'package:sendbird_sdk/core/models/og_meta_data.dart';
import 'package:sendbird_sdk/core/models/reaction.dart';
import 'package:sendbird_sdk/core/models/sender.dart';
import 'package:sendbird_sdk/core/models/user.dart';

part 'admin_message.g.dart';

/// Represents an admin message that can be sent from dashboard
///
/// This message type can be sent via platform api or from dashboard
@JsonSerializable()
class AdminMessage extends BaseMessage {
  AdminMessage({
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
    List<Reaction> reactions,
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
          reactions: reactions,
        );

  factory AdminMessage.fromJson(Map<String, dynamic> json) =>
      _$AdminMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdminMessageToJson(this);
}
