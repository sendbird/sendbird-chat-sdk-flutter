// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/base_message_fetch_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/query/base_query.dart';

part 'threaded_message_list_params.g.dart';

/// Represents a message list params.
@JsonSerializable()
class ThreadedMessageListParams extends BaseMessageFetchParams {
  /// The number of previous messages added either before the timestamp or the message that has a specific message ID.
  @JsonKey(name: 'prev_limit')
  int previousResultSize = BaseQuery.defaultQueryLimit;

  /// The number of newer messages added either before the timestamp or the message that has a specific message ID.
  @JsonKey(name: 'next_limit')
  int nextResultSize = 10;

  /// Determines whether to include the messages sent exactly on the specified timestamp or have the matching message ID in the results.
  @JsonKey(name: 'include')
  bool inclusive = false;

  /// Determines whether to sort the retrieved messages in reverse order.
  bool reverse = false;

  /// Restricts the search scope only to retrieve the messages with the specified message type.
  MessageTypeFilter messageType = MessageTypeFilter.all;

  /// Restricts the search scope only to retrieve the messages that match any of given custom
  /// types.
  /// When the custom type filtering is not needed, the value should be set to null.
  /// When a empty string is given, messages that does not have a custom type will also be
  /// returned.
  String? customType;

  /// Restricts the search scope only to retrieve the messages sent by the users with the specified user IDs.
  /// When the user ID filtering is not needed, the value should be set to null.
  List<String>? senderIds;

  static ThreadedMessageListParams fromJson(Map<String, dynamic> json) {
    return _$ThreadedMessageListParamsFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    replyType = ReplyType.all;
    includeThreadInfo = true;

    final json = super.toJson();
    json.addAll(_$ThreadedMessageListParamsToJson(this));
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
