// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/query/poll/poll_voter_list_query.dart';

/// Params for creating a [PollVoterListQuery] object.
class PollVoterListQueryParams {
  /// A unique identifier for the poll which contains this poll option.
  int pollId;

  /// A unique identifier for this poll option.
  int pollOptionId;

  /// The type of the channel that this poll belongs to.
  ChannelType channelType;

  /// The url of the channel that this poll belongs to.
  String channelUrl;

  /// The maximum number of items per queried page.
  /// The default value for [limit] is 20.
  int? limit;

  PollVoterListQueryParams({
    required this.pollId,
    required this.pollOptionId,
    required this.channelType,
    required this.channelUrl,
    this.limit,
  });
}
