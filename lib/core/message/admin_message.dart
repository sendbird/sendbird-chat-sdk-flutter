import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/models/meta_array.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/features/og_meta_data/og_meta_data.dart';
import 'package:sendbird_sdk/features/reaction/reaction.dart';
import 'package:sendbird_sdk/features/threading/thread_info.dart';
import 'package:sendbird_sdk/core/models/sender.dart';
import 'package:sendbird_sdk/features/scheduled_message/scheduled_info.dart';

part 'admin_message.g.dart';

/// Represents an admin message that can be sent from dashboard
///
/// This message type can be sent via platform api or from dashboard
@JsonSerializable()
class AdminMessage extends BaseMessage {
  AdminMessage({
    required int messageId,
    required String message,
    required String channelUrl,
    required ChannelType channelType,
    MessageSendingStatus? sendingStatus,
    String? requestId,
    List<User> mentionedUsers = const [],
    List<String>? mentionedUserIds,
    MentionType? mentionType,
    List<String>? requestedMentionUserIds,
    int createdAt = 0,
    int updatedAt = 0,
    int? parentMessageId,
    String? parentMessageText,
    Map<String, dynamic>? parentMessage,
    ThreadInfo? threadInfo,
    List<MessageMetaArray>? metaArrays,
    String? customType,
    int? messageSurvivalSeconds,
    bool forceUpdateLastMessage = false,
    bool isSilent = false,
    int? errorCode,
    bool isOperatorMessage = false,
    String? data,
    OGMetaData? ogMetaData,
    List<Reaction>? reactions,
    bool replyToChannel = false,
    Map<String, dynamic>? extendedMessage,
    bool isPinnedMessage = false,
  }) : super(
          isPinnedMessage: isPinnedMessage,
          replyToChannel: replyToChannel,
          requestId: requestId,
          messageId: messageId,
          message: message,
          sendingStatus: sendingStatus,
          channelType: channelType,
          channelUrl: channelUrl,
          mentionedUsers: mentionedUsers,
          mentionedUserIds: mentionedUserIds,
          mentionType: mentionType,
          requestedMentionUserIds: requestedMentionUserIds,
          createdAt: createdAt,
          updatedAt: updatedAt,
          parentMessageId: parentMessageId,
          parentMessageText: parentMessageText,
          parentMessage: parentMessage,
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
          extendedMessage: extendedMessage ?? {},
        );

  factory AdminMessage.fromJson(Map<String, dynamic> json) =>
      _$AdminMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdminMessageToJson(this);
}
