// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:convert';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/scheduled_message/group_channel_scheduled_message_get_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/message/channel_message_get_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/message/channel_messages_get_request.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/admin_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/file_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/user_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/sender.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat_options.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/sendbird_error.dart';
import 'package:sendbird_chat_sdk/src/public/main/handler/channel_handler.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/info/scheduled_info.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/message_meta_array.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/og/og_meta_data.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/reaction/reaction.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/reaction/reaction_event.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/thread/thread_info.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/thread/thread_info_updated_event.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/thread/threaded_messages.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/message_retrieval_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/scheduled_message_retrieval_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/threaded_message_list_params.dart';

part 'package:sendbird_chat_sdk/src/internal/main/extensions/base_message_extensions.dart';

/// Base class for messages.
abstract class BaseMessage extends RootMessage {
  /// The request ID of the message.
  final String? requestId;

  /// The ID of the message.
  @JsonKey(defaultValue: 0) // or msg_id
  final int messageId;

  /// The message text of the message.
  final String message;

  /// The sending status of the message.
  SendingStatus? sendingStatus;

  /// Determines whether the current message is a replied message and also a message was replied to the channel.
  @JsonKey(name: 'is_reply_to_channel', defaultValue: false)
  bool isReplyToChannel;

  /// The parent message's ID if this is a reply message.
  final int? parentMessageId;

  /// The parent message of this message.
  /// Only `NonNull` if this message is a reply message.
  /// It does **not** contain all properties of the parent message.
  /// Only contains:
  /// - [BaseMessage.message].
  /// - [BaseMessage.sender]. (null if the parent message is an [AdminMessage]).
  /// - [BaseMessage.createdAt].
  /// - File information if it's a [FileMessage].
  /// - [FileMessage.name].
  /// - [FileMessage.type].
  /// - [FileMessage.url].
  /// This is only for accessing parent message's information (READ ONLY) and should not to be used to modify the parent message.
  @JsonKey(name: 'parent_message_info')
  BaseMessage? parentMessage;

  /// The thread info of the message.
  ThreadInfo? threadInfo;

  /// The message's survival seconds.
  @JsonKey(defaultValue: -1)
  final int? messageSurvivalSeconds;

  /// Checks whether the message is silent or not.
  @JsonKey(name: 'silent')
  final bool isSilent;

  /// The error code of them message if the [sendingStatus] is [SendingStatus.failed].
  int? errorCode;

  /// Whether the message was sent from an operator.
  /// This value is true if the sender of this message was an operator at the moment this message was sent.
  /// Note that [Sender.role] returns the role of the sender at the current moment (when
  /// the server response was sent).
  /// So if the sender's operator status changed after sending a message,
  /// the value of the property and the result of [Sender.role] might differ.
  @JsonKey(name: 'is_op_msg')
  final bool isOperatorMessage;

  /// The [OGMetaData] of the message. (https://ogp.me/)
  /// Might be null if
  /// 1. Application does not support OG-TAG. (all new applications support OG-TAG by default)
  /// 2. The message does not contain a valid url.
  /// 3. The server did not fetch the OG-Tag yet.
  @JsonKey(name: 'og_tag')
  final OGMetaData? ogMetaData;

  /// The reactions on the message.
  @JsonKey(defaultValue: [])
  List<Reaction>? reactions;

  /// The scheduled info of the message if this is a scheduled message
  @JsonKey(includeFromJson: false, includeToJson: false)
  ScheduledInfo? scheduledInfo;

  final bool forceUpdateLastMessage;

  @JsonKey(includeFromJson: false, includeToJson: false)
  Sender? _sender;

