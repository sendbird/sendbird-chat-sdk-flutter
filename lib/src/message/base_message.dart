import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../constant/enums.dart';
import '../constant/command_type.dart';
import '../constant/error_code.dart';
import '../features/reaction/reaction.dart';
import '../features/reaction/reaction_event.dart';
import '../features/thread/thread_info.dart';
import '../features/thread/thread_info_update_event.dart';
import '../message/admin_message.dart';
import '../message/file_message.dart';
import '../message/user_message.dart';
import '../models/error.dart';
import '../models/responses.dart';
import '../models/meta_array.dart';
import '../models/user.dart';
import '../models/sender.dart';
import '../params/message_retrieval_params.dart';
import '../params/threaded_message_list_params.dart';
import '../sdk/sendbird_sdk_api.dart';

part 'base_message.g.dart';

/// Represents base class for messages.
@JsonSerializable()
class BaseMessage {
  /// Request ID for checking ACK.
  final String requestId;

  /// Unique message ID.
  //or msg_id
  final int messageId;

  /// Message text.
  final String message;

  /// Represents the dispatch state of this message. If this message
  /// is not dispatched completely to the Sendbird server, the value
  /// is `pending`. If failed to send the message, the value  is `failed`.
  /// And if success to send the message, the value is `succeeded`.
  MessageSendingStatus sendingStatus;

  /// [Sender] of this message
  @JsonKey(name: 'user')
  Sender sender;

  /// Channel url of this message.
  final String channelUrl;

  /// Channel type of this message
  final ChannelType channelType;

  /// The list of users who was mentioned together with this message.
  final List<User> mentionedUsers;

  /// Mention type that this message uses
  @JsonKey(unknownEnumValue: null, nullable: true)
  final MentionType mentionType;

  /// Represents target user ids to mention when success to send this
  /// message. This value is valid only when the message is a pending
  /// message or failed message. If the message is a succeeded message,
  /// see `mentionedUserIds`
  final List<String> requestedMentionUserIds;

  /// Message creation time in millisecond(UTC)
  //or ts
  final int createdAt;

  /// Message update time in millisecond(UTC).
  @JsonKey(defaultValue: 0)
  final int updatedAt;

  /// The unique ID of the parent message. If the message object is a parent message
  ///  or a single message without any reply, the value of this property is `0`. If
  /// the object is a reply, the value is the unique ID of its parent message.
  final int parentMessageId;

  /// The written text of the message object’s parent message. If the message object
  /// is a parent message, the value of this property is null. If the object is a reply
  /// to a parent message and the type of the parent message is [UserMessage], the value
  ///  is `message`. If it is [FileMessage], the value is the `name` of the uploaded file.
  final String parentMessageText;

  /// The thread info that belongs to this message object.
  ThreadInfo threadInfo;

  /// Gets an array of meta arrays sorted by chronological order.
  /// current does not support backward compatibility
  @JsonKey(name: "sorted_metaarray")
  List<MessageMetaArray> metaArrays;

  /// Custom message type
  final String customType;

  /// Message disappear in seconds, default is -1 and won't disappear
  @JsonKey(defaultValue: -1)
  final int messageSurvivalSeconds;

  /// True if this message should update last message of its channel
  final bool forceUpdateLastMessage;

  /// True if this message won't affect unread message count / mention count
  @JsonKey(name: 'silent')
  final bool isSilent;

  /// The error code of this message. This value generated only when message send fails.
  int errorCode;

  /// True if this message was created by an operator.
  @JsonKey(name: 'is_op_msg')
  final bool isOperatorMessage;

  /// data for this message
  final String data;

  /// reactions for this message
  @JsonKey(defaultValue: [])
  List<Reaction> reactions;

