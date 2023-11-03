// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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
import 'package:sendbird_chat_sdk/src/public/core/channel/feed_channel/feed_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/open_channel/open_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/base_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/file_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
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

  /// The creation time of the channel.
  int? createdAt;

  /// The cover image URL.
  String get coverUrl {
    checkUnsupportedAction();
    return _coverUrl;
  }

  set coverUrl(value) {
    checkUnsupportedAction();
    _coverUrl = value;
  }

  /// The channel data.
  String get data {
    checkUnsupportedAction();
    return _data;
  }

  set data(value) {
    checkUnsupportedAction();
    _data = value;
  }

  /// The custom type of the channel.
  String get customType {
    checkUnsupportedAction();
    return _customType;
  }

  set customType(value) {
    checkUnsupportedAction();
    _customType = value;
  }

  /// Whether the channel is frozen.
  @JsonKey(name: 'freeze')
  bool get isFrozen {
    checkUnsupportedAction();
    return _isFrozen;
  }

  set isFrozen(value) {
    checkUnsupportedAction();
    _isFrozen = value;
  }

  /// Whether the channel is ephemeral.
  bool get isEphemeral {
    checkUnsupportedAction();
    return _isEphemeral;
  }

  set isEphemeral(value) {
    checkUnsupportedAction();
    _isEphemeral = value;
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  String _coverUrl;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String _data;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String _customType;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool _isFrozen;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool _isEphemeral;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool fromCache = false;

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  bool dirty;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late Chat chat;

  BaseChannel({
    required this.channelUrl,
    this.name = '',
    this.createdAt,
    coverUrl = '',
    data = '',
    customType = '',
    isFrozen = false,
    isEphemeral = false,
    this.fromCache = false,
    this.dirty = false,
  })  : _coverUrl = coverUrl,
        _data = data,
        _customType = customType,
        _isFrozen = isFrozen,
        _isEphemeral = isEphemeral;

  /// ChannelType
  ChannelType get channelType => this is GroupChannel
      ? ChannelType.group
      : this is OpenChannel
          ? ChannelType.open
          : ChannelType.feed;

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

    if (this is FeedChannel) {
      (this as FeedChannel).lastMessage?.set(chat);
      for (final element in (this as FeedChannel).members) {
        element.set(chat);
      }
    }
  }

  static Future<BaseChannel> getBaseChannel(
    ChannelType channelType,
    String channelUrl, {
    Chat? chat,
  }) async {
    switch (channelType) {
      case ChannelType.group:
        return GroupChannel.getChannel(channelUrl, chat: chat);
      case ChannelType.open:
        return OpenChannel.getChannel(channelUrl, chat: chat);
      case ChannelType.feed:
        return FeedChannel.getChannel(channelUrl, chat: chat);
    }
  }

  static Future<BaseChannel> refreshChannel(
    ChannelType channelType,
    String channelUrl, {
    Chat? chat,
  }) async {
    switch (channelType) {
      case ChannelType.group:
        return GroupChannel.refresh(channelUrl, chat: chat);
      case ChannelType.open:
        return OpenChannel.refresh(channelUrl, chat: chat);
      case ChannelType.feed:
        return FeedChannel.refresh(channelUrl, chat: chat);
    }
  }

  void checkUnsupportedAction() {
    if (channelType == ChannelType.feed) {
      throw NotSupportedException();
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
  void copyWith(dynamic other) {
    if (other is! BaseChannel) return;

    channelUrl = other.channelUrl;
    name = other.name;
    createdAt = other.createdAt;
    _coverUrl = other._coverUrl;
    _data = other._data;
    _customType = other._customType;
    _isFrozen = other._isFrozen;
    _isEphemeral = other._isEphemeral;

    fromCache = other.fromCache;
    dirty = other.dirty;
  }

  Map<String, dynamic> toJson();

  Uint8List serialize() {
    return Uint8List.fromList(jsonEncode(toJson()).codeUnits);
  }

  static BaseChannel? buildFromSerializedData(Uint8List data) {
    final json = jsonDecode(String.fromCharCodes(data));
    if (json['channel_type'] == ChannelType.group.name) {
      return GroupChannel.fromJson(jsonDecode(String.fromCharCodes(data)));
    } else if (json['channel_type'] == ChannelType.open.name) {
      return OpenChannel.fromJson(jsonDecode(String.fromCharCodes(data)));
    } else if (json['channel_type'] == ChannelType.feed.name) {
      return FeedChannel.fromJson(jsonDecode(String.fromCharCodes(data)));
    }
    return null;
  }
}
