import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/command_type.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/constant/error_code.dart';
import 'package:sendbird_sdk/core/message/admin_message.dart';
import 'package:sendbird_sdk/core/message/file_message.dart';
import 'package:sendbird_sdk/core/message/scheduled_user_message.dart';
import 'package:sendbird_sdk/core/message/user_message.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/meta_array.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/core/models/sender.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/features/og_meta_data/og_meta_data.dart';
import 'package:sendbird_sdk/features/reaction/reaction.dart';
import 'package:sendbird_sdk/features/reaction/reaction_event.dart';
import 'package:sendbird_sdk/features/threading/thread_info.dart';
import 'package:sendbird_sdk/features/threading/thread_info_update_event.dart';
import 'package:sendbird_sdk/params/message_retrieval_params.dart';
import 'package:sendbird_sdk/params/threaded_message_list_params.dart';
import 'package:sendbird_sdk/request/messages/message_get_request.dart';
import 'package:sendbird_sdk/request/messages/messages_get_request.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:sendbird_sdk/utils/extensions.dart';
import 'package:sendbird_sdk/utils/logger.dart';

/// Represents base class for messages.
class BaseMessage {
  /// Request ID for checking ACK.
  final String? requestId;

  /// Unique message ID.
  //or msg_id
  @JsonKey(defaultValue: 0)
  final int messageId;

  /// Message text.
  final String message;

  /// Represents the dispatch state of this message. If this message
  /// is not dispatched completely to the Sendbird server, the value
  /// is `pending`. If failed to send the message, the value  is `failed`.
  /// And if success to send the message, the value is `succeeded`.
  MessageSendingStatus? sendingStatus;

  /// [Sender] of this message
  @JsonKey(name: 'user')
  Sender? sender;

  /// Channel url of this message.
  final String channelUrl;

  /// Channel type of this message
  @JsonKey(defaultValue: ChannelType.group, unknownEnumValue: ChannelType.group)
  ChannelType channelType;

  /// The list of users who was mentioned together with this message.
  @JsonKey(defaultValue: [])
  final List<User> mentionedUsers;

  /// Mention type that this message uses
  @JsonKey(unknownEnumValue: null)
  final MentionType? mentionType;

  /// Represents target user ids to mention when success to send this
  /// message. This value is valid only when the message is a pending
  /// message or failed message. If the message is a succeeded message,
  /// see `mentionedUserIds`
  final List<String>? requestedMentionUserIds;

  /// Message creation time in millisecond(UTC)
  @JsonKey(defaultValue: 0)
  final int createdAt;

  /// Message update time in millisecond(UTC).
  @JsonKey(defaultValue: 0)
  final int updatedAt;

  /// Option to reply to channel. The default is `false`
  @JsonKey(name: 'is_reply_to_channel', defaultValue: false)
  bool replyToChannel;

  /// The unique ID of the parent message. If the message object is a parent message
  ///  or a single message without any reply, the value of this property is `0`. If
  /// the object is a reply, the value is the unique ID of its parent message.
  final int? parentMessageId;

  /// The written text of the message object’s parent message. If the message object
  /// is a parent message, the value of this property is null. If the object is a reply
  /// to a parent message and the type of the parent message is [UserMessage], the value
  ///  is `message`. If it is [FileMessage], the value is the `name` of the uploaded file.
  final String? parentMessageText;

  /// Retrieve current message's parent information
  @JsonKey(name: 'parent_message_info')
  BaseMessage? parentMessage;

  /// The thread info that belongs to this message object.
  ThreadInfo? threadInfo;

  /// Gets an array of meta arrays sorted by chronological order.
  /// current does not support backward compatibility
  @JsonKey(name: 'sorted_metaarray')
  List<MessageMetaArray>? metaArrays;

  /// Custom message type
  final String? customType;

  /// Message disappear in seconds, default is -1 and won't disappear
  @JsonKey(defaultValue: -1)
  final int? messageSurvivalSeconds;

  /// True if this message should update last message of its channel
  @JsonKey(defaultValue: false)
  final bool forceUpdateLastMessage;

  /// True if this message won't affect unread message count / mention count
  @JsonKey(name: 'silent', defaultValue: false)
  final bool isSilent;

  /// The error code of this message. This value generated only when message send fails.
  int? errorCode;

  /// True if this message was created by an operator.
  @JsonKey(name: 'is_op_msg', defaultValue: false)
  final bool isOperatorMessage;

  /// data for this message
  String? data;

  /// Open graph information in this message. Nullable
  @JsonKey(name: 'og_tag')
  final OGMetaData? ogMetaData;

  /// reactions for this message
  @JsonKey(defaultValue: [])
  List<Reaction>? reactions;

