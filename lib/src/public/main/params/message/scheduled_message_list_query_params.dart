// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

/// Params for creating a [ScheduledMessageListQuery] object.
class ScheduledMessageListQueryParams {
  /// The scheduled messages in specified channel will be retrieved. Defaults to null.
  String? channelUrl;

  /// Determines whether to list the retrieved messages in reverse order. Defaults to false.
  bool? reverse = false;

  /// The target scheduled status of the scheduled messages to be retrieved. Defaults to null.
  List<ScheduledStatus>? scheduledStatus;

  /// Message type filter of scheduled messages. Defaults to [MessageTypeFilter.all].
  MessageTypeFilter? messageTypeFilter = MessageTypeFilter.all;

  /// The result order of scheduled messages. Defaults to [ScheduledMessageListQueryOrder.createdAt].
  ScheduledMessageListQueryOrder? order =
      ScheduledMessageListQueryOrder.createdAt;

  /// The maximum number of items per queried page.
  int? limit;

  ScheduledMessageListQueryParams({
    this.channelUrl,
    this.reverse,
    this.scheduledStatus,
    this.messageTypeFilter,
    this.order,
    this.limit,
  });
}
