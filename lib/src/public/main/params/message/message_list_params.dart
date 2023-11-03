// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/core/channel/open_channel/open_channel.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/base_message_fetch_params.dart';
import 'package:sendbird_chat_sdk/src/public/main/query/base_query.dart';

part 'message_list_params.g.dart';

/// Represents a message list params.
@JsonSerializable()
class MessageListParams extends BaseMessageFetchParams {
  /// The number of previous messages added either before the timestamp or the message that has a specific message ID.
  @JsonKey(name: 'prev_limit')
  int previousResultSize = BaseQuery.defaultQueryLimit;

  /// The number of newer messages added either before the timestamp or the message that has a specific message ID.
  @JsonKey(name: 'next_limit')
  int nextResultSize = 0;

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
  List<String>? customTypes;

  /// Restricts the search scope only to retrieve the messages sent by the users with the specified user IDs.
  /// When the user ID filtering is not needed, the value should be set to null.
  List<String>? senderIds;

  /// Whether to show subChannel message only. Defaults to false.
  /// This only takes effect when the requested channel is a dynamically partitioned [OpenChannel].
  @JsonKey(name: 'show_subchannel_messages_only')
  bool showSubChannelMessagesOnly = false;

  static MessageListParams fromJson(Map<String, dynamic> json) {
    return _$MessageListParamsFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll(_$MessageListParamsToJson(this));
    json.removeWhere((key, value) => value == null);
    return json;
  }

  @override
  void copyWith(BaseMessageFetchParams other) {
    super.copyWith(other);
    if (other is MessageListParams) {
      previousResultSize = other.previousResultSize;
      nextResultSize = other.nextResultSize;
      inclusive = other.inclusive;
      reverse = other.reverse;
      messageType = other.messageType;
      customTypes = other.customTypes;
      senderIds = other.senderIds;
      showSubChannelMessagesOnly = other.showSubChannelMessagesOnly;
    }
  }
}