  /// default constructor
  BaseMessage({
    required this.message,
    required this.sendingStatus,
    required this.channelUrl,
    required this.channelType,
    this.sender,
    this.mentionedUsers = const <User>[],
    this.requestId,
    this.messageId = 0,
    this.mentionType,
    this.requestedMentionUserIds,
    this.replyToChannel = false,
    this.createdAt = 0,
    this.updatedAt = 0,
    this.parentMessageId,
    this.parentMessageText,
    Map<String, dynamic>? parentMessage,
    this.threadInfo,
    this.metaArrays,
    this.customType,
    this.messageSurvivalSeconds,
    this.forceUpdateLastMessage = false,
    this.isSilent = false,
    this.errorCode,
    this.isOperatorMessage = false,
    this.data,
    this.ogMetaData,
    this.reactions = const <Reaction>[],
  }) {
    if (parentMessage != null && parentMessageId != null) {
      parentMessage['message_id'] = parentMessageId;
      parentMessage['channel_url'] = channelUrl;
      parentMessage['channel_type'] = channelType;

      this.parentMessage = BaseMessage.fromJson(parentMessage);
    }
    if (sendingStatus == null) {
      if (messageId > 0) {
        sendingStatus = MessageSendingStatus.succeeded;
      } else if (requestId != null) {
        sendingStatus = MessageSendingStatus.pending;
      } else {
        sendingStatus = MessageSendingStatus.none;
      }
    }
  }

  /// Returns `true` if this message can be resend.
  bool isResendable() {
    final resendableError = errorCode == ErrorCode.connectionRequired ||
        errorCode == ErrorCode.networkError ||
        errorCode == ErrorCode.ackTimeout ||
        errorCode == ErrorCode.webSocketConnectionClosed ||
        errorCode == ErrorCode.webSocketConnectionFailed ||
        errorCode == ErrorCode.fileUploadTimeout ||
        errorCode == ErrorCode.fileUploadCanceled ||
        errorCode == ErrorCode.internalServerError ||
        errorCode == ErrorCode.rateLimitExceeded ||
        errorCode == ErrorCode.socketTooManyMessages ||
        errorCode == ErrorCode.pendingError;
    if (resendableError &&
        (sendingStatus == MessageSendingStatus.failed ||
            sendingStatus == MessageSendingStatus.canceled)) {
      return true;
    }
    return false;
  }

  /// Retreives list of [MessageMetaArray] with given [keys]
  List<MessageMetaArray> getMetaArrays(List<String> keys) {
    if (keys.isEmpty) {
      logger.e('invalid keys');
      throw InvalidParameterError();
    }

    final result = List<MessageMetaArray>.from(metaArrays ?? []);
    result.removeWhere((e) => !keys.contains(e.key));
    return result;
  }

  /// Applies [ReactionEvent] to this message.
  ///
  /// Returns `true` if the given [ReactionEvent] applied to this message
  /// successfully, otherwise `false`.
  bool applyReactionEvent(ReactionEvent event) {
    if (event.messageId != messageId) {
      logger.i('message id is mismatched');
      return false;
    }

    final keys = reactions?.map((e) => e.key).toList();
    final existIndex = keys?.indexWhere((e) => e == event.key) ?? -1;
    if (existIndex != -1) {
      final reaction = reactions?[existIndex];
      if (reaction != null && reaction.merge(event)) {
        if (event.operation == ReactionEventAction.delete &&
            reaction.userIds.isEmpty) {
          reactions?.removeWhere((e) => e.key == event.key);
        }
        return true;
      } else {
        return false;
      }
    } else if (event.operation == ReactionEventAction.add) {
      final reaction = Reaction(
        key: event.key,
        userIds: [event.userId],
        updatedAt: event.updatedAt,
      );
      reactions?.add(reaction);
      return true;
    } else {
      return false;
    }
  }

  /// Retrieves a [BaseMessage] with given [MessageRetrievalParams].
  static Future<BaseMessage> getMessage(MessageRetrievalParams params) async {
    if (params.messageId < 0) {
      throw InvalidParameterError();
    }

    final sdk = SendbirdSdk().getInternal();

    return sdk.api.send<BaseMessage>(
      ChannelMessageGetRequest(
        channelType: params.channelType,
        channelUrl: params.channelUrl,
        messageId: params.messageId,
        params: params,
      ),
    );
  }

  /// Retrieves threaded messages (replies) on this message with [timestamp]
  /// and [params].
  Future<ThreadedMessageResponse> getThreadedMessagesByTimestamp(
    int timestamp,
    ThreadedMessageListParams params,
  ) async {
    final sdk = SendbirdSdk().getInternal();
    final result = await sdk.api.send<List<BaseMessage>>(
      ChannelMessagesGetRequest(
        channelType: channelType,
        channelUrl: channelUrl,
        params: params.toJson(),
        timestamp: timestamp,
        parentMessageId: messageId,
      ),
    );

    return ThreadedMessageResponse(
      parentMessage: result.first,
      replies: result.sublist(1),
    );
  }

