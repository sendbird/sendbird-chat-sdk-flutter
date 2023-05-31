// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'group_channel.dart';

/// GroupChannelPoll
extension GroupChannelPoll on GroupChannel {
  /// Updates fields of this poll with given [params].
  Future<Poll> updatePoll({
    required int pollId,
    required PollUpdateParams params,
  }) async {
    sbLog.i(StackTrace.current, 'pollId: $pollId');

    return await chat.apiClient.send(PollUpdateRequest(
      chat,
      pollId: pollId,
      params: params,
    ));
  }

  /// Deletes this poll.
  Future<void> deletePoll({
    required int pollId,
  }) async {
    sbLog.i(StackTrace.current, 'pollId: $pollId');
    return await chat.apiClient.send(PollDeleteRequest(chat, pollId: pollId));
  }

  /// Closes this poll.
  Future<Poll> closePoll({
    required int pollId,
  }) async {
    sbLog.i(StackTrace.current, 'pollId: $pollId');
    return await chat.apiClient.send(PollCloseRequest(chat, pollId: pollId));
  }

  /// Adds an option with [optionText] to this poll.
  Future<Poll> addPollOption({
    required int pollId,
    required String optionText,
  }) async {
    sbLog.i(StackTrace.current, 'pollId: $pollId, optionText: $optionText');

    return await chat.apiClient.send(
      PollOptionAddRequest(
        chat,
        pollId: pollId,
        text: optionText,
        channelUrl: channelUrl,
        channelType: channelType,
      ),
    );
  }

  /// Updates [optionText] fields of this poll option.
  Future<Poll> updatePollOption({
    required int pollId,
    required int pollOptionId,
    required String optionText,
  }) async {
    sbLog.i(StackTrace.current,
        'pollId: $pollId, pollOptionId: $pollOptionId, optionText: $optionText');

    return await chat.apiClient.send(
      PollOptionUpdateRequest(
        chat,
        pollId: pollId,
        pollOptionId: pollOptionId,
        text: optionText,
      ),
    );
  }

  /// Deletes this poll option.
  Future<void> deletePollOption({
    required int pollId,
    required int pollOptionId,
  }) async {
    sbLog.i(StackTrace.current, 'pollId: $pollId, pollOptionId: $pollOptionId');

    await chat.apiClient.send(PollOptionDeleteRequest(
      chat,
      pollId: pollId,
      pollOptionId: pollOptionId,
    ));
  }

  /// Vote on [pollOptionIds].
  /// This operation overrides previous vote actions,
  /// so to update previous vote, pass new [pollOptionIds] as parameter.
  /// To cancel votes, pass an empty list as [pollOptionIds].
  Future<PollVoteEvent> votePoll({
    required int pollId,
    required List<int> pollOptionIds,
  }) async {
    sbLog.i(
        StackTrace.current, 'pollId: $pollId, pollOptionIds: $pollOptionIds');

    final cmd = Command.buildVotePoll(
      channelType: channelType,
      channelUrl: channelUrl,
      pollId: pollId,
      pollOptionIds: pollOptionIds,
    );

    var result = await chat.commandManager.sendCommand(cmd);
    if (result != null) {
      return PollVoteEvent.fromJson(result.payload);
    } else {
      throw WebSocketFailedException();
    }
  }

  /// Requests poll change logs after given timestamp.
  ///
  /// [timestamp] to load change logs.
  /// Change logs after this timestamp will be returned.
  Future<PollChangeLogs> getPollChangeLogsSinceTimestamp(int timestamp) async {
    sbLog.i(StackTrace.current, 'timestamp: $timestamp');

    return await chat.apiClient.send<PollChangeLogs>(
      PollChangelogsGetRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
        ts: timestamp,
      ),
    );
  }

  /// Requests poll change logs after given token.
  ///
  /// The [token] to be the reference point for the changelogs to retrieve.
  /// If the token is null, the result will be passed from the beginning.
  Future<PollChangeLogs> getPollChangeLogsSinceToken(String? token) async {
    sbLog.i(StackTrace.current, 'token: $token');

    return await chat.apiClient.send<PollChangeLogs>(
      PollChangelogsGetRequest(
        chat,
        channelType: channelType,
        channelUrl: channelUrl,
        token: token,
      ),
    );
  }
}