  BaseMessage({
    required super.channelUrl,
    required super.channelType,
    required this.message,
    required this.sendingStatus,
    super.data,
    super.customType,
    super.mentionType,
    super.mentionedUsers,
    super.allMetaArrays,
    super.extendedMessage,
    super.createdAt,
    super.updatedAt,
    Sender? sender,
    this.requestId,
    this.messageId = 0,
    this.isReplyToChannel = false,
    this.parentMessageId,
    Map<String, dynamic>? parentMessage,
    this.threadInfo,
    this.messageSurvivalSeconds,
    this.forceUpdateLastMessage = false,
    this.isSilent = false,
    this.errorCode,
    this.isOperatorMessage = false,
    this.ogMetaData,
    this.reactions = const <Reaction>[],
    this.scheduledInfo,
  }) : _sender = sender {
    if (parentMessage != null && parentMessageId != null) {
      parentMessage['message_id'] = parentMessageId;
      parentMessage['channel_url'] = channelUrl;
      parentMessage['channel_type'] = channelType;

      this.parentMessage = RootMessage.fromJson(parentMessage) as BaseMessage;
    }

    if (sendingStatus == null) {
      if (messageId > 0) {
        sendingStatus = SendingStatus.succeeded;
      } else if (requestId != null) {
        sendingStatus = SendingStatus.pending;
      } else {
        sendingStatus = SendingStatus.none;
      }
    }
  }

  MessageType get messageType => this is UserMessage
      ? MessageType.user
      : this is FileMessage
          ? MessageType.file
          : MessageType.admin;

  @override
  void set(Chat chat) {
    super.set(chat);

    parentMessage?.set(chat);
    _sender?.set(chat);

    final users = threadInfo?.mostRepliesUsers;
    if (users != null) {
      for (final element in users) {
        element.set(chat);
      }
    }
  }

  set sender(value) => _sender = value;

  /// The [Sender] of the message. If [SendbirdChatOptions.useMemberInfoInMessage] is set `true`
  /// and this message belongs to a [GroupChannel] (not a super group channel),
  /// the sender information, such as nickname and profile url, is returned as the same with the [GroupChannel.members].
  /// Otherwise, the sender information will be returned as the value of the message creation time.
  @JsonKey(name: 'user')
  Sender? get sender {
    if (_sender == null) return null;

    if (chat.chatContext.options.useMemberInfoInMessage) {
      final channel =
          chat.channelCache.find<BaseChannel>(channelKey: channelUrl);
      if (channel is GroupChannel) {
        final member = channel.getMember(_sender!.userId);
        if (member != null) {
          _sender!.nickname = member.nickname;
          _sender!.profileUrl = member.profileUrl;
          _sender!.metaData = member.metaData;
        }
      }
    }
    return _sender;
  }

  /// Whether the message is resendable.
  bool isResendable() {
    bool result = false;
    final resendableError = errorCode == SendbirdError.connectionRequired ||
        errorCode == SendbirdError.networkError ||
        errorCode == SendbirdError.ackTimeout ||
        errorCode == SendbirdError.webSocketConnectionClosed ||
        errorCode == SendbirdError.webSocketConnectionFailed ||
        errorCode == SendbirdError.fileUploadTimeout ||
        errorCode == SendbirdError.fileUploadCanceled ||
        errorCode == SendbirdError.internalServerError ||
        errorCode == SendbirdError.rateLimitExceeded ||
        errorCode == SendbirdError.socketTooManyMessages ||
        errorCode == SendbirdError.pendingError ||
        errorCode == SendbirdError.requestFailed;
    if (resendableError &&
        (sendingStatus == SendingStatus.failed ||
            sendingStatus == SendingStatus.canceled)) {
      result = true;
    }

    sbLog.i(StackTrace.current, 'return: $result');
    return result;
  }

  /// Returns [MessageMetaArray] list which is filtered by given metaArrayKeys.
  List<MessageMetaArray> getMetaArrays(List<String> keys) {
    sbLog.i(StackTrace.current, 'keys: $keys');

    if (keys.isEmpty) {
      throw InvalidParameterException();
    }

    final result = List<MessageMetaArray>.from(allMetaArrays ?? []);
    result.removeWhere((e) => !keys.contains(e.key));
    return result;
  }