  /// Applies [ThreadInfoUpdateEvent] event to this message.
  ///
  /// This [ThreadInfoUpdateEvent] event can be acquired from
  /// [ChannelEventHandler.onThreadInfoUpdated] channel event and should be
  /// applied to corresponding message in order to display threaded messages
  /// properly.
  bool applyThreadInfoUpdateEvent(ThreadInfoUpdateEvent event) {
    if (messageId != event.parentMessageId) return false;
    if (threadInfo == null) {
      threadInfo = event.threadInfo;
      return true;
    }
    final updatedAt = threadInfo?.updatedAt ?? 0;
    final newUpdatedAt = event.threadInfo.updatedAt ?? 0;
    if (updatedAt <= newUpdatedAt) {
      threadInfo = event.threadInfo;
      return true;
    }
    return false;
  }

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;

    final eq = ListEquality().equals;
    return other is BaseMessage &&
        other.messageId == messageId &&
        other.message == message &&
        other.sendingStatus == sendingStatus &&
        other.sender == sender &&
        other.channelUrl == channelUrl &&
        other.channelType == channelType &&
        other.mentionType == mentionType &&
        eq(other.mentionedUsers, mentionedUsers) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.customType == customType &&
        other.data == data &&
        other.isSilent == isSilent &&
        other.threadInfo == threadInfo &&
        eq(other.reactions, reactions);
  }

  @override
  int get hashCode => hashValues(
        messageId,
        message,
        sendingStatus,
        sender,
        channelUrl,
        channelType,
        mentionedUsers,
        mentionType,
        createdAt,
        updatedAt,
        isSilent,
        customType,
        data,
        parentMessageId,
        threadInfo,
        metaArrays,
        reactions,
      );

  static T? msgFromJson<T extends BaseMessage>(
    Map<String, dynamic> json, {
    ChannelType? channelType,
    String? type,
  }) {
    final cmd = type ?? json['type'] as String;
    T msg;
    //basemessage backward compatibility -
    if (json['custom'] != null) json['data'] = json['custom'];
    if (json['ts'] != null) json['created_at'] = json['ts'];
    if (json['msg_id'] != null) json['message_id'] = json['msg_id'];
    if (json['req_id'] != null) json['request_id'] = json['req_id'];

    //manually insert type if channel is provided
    if (channelType != null) json['channel_type'] = channelType.asString();
    //manually insert reply_to_channel
    if (json['reply_to_channel'] != null) {
      json['is_reply_to_channel'] = json['reply_to_channel'];
    }

    if (T == UserMessage || CommandString.isUserMessage(cmd)) {
      msg = UserMessage.fromJson(json) as T;
    } else if (T == FileMessage || CommandString.isFileMessage(cmd)) {
      msg = FileMessage.fromJson(json) as T;
    } else if (T == AdminMessage || CommandString.isAdminMessage(cmd)) {
      msg = AdminMessage.fromJson(json) as T;
    } else {
      return null;
    }

    final metaArray = json['metaarray'];
    final metaArrayKeys = List<String>.from(json['metaarray_key_order'] ?? []);
    //NOTE: sorted_metaarray is from API, metaarray list is local,
    //metaarray map is from Web, so had to handle separately

    //local cmd case
    if (metaArray is List) {
      msg.metaArrays = metaArray
          .map((e) => MessageMetaArray.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    //websocket cmd result case
    else if (metaArray is Map && metaArrayKeys.isNotEmpty) {
      msg.metaArrays = metaArrayKeys.map((e) {
        final value = List<String>.from(metaArray[e]);
        return MessageMetaArray(key: e, value: value);
      }).toList();
    }

    return msg;
  }

  /// Map [json] object
  factory BaseMessage.fromJson(Map<String, dynamic> json) {
    final cmd = json['type'] as String;
    BaseMessage msg;
    //basemessage backward compatibility -
    if (json['custom'] != null) json['data'] = json['custom'];
    if (json['ts'] != null) json['created_at'] = json['ts'];
    if (json['msg_id'] != null) json['message_id'] = json['msg_id'];

    if (CommandString.isUserMessage(cmd)) {
      msg = UserMessage.fromJson(json);
    } else if (CommandString.isFileMessage(cmd)) {
      msg = FileMessage.fromJson(json);
    } else if (CommandString.isAdminMessage(cmd)) {
      msg = AdminMessage.fromJson(json);
    } else {
      throw UnrecognizedMessageTypeError();
    }

    final metaArray = json['metaarray'];
    final metaArrayKeys = List<String>.from(json['metaarray_key_order'] ?? []);
    //NOTE: sorted_metaarray is from API, metaarray list is local,
    //metaarray map is from Web, so had to handle separately

    //local cmd case
    if (metaArray is List) {
      msg.metaArrays = metaArray
          .map((e) => MessageMetaArray.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    //websocket cmd result case
    else if (metaArray is Map && metaArrayKeys.isNotEmpty) {
      msg.metaArrays = metaArrayKeys.map((e) {
        final value = List<String>.from(metaArray[e]);
        return MessageMetaArray(key: e, value: value);
      }).toList();
    }

    return msg;
  }

  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}
