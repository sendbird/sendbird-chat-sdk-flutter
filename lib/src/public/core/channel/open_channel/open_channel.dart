// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_cache/cache_service.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/open_channel/open_channel_create_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/open_channel/open_channel_delete_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/open_channel/open_channel_refresh_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/open_channel/open_channel_update_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/websocket/command/command.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/base_channel/base_channel.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/user.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/channel/open_channel_create_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/channel/open_channel_update_params.dart';

part 'open_channel.g.dart';
part 'open_channel_operation.dart';

/// Represents an open channel.
@JsonSerializable()
class OpenChannel extends BaseChannel {
  /// The total number of participants in this channel.
  int participantCount;

  /// The operators of the channel.
  @JsonKey(defaultValue: [])
  List<User> operators;

  OpenChannel({
    required this.participantCount,
    required this.operators,
    required String channelUrl,
    String name = '',
    String coverUrl = '',
    int? createdAt,
    String data = '',
    String customType = '',
    bool isFrozen = false,
    bool isEphemeral = false,
  }) : super(
          channelUrl: channelUrl,
          name: name,
          coverUrl: coverUrl,
          createdAt: createdAt,
          data: data,
          customType: customType,
          isFrozen: isFrozen,
          isEphemeral: isEphemeral,
          fromCache: false,
          dirty: false,
        );

  /// Gets a `OpenChannel` with given channel URL.
  static Future<OpenChannel> getChannel(
    String channelUrl, {
    Chat? chat,
  }) async {
    sbLog.i(StackTrace.current, 'channelUrl: $channelUrl');
    chat ??= SendbirdChat().chat;

    final channel = chat.channelCache.find<OpenChannel>(channelKey: channelUrl);
    if (channel != null && !channel.dirty) {
      channel.fromCache = true;
      return channel;
    }

    return await OpenChannel.refresh(channelUrl, chat: chat);
  }

  /// Refreshes all the data of this channel.
  static Future<OpenChannel> refresh(
    String channelUrl, {
    Chat? chat,
  }) async {
    sbLog.i(StackTrace.current, 'channelUrl: $channelUrl');
    chat ??= SendbirdChat().chat;

    final channel = await chat.apiClient.send<OpenChannel>(
      OpenChannelRefreshRequest(
        chat,
        channelUrl: channelUrl,
        options: [ChannelListQueryIncludeOption.includeMetadata],
        passive: false,
      ),
    );
    return channel;
  }

  /// Creates new `OpenChannel` with OpenChannelParams.
  static Future<OpenChannel> createChannel(
    OpenChannelCreateParams params, {
    ProgressHandler? progressHandler,
    Chat? chat,
  }) async {
    sbLog.i(StackTrace.current,
        'params.operatorUserIds: ${params.operatorUserIds}');
    chat ??= SendbirdChat().chat;

    return await chat.apiClient.send<OpenChannel>(OpenChannelCreateRequest(
        chat, params,
        progressHandler: progressHandler));
  }

  /// The custom type of the channel.
  /// You can set custom type of this channel by [createChannel] or [updateChannel].
  Future<OpenChannel> updateChannel(
    OpenChannelUpdateParams params, {
    ProgressHandler? progressHandler,
  }) async {
    sbLog.i(StackTrace.current, 'params.name: ${params.name}');

    return await chat.apiClient.send<OpenChannel>(OpenChannelUpdateRequest(
        chat, channelUrl, params,
        progressHandler: progressHandler));
  }

  /// Deletes an `OpenChannel`.
  /// Note that only operators of a channel are able to delete it or else, an error will be returned to the handler.
  Future<void> deleteChannel() async {
    sbLog.i(StackTrace.current);

    await chat.apiClient.send(OpenChannelDeleteRequest(chat, channelUrl));
    removeFromCache(chat);
  }

  /// Checks if the given [userId] is an operator id of this channel.
  bool isOperator(String userId) {
    sbLog.i(StackTrace.current, 'userId: $userId');
    return operators.where((e) => e.userId == userId).isNotEmpty;
  }

  factory OpenChannel.fromJson(Map<String, dynamic> json) {
    return _$OpenChannelFromJson(json)
      ..set(SendbirdChat().chat); // Set the singleton chat
  }

  factory OpenChannel.fromJsonWithChat(Chat chat, Map<String, dynamic> json) {
    return OpenChannel.fromJson(json)..set(chat);
  }

  @override
  Map<String, dynamic> toJson() {
    final json = _$OpenChannelToJson(this);
    json['channel_type'] = ChannelType.open.name; // Check
    return json;
  }

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;
    if (!(super == (other))) return false;

    final eq = const ListEquality().equals;
    return other is OpenChannel &&
        other.participantCount == participantCount &&
        eq(other.operators, operators);
  }

  @override
  int get hashCode => Object.hash(
        super.hashCode,
        participantCount,
        operators,
      );

  @override
  void copyWith(dynamic other) {
    super.copyWith(other);
    if (other is OpenChannel) {
      participantCount = other.participantCount;
      operators = List<User>.from(other.operators);
    }
  }
}
