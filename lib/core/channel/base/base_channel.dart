import 'dart:async';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/constant/error_code.dart';
import 'package:sendbird_sdk/constant/types.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/channel/open/open_channel.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/message/file_message.dart';
import 'package:sendbird_sdk/core/message/user_message.dart';
import 'package:sendbird_sdk/core/models/command.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/meta_array.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/core/models/sender.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/features/reaction/reaction_event.dart';
import 'package:sendbird_sdk/params/file_message_params.dart';
import 'package:sendbird_sdk/params/message_change_logs_params.dart';
import 'package:sendbird_sdk/params/message_list_params.dart';
import 'package:sendbird_sdk/params/user_message_params.dart';
import 'package:sendbird_sdk/request/channel/file_upload_request.dart';
import 'package:sendbird_sdk/request/channel/operator_add_request.dart';
import 'package:sendbird_sdk/request/channel/operator_remove_request.dart';
import 'package:sendbird_sdk/request/channel_meta_counter/create_request.dart';
import 'package:sendbird_sdk/request/channel_meta_counter/delete_request.dart';
import 'package:sendbird_sdk/request/channel_meta_counter/get_request.dart';
import 'package:sendbird_sdk/request/channel_meta_counter/update_request.dart';
import 'package:sendbird_sdk/request/channel_meta_data/get_request.dart';
import 'package:sendbird_sdk/request/channel_meta_data/create_request.dart';
import 'package:sendbird_sdk/request/channel_meta_data/delete_request.dart';
import 'package:sendbird_sdk/request/channel_meta_data/update_request.dart';
import 'package:sendbird_sdk/request/messages/file_message_send_request.dart';
import 'package:sendbird_sdk/request/messages/message_change_log_get_request.dart';
import 'package:sendbird_sdk/request/messages/message_delete_request.dart';
import 'package:sendbird_sdk/request/messages/message_translate_request.dart';
import 'package:sendbird_sdk/request/messages/messages_get_request.dart';
import 'package:sendbird_sdk/request/moderation/channel_my_mute_info_get_request.dart';
import 'package:sendbird_sdk/request/moderation/channel_user_ban_request.dart';
import 'package:sendbird_sdk/request/moderation/channel_user_mute_request.dart';
import 'package:sendbird_sdk/request/moderation/channel_user_unban_request.dart';
import 'package:sendbird_sdk/request/moderation/channel_user_unmute_request.dart';
import 'package:sendbird_sdk/request/reaction/channel_reaction_add_request.dart';
import 'package:sendbird_sdk/request/reaction/channel_reaction_remove_request.dart';
import 'package:sendbird_sdk/request/report/channel_report_request.dart';
import 'package:sendbird_sdk/request/report/message_report_request.dart';
import 'package:sendbird_sdk/request/report/user_report_request.dart';
import 'package:sendbird_sdk/sdk/internal/sendbird_sdk_internal.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:sendbird_sdk/services/db/cache_service.dart';
import 'package:sendbird_sdk/services/db/cached_meta_data/cached_data_map.dart';
import 'package:sendbird_sdk/utils/async/async_operation.dart';
import 'package:sendbird_sdk/utils/logger.dart';
import 'package:uuid/uuid.dart';

part 'base_channel_configuration.dart';
part 'base_channel_messages.dart';
part 'base_channel_meta.dart';
part 'base_channel_moderation.dart';
part 'base_channel_reaction.dart';

/// Represents base channel
///
/// This class contains properties and methods for both [GroupChannel] and
/// [OpenChannel]. Note that this is base class for two offical types -
/// group and open - so you won't have any given channel that only derives
/// from this class.
class BaseChannel implements Cacheable {
  /// This channel url
  String channelUrl;

  /// name for this channel
  String? name;

  /// cover image URL for this channel
  String? coverUrl;

  /// User who creates this channel
  @JsonKey(name: 'created_by')
  User? creator;

  /// timestamp when this channel is created
  int? createdAt;

  /// custom data for this channel
  String? data;

  /// custom type for this channel
  String? customType;

  /// Ture if this channel is frozen
  @JsonKey(defaultValue: false, name: 'freeze')
  bool isFrozen;

  /// True if this channel is ephemeral
  @JsonKey(defaultValue: false)
  bool isEphemeral;

  /// local usage
  @JsonKey(ignore: true)
  bool fromCache = false;

  @JsonKey(ignore: true)
  @override
  bool dirty;

  /// **WARNING:** Do not use default constructor to initialize manually
  BaseChannel({
    required this.channelUrl,
    this.creator,
    this.createdAt,
    this.name,
    this.coverUrl,
    this.data,
    this.customType,
    this.isFrozen = false,
    this.isEphemeral = false,
    this.fromCache = false,
    this.dirty = false,
  });

  SendbirdSdkInternal get _sdk => SendbirdSdk().getInternal();

  /// Channel type for this channel
  ChannelType get channelType =>
      this is GroupChannel ? ChannelType.group : ChannelType.open;

  /// Returns channel with given [type] and [channelUrl]
  static Future<BaseChannel> getBaseChannel(
    ChannelType type,
    String channelUrl,
  ) async {
    switch (type) {
      case ChannelType.group:
        return GroupChannel.getChannel(channelUrl);
      case ChannelType.open:
        return OpenChannel.getChannel(channelUrl);
    }
  }

  /// Refreshes this channel instance
  static Future<BaseChannel> refreshChannel(
    ChannelType channelType,
    String channelUrl,
  ) async {
    if (channelType == ChannelType.group) {
      return GroupChannel.refresh(channelUrl);
    } else {
      return OpenChannel.refresh(channelUrl);
    }
  }

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;

    return other is BaseChannel &&
        other.channelUrl == channelUrl &&
        other.name == name &&
        other.coverUrl == coverUrl &&
        other.creator == creator &&
        other.createdAt == createdAt &&
        other.data == data &&
        other.customType == customType &&
        other.isFrozen == isFrozen &&
        other.isEphemeral == isEphemeral;
  }

  @override
  int get hashCode => hashValues(
        channelUrl,
        name,
        coverUrl,
        creator,
        createdAt,
        data,
        customType,
        isFrozen,
        isEphemeral,
      );

  // Cacheable

  @override
  String get key => 'channel/' + channelType.toString() + channelUrl;

  @override
  String get primaryKey => channelUrl;

  @override
  void copyWith(others) {
    if (others is! BaseChannel) return;

    channelUrl = others.channelUrl;
    name = others.name;
    coverUrl = others.coverUrl;
    creator = others.creator;
    createdAt = others.createdAt;
    data = others.data;
    customType = others.customType;
  }
}
