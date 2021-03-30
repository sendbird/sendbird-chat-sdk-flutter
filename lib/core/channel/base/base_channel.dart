import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../open/open_channel.dart';
import '../group/group_channel.dart';
import '../../message/base_message.dart';
import '../../message/file_message.dart';
import '../../message/user_message.dart';
import '../../models/command.dart';
import '../../models/error.dart';
import '../../models/sender.dart';
import '../../models/meta_array.dart';
import '../../models/responses.dart';
import '../../models/user.dart';
import '../../../constant/enums.dart';
import '../../../constant/error_code.dart';
import '../../../constant/types.dart';
import '../../../events/reaction_event.dart';
import '../../../params/file_message_params.dart';
import '../../../params/message_change_logs_params.dart';
import '../../../params/message_list_params.dart';
import '../../../params/user_message_params.dart';
import '../../../sdk/sendbird_sdk_api.dart';
import '../../../sdk/internal/sendbird_sdk_internal.dart';
import '../../../services/db/cache_service.dart';
import '../../../services/db/cached_meta_data/cached_data_map.dart';
import '../../../utils/async/async_operation.dart';
import '../../../utils/logger.dart';

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
  String name;

  /// cover image URL for this channel
  String coverUrl;

  /// User who creates this channel
  User creator;

  /// timestamp when this channel is created
  int createdAt;

  /// custom data for this channel
  String data;

  /// custom type for this channel
  String customType;

  /// Ture if this channel is frozen
  @JsonKey(name: 'freeze')
  bool isFrozen;

  /// True if this channel is ephemeral
  bool isEphemeral;

  /// local usage
  @JsonKey(ignore: true)
  bool fromCache = false;

  @JsonKey(ignore: true)
  bool dirty = false;

  /// **WARNING:** Do not use default constructor to initialize manually
  BaseChannel({
    this.channelUrl,
    this.name,
    this.coverUrl,
    this.creator,
    this.createdAt,
    this.data,
    this.customType,
    this.isFrozen,
    this.isEphemeral,
    this.fromCache,
    this.dirty,
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
      default:
        return null;
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

  /// Retrieves a list of [BaseMessage] with given [timestamp] and [params].
  Future<List<BaseMessage>> getMessagesByTimestamp(
    int timestamp,
    MessageListParams params,
  ) async {
    if (timestamp == null || timestamp <= 0) {
      throw InvalidParameterError();
    }
    if (params == null) {
      throw InvalidParameterError();
    }

    if (channelType == ChannelType.group)
      params.showSubChannelMessagesOnly = false;

    return _sdk.api.getMessages(
      channelType: channelType,
      channelUrl: channelUrl,
      params: params.toJson(),
      timestamp: timestamp,
    );
  }

  /// Retrieves a list of [BaseMessage] with given [messageId] and [params].
  Future<List<BaseMessage>> getMessagesById(
    int messageId,
    MessageListParams params,
  ) async {
    if (messageId == null || messageId <= 0) {
      throw InvalidParameterError();
    }
    if (params == null) {
      throw InvalidParameterError();
    }

    if (channelType == ChannelType.group)
      params.showSubChannelMessagesOnly = false;

    return _sdk.api.getMessages(
      channelType: channelType,
      channelUrl: channelUrl,
      params: params.toJson(),
      messageId: messageId,
    );
  }

  /// Retreieve massage change logs with [timestamp] or [token] and [params].
  Future<MessageChangeLogsResponse> getMessageChangeLogs({
    int timestamp,
    String token,
    MessageChangeLogParams params,
  }) async {
    if (params == null) {
      throw InvalidParameterError();
    }

    return _sdk.api.getMessageChangeLogs(
      channelType: channelType,
      channelUrl: channelUrl,
      params: params,
      token: token,
      timestamp: timestamp ?? double.maxFinite.round(),
    );
  }

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
