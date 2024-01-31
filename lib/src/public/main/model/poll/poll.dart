// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/poll/poll_create_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/poll/poll_get_request.dart';

part 'poll.g.dart';

/// Class representing a poll.
/// A poll instance can be created using [Poll.create] with [PollCreateParams] and
/// updated using [GroupChannelPoll.updatePoll] with [PollUpdateParams] class.
/// A poll can be attached to a message using [UserMessageCreateParams.pollId].
@JsonSerializable()
class Poll {
  /// A unique identifier for this poll.
  final int id;

  /// Title of the poll.
  @JsonKey(defaultValue: '')
  String title;

  /// Unix timestamp at which the poll is created (ms).
  final int createdAt;

  /// Unix timestamp at which the poll is updated (ms).
  int updatedAt;

  /// Unix timestamp at which the poll has closed or will close. (second precision)
  /// If poll closing time is not specified, this value will be `-1`.
  int closeAt = -1;

  /// Indicates whether this poll is [PollStatus.open], or [PollStatus.closed]
  PollStatus status;

  /// A id of the message that contains this poll
  int? messageId;

  /// An additional json data to accompany the poll.
  PollData? data;

  /// Total voter count.
  int voterCount = -1;

  /// Options for this poll.
  List<PollOption> options = [];

  /// UserId of the poll creator. `null` if the creator account is removed.
  String? createdBy;

  /// True if this poll allows user suggestion, false otherwise.
  bool allowUserSuggestion = false;

  /// True if this poll allows multiple votes, false otherwise.
  bool allowMultipleVotes = false;

  /// Contains optionIds which the current user voted on.
  /// If the current user has not voted, this list will be empty.
  @JsonKey(defaultValue: [])
  List<int>? votedPollOptionIds;

  Poll({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.closeAt,
    required this.status,
    this.messageId,
    this.data,
    this.voterCount = -1,
    this.options = const [],
    this.createdBy,
    this.allowUserSuggestion = false,
    this.allowMultipleVotes = false,
    this.votedPollOptionIds,
  });

  /// Builds [Poll] instance with given [params] instance.
  static Future<Poll> create(
    PollCreateParams params, {
    Chat? chat,
  }) async {
    sbLog.i(StackTrace.current, 'params.title: ${params.title}');
    chat ??= SendbirdChat().chat;

    return await chat.apiClient.send(PollCreateRequest(chat, params: params));
  }

  /// Retrieves latest poll matching [PollRetrievalParams.pollId] instance from server.
  static Future<Poll> get(
    PollRetrievalParams params, {
    Chat? chat,
  }) async {
    sbLog.i(StackTrace.current, 'params.pollId: ${params.pollId}');
    chat ??= SendbirdChat().chat;

    return await chat.apiClient.send(PollGetRequest(
      chat,
      channelUrl: params.channelUrl,
      pollId: params.pollId,
      channelType: params.channelType,
    ));
  }

  /// Applies poll update event to this user message's poll.
  bool applyPollUpdateEvent(PollUpdateEvent event) {
    sbLog.i(StackTrace.current, 'event: $event');

    if (id != event.pollId) {
      return false;
    } else if (updatedAt < event.json['ts']) {
      // Replace all event here
      if (event.json['poll']['title'] != null) {
        title = event.json['poll']['title'];
      }
      if (event.json['poll']['close_at'] != null) {
        closeAt = event.json['poll']['close_at'];
      }
      if (event.json['poll']['status'] != null) {
        switch (event.json['poll']['status']) {
          case 'open':
            status = PollStatus.open;
            break;
          case 'closed':
            status = PollStatus.closed;
            break;
        }
      }
      if (event.json['poll']['data'] != null) {
        data = PollData(text: event.json['poll']['data']['text']);
      }
      if (event.json['poll']['voter_count'] != null) {
        voterCount = event.json['poll']['voter_count'];
      }
      if (event.json['poll']['options'] != null) {
        List<PollOption> list = [];
        for (var pollOption in event.json['poll']['options']) {
          list.add(PollOption.fromJson(pollOption));
        }
        options = list;
      }

      if (event.json['poll']['allow_user_suggestion'] != null) {
        allowUserSuggestion = event.json['poll']['allow_user_suggestion'];
      }
      if (event.json['poll']['allow_multiple_votes'] != null) {
        allowMultipleVotes = event.json['poll']['allow_multiple_votes'];
      }
      if (event.json['poll']['voted_poll_option_ids'] != null) {
        votedPollOptionIds = event.json['poll']['voted_poll_option_ids'];
      }

      return true;
    } else {
      return false;
    }
  }

  /// Applies poll vote event to this user message's poll.
  bool applyPollVoteEvent(PollVoteEvent event) {
    sbLog.i(StackTrace.current, 'event: $event');

    if (id != event.pollId) {
      return false;
    } else if (updatedAt < event.json['ts']) {
      // Replace all event here
      if (event.json['updated_vote_counts'] != null) {
        // go through each list and update
        for (final element in (event.json['updated_vote_counts'] as List)) {
          int optionId = element['option_id'];
          int voteCount = element['vote_count'];
          options.firstWhere((e) => (e.id == optionId)).voteCount = voteCount;
        }
      }
    } else {
      return false;
    }
    return true;
  }

  factory Poll.fromJson(Map<String, dynamic> json) {
    var poll = _$PollFromJson(json);
    return poll;
  }

  Map<String, dynamic> toJson() => _$PollToJson(this);

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;

    return other is Poll && other.id == id && other.title == title;
  }

  @override
  int get hashCode => Object.hash(
        id,
        title,
      );
}