  /// Applies `ReactionEvent` to message.
  bool applyReactionEvent(ReactionEvent event) {
    sbLog.i(StackTrace.current, 'event.key: ${event.key}');

    if (event.messageId != messageId) {
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

  /// Retrieves a [BaseMessage] object with a specified message ID.
  static Future<BaseMessage> getMessage(
    MessageRetrievalParams params, {
    Chat? chat,
  }) async {
    sbLog.i(StackTrace.current, 'params.messageId: ${params.messageId}');
    chat ??= SendbirdChat().chat;

    if (params.messageId <= 0) throw InvalidParameterException();

    return await chat.apiClient.send<BaseMessage>(
      ChannelMessageGetRequest(
        chat,
        channelType: params.channelType,
        channelUrl: params.channelUrl,
        messageId: params.messageId,
        params: params,
      ),
    );
  }

  /// Retrieves the threaded replies of the current message depending on the timestamp.
  /// If the current message doesn’t have replies, the result is an empty list.
  /// The result is passed to `handler` as `list`.
  ///
  /// Specifies the [timestamp] to be the reference point of the retrieval, in Unix milliseconds format.
  /// [params] for getting thread message list. See [ThreadedMessageListParams].
  Future<ThreadedMessages> getThreadedMessagesByTimestamp(
    int timestamp,
    ThreadedMessageListParams params,
  ) async {
    sbLog.i(StackTrace.current, 'timestamp: $timestamp');

    final res = await chat.apiClient.send<ChannelMessagesGetResponse>(
      ChannelMessagesGetRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
        params: params.toJson(),
        timestamp: timestamp,
        parentMessageId: messageId,
      ),
    );
    final messages = List<BaseMessage>.from(res.messages);

    return ThreadedMessages(
      parentMessage: messages.first,
      threadMessages: messages.sublist(1),
    );
  }

  /// Applies [ThreadInfoUpdateEvent] to a message.
  ///
  /// [event] from [BaseChannelHandler.onThreadInfoUpdated].
  /// Return `true` if the event has been applied successfully.
  bool applyThreadInfoUpdateEvent(ThreadInfoUpdateEvent event) {
    sbLog.i(
        StackTrace.current, 'event.parentMessageId: ${event.targetMessageId}');

    if (messageId != event.targetMessageId) return false;
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

  /// Retrieves a [BaseMessage] object with a specified scheduled message ID.
  static Future<BaseMessage> getScheduledMessage(
    ScheduledMessageRetrievalParams params, {
    Chat? chat,
  }) async {
    sbLog.i(StackTrace.current,
        'params.scheduledMessageId: ${params.scheduledMessageId}');
    chat ??= SendbirdChat().chat;

    return await chat.apiClient.send<BaseMessage>(
      GroupChannelScheduledMessageGetRequest(chat, params: params),
    );
  }

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;
    if (!(super == (other))) return false;

    final eq = const ListEquality().equals;
    return other is BaseMessage &&
        other.messageId == messageId &&
        other.message == message &&
        other.sendingStatus == sendingStatus &&
        other._sender == _sender &&
        other.isSilent == isSilent &&
        other.threadInfo == threadInfo &&
        eq(other.reactions, reactions);
  }

  @override
  int get hashCode => Object.hash(
        super.hashCode,
        messageId,
        message,
        sendingStatus,
        _sender,
        isSilent,
        parentMessageId,
        threadInfo,
        reactions,
      );

  Uint8List serialize() {
    return Uint8List.fromList(jsonEncode(toJson()).codeUnits);
  }

  static BaseMessage? buildFromSerializedData(Uint8List data) {
    final json = jsonDecode(String.fromCharCodes(data));
    if (json['message_type'] == MessageType.user.name) {
      return UserMessage.fromJson(jsonDecode(String.fromCharCodes(data)));
    } else if (json['message_type'] == MessageType.file.name) {
      return FileMessage.fromJson(jsonDecode(String.fromCharCodes(data)));
    } else if (json['message_type'] == MessageType.admin.name) {
      return AdminMessage.fromJson(jsonDecode(String.fromCharCodes(data)));
    }
    return null;
  }
}
