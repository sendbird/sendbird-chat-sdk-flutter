import 'package:json_annotation/json_annotation.dart';

import '../constant/enums.dart';

part 'threaded_message_list_params.g.dart';

/// An object consists a set of parameters to retrieve list of a threaded message
@JsonSerializable()
class ThreadedMessageListParams {
  /// The number of messages to retrieve that were sent before the
  /// specified timestamp or message ID.
  @JsonKey(name: 'prev_limit')
  int previousResultSize = 10;

  /// The number of messages to retrieve that were sent after the
  /// specified timestamp or message ID.
  @JsonKey(name: 'next_limit')
  int nextResultSize = 10;

  /// Determines whether to include the messages with the matching
  /// timestamp or message ID in the results.
  @JsonKey(name: 'include')
  bool isInclusive = false;

  /// Determines whether to sort the retrieved messages in reverse
  /// order. If `false`, the results are in ascending order.
  bool reverse = false;

  /// Restricts the search scope only to retrieve the messages with
  /// the specified message type.

  MessageTypeFilter messageType = MessageTypeFilter.all;

  /// Restricts the search scope only to retrieve the messages with the
  /// specified custom message type. When the custom type filtering is
  /// not needed, the value should be set to `null`.
  String customType;

  /// Restricts the search scope only to retrieve the messages sent by
  /// the users with the specified user IDs. When the user ID filtering
  /// is not needed, the value should be set to `null`.
  List<String> senderIds;

  /// Determines whether to include the metaarray information of the
  /// messages in the results.
  @JsonKey(name: "with_sorted_meta_array")
  bool includeMetaArray = false;

  /// Determines whether to include the reactions to the messages
  /// in the results.
  bool includeReactions = false;

  /// Determines whether to include the parent message text in the results
  /// when the messages are replies in a thread. If the type of the parent
  /// message is [UserMessage] the  value is a `message`. If it is
  /// [FileMessage], the value is the `name` of the uploaded file.
  bool includeParentMessageText = false;

  Map<String, dynamic> toJson() {
    final json = _$ThreadedMessageListParamsToJson(this);
    json['include_replies'] = true;
    json['include_thread_info'] = true;
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
