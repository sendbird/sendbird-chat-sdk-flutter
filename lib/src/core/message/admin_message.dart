import 'package:json_annotation/json_annotation.dart';

import 'base_message.dart';

import '../channel/group/features/thread_info.dart';
import '../models/meta_array.dart';
import '../models/og_meta_data.dart';
import '../models/reaction.dart';
import '../models/sender.dart';
import '../models/user.dart';
import '../../constant/enums.dart';

part 'admin_message.g.dart';

/// Represents an admin message that can be sent from dashboard
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

  factory AdminMessage.fromJson(Map<String, dynamic> json) =>
      _$AdminMessageFromJson(json);
  Map<String, dynamic> toJson() => _$AdminMessageToJson(this);
}
