// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

/// Represents a params for retrieving total scheduled message.
class TotalScheduledMessageCountParams {
  /// The channel url.
  String? channelUrl;

  /// The scheduled status. Refer to [ScheduledStatus]
  List<ScheduledStatus>? scheduledStatus;

  /// The message type. Refer to [MessageTypeFilter]
  MessageTypeFilter? messageTypeFilter;

  TotalScheduledMessageCountParams({
    this.channelUrl,
    this.scheduledStatus,
    this.messageTypeFilter,
  });

  Map<String, dynamic> toJson() {
    var statusList = [];
    if (scheduledStatus != null) {
      for (final val in scheduledStatus!) {
        statusList.add(val.toString().split('.').last);
      }
    }

    final ret = <String, dynamic>{
      'channel_url': channelUrl,
      'status': statusList.isEmpty ? null : statusList,
      'message_type': messageTypeFilter?.toString().split('.').last,
    };

    ret.removeWhere((key, value) => value == null);
    return ret;
  }
}
