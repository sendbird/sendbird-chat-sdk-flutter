import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/params/base_message_fetch_params.dart';

part 'threaded_message_list_params.g.dart';

/// An object consists a set of parameters to retrieve list of a threaded message
@JsonSerializable()
class ThreadedMessageListParams extends BaseMessageFetchParams {
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
  String? customType;

  /// Restricts the search scope only to retrieve the messages sent by
  /// the users with the specified user IDs. When the user ID filtering
  /// is not needed, the value should be set to `null`.
  List<String>? senderIds;

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
