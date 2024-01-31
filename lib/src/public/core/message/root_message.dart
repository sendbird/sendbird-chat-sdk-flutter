// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/type_checker.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/command/command_type.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/admin_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/file_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/notification_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/user_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/message_meta_array.dart';

/// Class representing a root message.
class RootMessage {
  /// The channel URL of the channel this message belongs to.
  String channelUrl;

  /// The [ChannelType] of the channel this message belongs to.
  @JsonKey(defaultValue: ChannelType.group, unknownEnumValue: ChannelType.group)
  ChannelType channelType;

  /// The custom data of the message.
  @JsonKey(fromJson: TypeChecker.fromJsonToNullableString)
  String? data;

  /// The custom type of the message.
  String? customType;

  /// The mention type. Refer to [MentionType].
  @JsonKey(unknownEnumValue: MentionType.users)
  MentionType mentionType;

  @JsonKey(name: 'mentioned_users', defaultValue: [])
  List<User> _mentionedUsers;

  /// The mentioned users of the message.
  List<User> get mentionedUsers {
    if (chat.chatContext.options.useMemberInfoInMessage) {
      final channel =
          chat.channelCache.find<BaseChannel>(channelKey: channelUrl);
      if (channel is GroupChannel) {
        for (final mentionedUser in _mentionedUsers) {
          final member = channel.getMember(mentionedUser.userId);
          if (member != null) {
            mentionedUser.nickname = member.nickname;
            mentionedUser.profileUrl = member.profileUrl;
            mentionedUser.metaData = member.metaData;
          }
        }
      }
    }
    return _mentionedUsers;
  }

  /// All [MessageMetaArray]s of the message.
  @JsonKey(name: 'sorted_metaarray')
  List<MessageMetaArray>? allMetaArrays;

  /// [extendedMessage] is used for Sendbird UiKit.
  /// Only featured in [GroupChannel]
  @JsonKey(name: "extended_message", defaultValue: {})
  Map<String, dynamic> extendedMessage;

  /// The creation time of the message in milliseconds.
  int createdAt;

  /// The updated time of the message in milliseconds.
  int updatedAt;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late Chat chat;

  RootMessage({
    required this.channelUrl,
    required this.channelType,
    this.data,
    this.customType,
    this.mentionType = MentionType.users,
    List<User> mentionedUsers = const <User>[],
    this.allMetaArrays,
    Map<String, dynamic>? extendedMessage,
    this.createdAt = 0,
    this.updatedAt = 0,
  })  : _mentionedUsers = mentionedUsers,
        extendedMessage = extendedMessage ?? {};

  void set(Chat chat) {
    this.chat = chat;

    for (final element in _mentionedUsers) {
      element.set(chat);
    }
  }

  set mentionedUsers(value) => _mentionedUsers = value;

  dynamic getMessageId() {
    if (this is NotificationMessage) {
      return (this as NotificationMessage).notificationId;
    }

    // BaseMessage
    return (this as BaseMessage).messageId;
  }

  MessageType get messageType => this is UserMessage
      ? MessageType.user
      : this is FileMessage
          ? MessageType.file
          : this is AdminMessage
              ? MessageType.admin
              : this is NotificationMessage
                  ? MessageType.notification
                  : throw MalformedDataException();

