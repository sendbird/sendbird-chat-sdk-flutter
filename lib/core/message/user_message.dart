import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/meta_array.dart';
import 'package:sendbird_sdk/core/models/sender.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/events/poll_update_event.dart';
import 'package:sendbird_sdk/events/poll_vote_event.dart';
import 'package:sendbird_sdk/features/og_meta_data/og_meta_data.dart';
import 'package:sendbird_sdk/features/poll/poll.dart';
import 'package:sendbird_sdk/features/reaction/reaction.dart';
import 'package:sendbird_sdk/features/threading/thread_info.dart';
import 'package:sendbird_sdk/features/scheduled_message/scheduled_info.dart';

import 'base_message.dart';

part 'user_message.g.dart';

/// Represents a basic text message
@JsonSerializable()
class UserMessage extends BaseMessage {
  /// translation map for this user message. Key is language code and value is
  /// translated text
  @JsonKey(defaultValue: {})
  final Map<String, String> translations;

  /// List of target langauges before translating
  final List<String>? translationTargetLanguages;

  /// linked poll information
  Poll? poll;

  UserMessage({
    required this.translations,
    required int messageId,
    required String message,
    required String channelUrl,
    required ChannelType channelType,
    Sender? sender,
    MessageSendingStatus? sendingStatus,
    String? requestId,
    List<User> mentionedUsers = const [],
    MentionType? mentionType,
    List<String>? requestedMentionUserIds,
    int createdAt = 0,
    int updatedAt = 0,
    int? parentMessageId,
    String? parentMessageText,
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
    Map<String, dynamic>? parentMessage,
    bool replyToChannel = false,
    this.poll,
    this.translationTargetLanguages,
  }) : super(
          replyToChannel: replyToChannel,
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
        );

  /// Applies [PollUpdateEvent] event to this message
  bool applyPollUpdateEvent(PollUpdateEvent event) {
    final currentPoll = poll;
    final eventPoll = event.poll;

    if (currentPoll == null) {
      return false;
    }
    final currentPollDetail = currentPoll.details;
    final eventPollDetail = eventPoll.details;
    if (currentPoll.id != event.poll.id) return false;
    if (event.status == 'removed') {
      currentPoll.details?.status = event.status;
      return true;
    } else if (currentPollDetail == null || eventPollDetail == null) {
      return false;
    } else if (currentPollDetail.updatedAt < event.ts) {
      poll = event.poll;
      return true;
    } else {
      return false;
    }
  }

  /// Applies [PollVoteEvent] event to this message
  bool applyPollVoteEvent(PollVoteEvent event) {
    var _result = false;
    final currentPoll = poll;
    if (currentPoll == null) {
      return false;
    }
    if (currentPoll.id != event.pollId) return false;
    final currentPollDetail = currentPoll.details;
    if (currentPollDetail == null) {
      return false;
    } else {
      //update vote count and vote at
      for (var option in currentPollDetail.options) {
        if (option.applyEvent(event)) {
          _result = true;
        }
      }
      return _result;
    }
  }

  factory UserMessage.fromJson(Map<String, dynamic> res) {
    return _$UserMessageFromJson(res);
  }

  @override
  Map<String, dynamic> toJson() => _$UserMessageToJson(this);

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;
    if (!(super == (other))) return false;

    final eq = MapEquality().equals;
    return other is UserMessage && eq(translations, other.translations);
  }

  @override
  int get hashCode => hashValues(super.hashCode, translations);
}
