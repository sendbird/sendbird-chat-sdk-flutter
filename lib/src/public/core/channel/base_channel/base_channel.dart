// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/channel/meta_data_cache.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/collection_manager/collection_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/async/async_task.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/channel_meta_counter/channel_meta_counter_create_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/channel_meta_counter/channel_meta_counter_delete_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/channel_meta_counter/channel_meta_counter_get_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/channel_meta_counter/channel_meta_counter_update_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/channel_meta_data/channel_meta_data_create_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/channel_meta_data/channel_meta_data_delete_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/channel_meta_data/channel_meta_data_get_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/channel_meta_data/channel_meta_data_update_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/moderation/channel_my_mute_info_get_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/moderation/channel_user_ban_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/moderation/channel_user_mute_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/moderation/channel_user_unban_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/group_channel/moderation/channel_user_unmute_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/message/channel_file_message_send_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/message/channel_file_upload_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/message/channel_message_change_log_get_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/message/channel_message_delete_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/message/channel_message_translate_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/message/channel_messages_get_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/operator/channel_operator_add_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/operator/channel_operator_remove_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/reaction/channel_reaction_add_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/reaction/channel_reaction_remove_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/report/channel_report_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/report/message_report_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/report/user_report_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/response/responses.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/command/command.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/open_channel/open_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/file_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/user_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/sender.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/sendbird_error.dart';
import 'package:sendbird_chat_sdk/src/public/main/handler/channel_handler.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/info/mute_info.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/message_change_logs.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/message/message_meta_array.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/reaction/reaction_event.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/file_message_create_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/file_message_update_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/message_change_logs_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/message_list_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/user_message_create_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/user_message_update_params.dart';
import 'package:uuid/uuid.dart';

part 'base_channel_message.dart';
part 'base_channel_message_meta_array.dart';
part 'base_channel_meta_counters.dart';
part 'base_channel_meta_data.dart';
part 'base_channel_moderation.dart';
part 'base_channel_operator.dart';
part 'base_channel_reaction.dart';

/// Objects representing a channel.
abstract class BaseChannel implements Cacheable {
  /// The unique channel URL.
  String channelUrl;

  /// The topic or name of the channel.
  String name;

  /// The cover image URL.
  String coverUrl;

  /// The creation time of the channel.
  int? createdAt;

  /// The channel data.
  String data;

  /// The custom type of the channel.
  String customType;

  /// Whether the channel is frozen.
  @JsonKey(name: 'freeze')
  bool isFrozen;

  /// Whether the channel is ephemeral.
  bool isEphemeral;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool fromCache = false;

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  bool dirty;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late Chat chat;

  BaseChannel({
    required this.channelUrl,
    this.createdAt,
    this.name = '',
    this.coverUrl = '',
    this.data = '',
    this.customType = '',
    this.isFrozen = false,
    this.isEphemeral = false,
    this.fromCache = false,
    this.dirty = false,
  });

  /// ChannelType
  ChannelType get channelType =>
      this is GroupChannel ? ChannelType.group : ChannelType.open;

  void set(Chat chat) {
    this.chat = chat;

    if (this is GroupChannel) {
      (this as GroupChannel).lastMessage?.set(chat);
      (this as GroupChannel).creator?.set(chat);
      (this as GroupChannel).inviter?.set(chat);
      for (final element in (this as GroupChannel).members) {
        element.set(chat);
      }
    }

    if (this is OpenChannel) {
      for (final element in (this as OpenChannel).operators) {
        element.set(chat);
      }
    }
  }

  static Future<BaseChannel> getBaseChannel(
    ChannelType type,
    String channelUrl, {
    Chat? chat,
  }) async {
    switch (type) {
      case ChannelType.group:
        return GroupChannel.getChannel(channelUrl, chat: chat);
      case ChannelType.open:
        return OpenChannel.getChannel(channelUrl, chat: chat);
    }
  }

  static Future<BaseChannel> refreshChannel(
    ChannelType channelType,
    String channelUrl, {
    Chat? chat,
  }) async {
    if (channelType == ChannelType.group) {
      return GroupChannel.refresh(channelUrl, chat: chat);
    } else {
      return OpenChannel.refresh(channelUrl, chat: chat);
    }
  }

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;

    return other is BaseChannel &&
        other.channelUrl == channelUrl &&
        other.name == name &&
        other.coverUrl == coverUrl &&
        other.createdAt == createdAt &&
        other.data == data &&
        other.customType == customType &&
        other.isFrozen == isFrozen &&
        other.isEphemeral == isEphemeral;
  }

  @override
  int get hashCode => Object.hash(
        channelUrl,
        name,
        coverUrl,
        createdAt,
        data,
        customType,
        isFrozen,
        isEphemeral,
      );

  @override
  String get key => 'channel/$channelType$channelUrl';

  @override
  String get primaryKey => channelUrl;

  @override
  void copyWith(others) {
    if (others is! BaseChannel) return;

    channelUrl = others.channelUrl;
    name = others.name;
    coverUrl = others.coverUrl;
    createdAt = others.createdAt;
    data = others.data;
    customType = others.customType;
    isFrozen = others.isFrozen;
    isEphemeral = others.isEphemeral;

    fromCache = others.fromCache;
    dirty = others.dirty;
  }
}