  String get rootId {
    if (this is BaseMessage) {
      return (this as BaseMessage).messageId.toString();
    } else if (this is NotificationMessage) {
      return (this as NotificationMessage).notificationId;
    }
    throw MalformedDataException();
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  static RootMessage getMessageFromJsonWithChat<T extends BaseMessage>(
    Chat chat,
    Map<String, dynamic> json, {
    ChannelType? channelType,
    String? commandType,
  }) {
    return _fromJson<T>(
      json,
      chat: chat,
      channelType: channelType,
      commandType: commandType,
    );
  }

  static RootMessage fromJson(Map<String, dynamic> json) {
    return _fromJson<BaseMessage>(json);
  }

  static RootMessage fromJsonWithChat(Chat chat, Map<String, dynamic> json) {
    return RootMessage.fromJson(json)..set(chat);
  }

  static RootMessage _fromJson<T extends BaseMessage>(
    Map<String, dynamic> json, {
    Chat? chat,
    ChannelType? channelType,
    String? commandType,
  }) {
    // BaseMessage backward compatibility
    if (json['custom'] != null) json['data'] = json['custom'];
    if (json['ts'] != null) json['created_at'] = json['ts'];
    if (json['msg_id'] != null) json['message_id'] = json['msg_id'];
    if (json['req_id'] != null) json['request_id'] = json['req_id'];

    // Insert type if channel is provided manually
    if (channelType != null) {
      json['channel_type'] = channelType.asString();
    }

    // NotificationMessage
    if (json['notification_message_id'] != null &&
        (json['notification_message_id'] as String).isNotEmpty) {
      return NotificationMessage.fromJsonWithChat(chat, json);
    }

    // Insert reply_to_channel manually
    if (json['reply_to_channel'] != null) {
      json['is_reply_to_channel'] = json['reply_to_channel'];
    }

    String? type = commandType;
    if (type == null) {
      final Map<String, dynamic>? file = json['file'];
      if (file != null && file.isNotEmpty) {
        // The 'type' value of FileMessage payload can be 'FILE' or 'image/jpeg'.
        type = CommandType.fileMessage.value;
      } else {
        type = json['type'] as String;
      }
    }

    // final type = commandType ?? json['type'] as String;

    BaseMessage message;
    if (chat != null) {
      if (T == UserMessage || CommandString.isUserMessage(type)) {
        message = UserMessage.fromJsonWithChat(chat, json) as T;
      } else if (T == FileMessage || CommandString.isFileMessage(type)) {
        message = FileMessage.fromJsonWithChat(chat, json) as T;
      } else if (T == AdminMessage || CommandString.isAdminMessage(type)) {
        message = AdminMessage.fromJsonWithChat(chat, json) as T;
      } else {
        throw InvalidMessageTypeException();
      }
    } else {
      if (CommandString.isUserMessage(type)) {
        message = UserMessage.fromJson(json);
      } else if (CommandString.isFileMessage(type)) {
        message = FileMessage.fromJson(json);
      } else if (CommandString.isAdminMessage(type)) {
        message = AdminMessage.fromJson(json);
      } else {
        throw InvalidMessageTypeException();
      }
    }

    final metaArray = json['metaarray'];
    final metaArrayKeys = List<String>.from(json['metaarray_key_order'] ?? []);

    // NOTE: sorted_metaarray is from API, metaarray list is local,
    // metaarray map is from Web, so had to handle separately.
    if (metaArray is List) {
      // Local cmd case
      message.allMetaArrays = metaArray
          .map((e) => MessageMetaArray.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (metaArray is Map && metaArrayKeys.isNotEmpty) {
      // WebSocket cmd result case
      message.allMetaArrays = metaArrayKeys.map((e) {
        final value = List<String>.from(metaArray[e]);
        return MessageMetaArray(key: e, value: value);
      }).toList();
    }

    return message as T;
  }

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;

    final eq = const ListEquality().equals;
    final mapEq = const MapEquality().equals;
    return other is RootMessage &&
        other.channelUrl == channelUrl &&
        other.channelType == channelType &&
        other.data == data &&
        other.customType == customType &&
        other.mentionType == mentionType &&
        eq(other._mentionedUsers, _mentionedUsers) &&
        eq(other.allMetaArrays, allMetaArrays) &&
        mapEq(other.extendedMessage, extendedMessage) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode => Object.hash(
        channelUrl,
        channelType,
        data,
        customType,
        channelUrl,
        channelType,
        mentionType,
        _mentionedUsers,
        allMetaArrays,
        extendedMessage,
        createdAt,
        updatedAt,
      );
}

enum MessageType {
  user,
  file,
  admin,
  notification,
}
