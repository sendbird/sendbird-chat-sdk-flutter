// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/poll/poll_option_get_request.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/group_channel/group_channel.dart';
import 'package:sendbird_chat_sdk/src/public/main/chat/sendbird_chat.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/poll/poll.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/poll/poll_option_retrieval_params.dart';

part 'poll_option.g.dart';

/// Class representing a poll option.
/// A poll options can be created by [Poll.create] and [GroupChannelPoll.addPollOption].
/// [text] is the only field set by the client.
/// Other fields can be set by the server and voting.
///
/// A latest poll option instance can be fetched using [Poll.get] and
/// a poll option can be updated using [GroupChannelPoll.updatePoll].
@JsonSerializable()
class PollOption {
  /// A unique identifier for the poll which contains this poll option.
  final int pollId;

  /// A unique identifier for this poll option.
  final int id;

  /// Representing text of this poll option.
  final String text;

  /// UserId of the poll option creator.
  String? createdBy;

  /// Unix timestamp at which the poll option is created.
  final int createdAt;

  /// Voter count of this poll option.
  int voteCount;

  /// Unix timestamp at which the poll option is updated (ms).
  int updatedAt;

  PollOption({
    required this.pollId,
    required this.id,
    required this.text,
    this.createdBy,
    required this.createdAt,
    required this.voteCount,
    required this.updatedAt,
  });

  /// Fetches latest [PollOption] representation from the server.
  static Future<PollOption> get(
    PollOptionRetrievalParams params, {
    Chat? chat,
  }) async {
    sbLog.i(StackTrace.current, 'params.pollId: ${params.pollId}');
    chat ??= SendbirdChat().chat;

    return await chat.apiClient.send(PollOptionGetRequest(
      chat,
      channelType: params.channelType,
      channelUrl: params.channelUrl,
      pollOptionId: params.pollOptionId,
      pollId: params.pollId,
    ));
  }

  factory PollOption.fromJson(Map<String, dynamic> json) {
    return _$PollOptionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PollOptionToJson(this);

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;

    return other is PollOption &&
        other.id == id &&
        other.text == text &&
        other.pollId == pollId &&
        other.voteCount == voteCount &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode => Object.hash(
        id,
        text,
        pollId,
        voteCount,
        createdAt,
        updatedAt,
      );
}
