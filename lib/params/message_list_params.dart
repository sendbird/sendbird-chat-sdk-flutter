import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/params/base_message_fetch_params.dart';

part 'message_list_params.g.dart';

/// An object consists a set of parameters to retrieve list of messages.
@JsonSerializable()
class MessageListParams extends BaseMessageFetchParams {
  /// The number of messages to retrieve that were sent before the
  /// specified timestamp or message ID.
  @JsonKey(name: 'prev_limit')
  int previousResultSize = 10;

  /// The number of messages to retrieve that were sent after the
  /// specified timestamp or message ID.
  @JsonKey(name: 'next_limit')
  int nextResultSize = 0;

  /// Determines whether to include the messages with the matching
  /// timestamp or message ID in the results.
  @JsonKey(name: 'include')
  bool isInclusive = false;

  /// Determines whether to sort the retrieved messages in reverse
  /// order. If false, the results are in ascending order.
  bool reverse = false;

  /// Restricts the search scope only to retrieve the messages with
  /// the specified message type.
  MessageTypeFilter messageType = MessageTypeFilter.all;

  /// Restricts the search scope only to retrieve the messages with the
  /// specified custom message type.
  String? customType;
  List<String>? customTypes;

  /// Restricts the search scope only to retrieve the messages sent by
  /// the users with the specified user IDs.
  List<String>? senderIds;

  /// Determines whether to retrieve sub channel messages on Dynamic
  /// Partitioning. This property is only working for [OpenChannel]
  @JsonKey(name: 'show_subchannel_messages_only')
  bool showSubChannelMessagesOnly = false;

  /// Determines wheter to include parent message information
  @override
  bool includeParentMessageInfo = false;

  /// Determines message's reply type
  @override
  @JsonKey(name: 'include_reply_type')
  ReplyType? replyType = ReplyType.none;

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll(_$MessageListParamsToJson(this));
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
