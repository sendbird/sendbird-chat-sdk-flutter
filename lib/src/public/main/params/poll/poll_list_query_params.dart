// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/src/public/main/define/enums.dart';
import 'package:sendbird_chat/src/public/main/query/poll/poll_list_query.dart';

/// Params for creating a [PollListQuery] object.
class PollListQueryParams {
  /// The [ChannelType] of the channel you want to get polls from.
  ChannelType channelType;

  /// The channel url of the channel you want to get polls from.
  String channelUrl;

  /// The maximum number of items per queried page.
  /// The default value for the [limit] parameter is `10`.
  int? limit;

  PollListQueryParams({
    required this.channelType,
    required this.channelUrl,
    this.limit,
  });
}