  /// default constructor
  BaseMessage({
    this.requestId,
    this.messageId,
    this.message,
    this.sendingStatus,
    this.sender,
    this.channelUrl,
    this.channelType,
    this.mentionedUsers,
    this.mentionType,
    this.requestedMentionUserIds,
    this.createdAt,
    this.updatedAt,
    this.parentMessageId,
    this.parentMessageText,
    this.threadInfo,
    this.metaArrays,
    this.customType,
    this.messageSurvivalSeconds,
    this.forceUpdateLastMessage = false,
    this.isSilent = false,
    this.errorCode,
    this.isOperatorMessage,
    this.data,
    this.reactions,
  }) {
    if (sendingStatus == null) {
      if (messageId != null && messageId > 0) {
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
    bool resendableError = errorCode == ErrorCode.connectionRequired ||
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
    if (keys == null || keys.isEmpty) {
      throw InvalidParameterError();
    }

    final result = List<MessageMetaArray>.from(metaArrays);
    result.removeWhere((e) => !keys.contains(e.key));
    return result;
  }

  /// Applies [ReactionEvent] to this message.
  ///
  /// Returns `true` if the given [ReactionEvent] applied to this message
  /// successfully, otherwise `false`.
  bool applyReactionEvent(ReactionEvent event) {
    if (event == null) return false;
    if (event.messageId != messageId) return false;

    final keys = reactions.map((e) => e.key).toList();
    final existIndex = keys.indexWhere((e) => e == event.key);
    if (existIndex != -1) {
      final reaction = reactions[existIndex];
      if (reaction.merge(event)) {
        if (event.operation == ReactionEventAction.delete &&
            reaction.userIds.isEmpty) {
          reactions.removeWhere((e) => e.key == event.key);
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
      reactions.add(reaction);
      return true;
    } else {
      return false;
    }
  }

  /// Retrieves a [BaseMessage] with given [MessageRetrievalParams].
  static Future<BaseMessage> getMessage(MessageRetrievalParams params) async {
    if (params == null || !params.isValid) {
      throw InvalidParameterError();
    }

    final sdk = SendbirdSdk().getInternal();
    return sdk.api.getMessage(
      channelType: params.channelType,
      channelUrl: params.channelUrl,
      messageId: params.messageId,
      params: params,
    );
  }

  /// Retrieves threaded messages (replies) on this message with [timestamp]
  /// and [params].
  Future<ThreadedMessageResponse> getThreadedMessageByTimestamp(
    int timestamp,
    ThreadedMessageListParams params,
  ) async {
    if (params == null) {
      throw InvalidParameterError();
    }

    final sdk = SendbirdSdk().getInternal();
    final result = await sdk.api.getMessages(
      channelType: channelType,
      channelUrl: channelUrl,
      params: params.toJson(),
      timestamp: timestamp ?? double.maxFinite.round(),
      parentMessageId: messageId,
    );

    return ThreadedMessageResponse()
      ..parentMessage = result.first
      ..replies = result.sublist(1);
  }

  /// Applies [ThreadInfoUpdateEvent] event to this message.
  ///
  /// This [ThreadInfoUpdateEvent] event can be acquired from
  /// [ChannelEventHandler.onThreadInfoUpdated] channel event and should be
  /// applied to corresponding message in order to display threaded messages
  /// properly.
  bool applyThreadInfoUpdateEvent(ThreadInfoUpdateEvent event) {
    if (event == null) return false;
    if (messageId != event.rootMessageId) return false;
    if (threadInfo == null) {
      threadInfo = event.threadInfo;
      return true;
    }
    if (threadInfo.updatedAt > event.threadInfo.updatedAt) return false;
    threadInfo = event.threadInfo;
    return true;
  }

  static T msgFromJson<T extends BaseMessage>(Map<String, dynamic> json) {
    String cmd = json["type"] as String;
    T msg;
    //basemessage backward compatibility -
    if (json['custom'] != null) json['data'] = json['custom'];
    if (json['ts'] != null) json['created_at'] = json['ts'];
    if (json['msg_id'] != null) json['message_id'] = json['msg_id'];

    if (T == UserMessage || CommandType.isUserMessage(cmd)) {
      msg = UserMessage.fromJson(json) as T;
    } else if (T == FileMessage || CommandType.isFileMessage(cmd)) {
      msg = FileMessage.fromJson(json) as T;
    } else if (T == AdminMessage || CommandType.isAdminMessage(cmd)) {
      msg = AdminMessage.fromJson(json) as T;
    } else {
      msg = _$BaseMessageFromJson(json);
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
    String cmd = json["type"] as String;
    BaseMessage msg;
    //basemessage backward compatibility -
    if (json['custom'] != null) json['data'] = json['custom'];
    if (json['ts'] != null) json['created_at'] = json['ts'];
    if (json['msg_id'] != null) json['message_id'] = json['msg_id'];

    if (CommandType.isUserMessage(cmd)) {
      msg = UserMessage.fromJson(json);
    } else if (CommandType.isFileMessage(cmd)) {
      msg = FileMessage.fromJson(json);
    } else if (CommandType.isAdminMessage(cmd)) {
      msg = AdminMessage.fromJson(json);
    } else {
      msg = _$BaseMessageFromJson(json);
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

  // Builds a message object from [ByteData]
  // static BaseMessage buildFromSeralizedData(ByteData data) {
  //   return null;
  // }

  // Serializes message object and return [ByteData]
  // ByteData serialize() {
  //   return null;
  // }
}
