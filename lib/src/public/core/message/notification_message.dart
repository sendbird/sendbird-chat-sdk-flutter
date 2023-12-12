// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/type_checker.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/message_meta_array.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/notification_data.dart';

part 'notification_message.g.dart';

/// Class representing a notification message.
/// @since 4.1.0
@JsonSerializable()
class NotificationMessage extends RootMessage {
  /// notificationId
  @JsonKey(name: 'notification_message_id')
  final String notificationId;

  /// notificationMessageStatus
  @JsonKey(
    fromJson: _messageStatusValueOf,
    name: 'message_status',
    defaultValue: NotificationMessageStatus.sent,
  )
  NotificationMessageStatus messageStatus;

  /// notificationData
  @JsonKey(includeFromJson: false, includeToJson: false)
  NotificationData? notificationData;

  NotificationMessage({
    required super.channelUrl,
    required super.channelType,
    required this.notificationId,
    required this.messageStatus,
    super.data,
    super.customType,
    super.mentionType,
    super.mentionedUsers,
    super.allMetaArrays,
    super.extendedMessage,
    super.createdAt,
    super.updatedAt,
  });

  factory NotificationMessage.fromJson(Map<String, dynamic> json) {
    return NotificationMessage.fromJsonWithChat(SendbirdChat().chat, json);
  }

  factory NotificationMessage.fromJsonWithChat(
    Chat? chat,
    Map<String, dynamic> json,
  ) {
    final message = _$NotificationMessageFromJson(json);

    // notificationData
    if (message.extendedMessage.isNotEmpty) {
      if (message.extendedMessage['sub_type'] != null &&
          (message.extendedMessage['sub_type'] as int) == 0) {
        final subData = message.extendedMessage['sub_data'];
        if (subData != null) {
          Map<String, dynamic>? subDataMap = jsonDecode(subData);
          if (subDataMap != null) {
            final List<String>? tags = (subDataMap['tags'] as List<dynamic>?)
                ?.map((value) => value as String)
                .toList();

            message.notificationData = NotificationData(
              templateKey: subDataMap['template_key'] as String? ?? '',
              templateVariables:
                  subDataMap['template_variables'] as Map<String, dynamic>? ??
                      {},
              label: subDataMap['label'] as String?,
              tags: tags,
            );
          }
        }
      }
    }
    return message..set(chat ?? SendbirdChat().chat); // Set the singleton chat
  }

  @override
  Map<String, dynamic> toJson() {
    final json = _$NotificationMessageToJson(this);
    json['message_type'] = MessageType.admin.name; // Check
    // Check: notificationData
    return json;
  }

  static NotificationMessageStatus _messageStatusValueOf(String value) {
    switch (value) {
      case 'SENT':
        return NotificationMessageStatus.sent;
      case 'READ':
        return NotificationMessageStatus.read;
      default:
        return NotificationMessageStatus.sent;
    }
  }
}
