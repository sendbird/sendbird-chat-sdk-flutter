import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/params/message_list_params.dart';
import 'package:sendbird_sdk/query/base_query.dart';
import 'package:sendbird_sdk/request/messages/messages_get_request.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:sendbird_sdk/utils/extensions.dart';

part 'previous_message_list_query.g.dart';

/// A query object to retrieve previous messages
@JsonSerializable()
class PreviousMessageListQuery extends QueryBase {
  /// Channel type
  ChannelType channelType;

  /// Channel url
  String channelUrl;

  /// Determines whether to sort the retrieved messages in reverse
  /// order. If false, the results recieves the oldest messages first.
  bool reverse = false;

  /// Restricts the search scope only to retrieve the messages with
  /// the specified message type.
  MessageTypeFilter messageTypeFilter = MessageTypeFilter.all;

  /// Restricts the search scope only to retrieve the messages with the
  /// specified custom message type.
  List<String> customTypesFilter = [];

  /// Restricts the search scope only to retrieve the messages sent by
  /// the users with the specified user IDs.
  List<String> senderIdsFilter = [];

  /// Determines whether to include the metaarray information of the
  /// messages in the results. default value is false
  bool includeMetaArray = false;

  /// Determines whether to include the reactions to the messages
  /// in the results. default value is false
  bool includeReactions = false;

  /// Determines whether to include the parent message text in the results
  /// when the messages are replies in a thread. If the type of the parent
  /// message is `UserMessage` the  value is a `message`. If it is
  /// `FileMessage`, the value is the `name` of the uploaded file.
  /// default value is false
  @Deprecated('Use `includeParentMessageInfo` instead')
  bool? includeParentMessageText;

  /// Determines whether to include current message's parent information
  bool includeParentMessageInfo = false;

  /// Determines whether to include the reactions to the messages in the results.
  /// default value is false
  @Deprecated('Use `replyType` instead')
  bool? includeReplies;

  /// Determines message's reply type
  @JsonKey(name: 'include_reply_type')
  ReplyType replyType = ReplyType.none;

  /// Determines whether to include the thread information of the messages
  /// in the results when the results contain root messages. default value is false
  bool includeThreadInfo = false;

  /// Determines whether to retrieve sub channel messages on Dynamic
  /// Partitioning. This property is only working for [OpenChannel]
  @JsonKey(name: 'show_subchannel_messages_only')
  bool showSubChannelMessagesOnly = false;

  /// Returns the oldest message timestamp
  int? _timestamp = ExtendedInteger.max;

  PreviousMessageListQuery({
    required this.channelType,
    required this.channelUrl,
  });

  @override
  Future<List<BaseMessage>> loadNext() async {
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    loading = true;

    final params = MessageListParams()
      ..previousResultSize = limit
      ..reverse = reverse
      ..customTypes = customTypesFilter
      ..messageType = messageTypeFilter
      ..senderIds = senderIdsFilter
      ..includeMetaArray = includeMetaArray
      ..includeParentMessageInfo = includeParentMessageInfo
      // ignore: deprecated_member_use_from_same_package
      ..includeParentMessageText = includeParentMessageText
      ..includeReactions = includeReactions
      ..includeThreadInfo = includeThreadInfo
      ..replyType = replyType
      // ignore: deprecated_member_use_from_same_package
      ..includeReplies = includeReplies
      ..showSubChannelMessagesOnly = showSubChannelMessagesOnly;

    final sdk = SendbirdSdk().getInternal();
    final res = await sdk.api.send<List<BaseMessage>>(
      ChannelMessagesGetRequest(
        channelType: channelType,
        channelUrl: channelUrl,
        params: params.toJson(),
        timestamp: _timestamp ?? 0,
      ),
    );

    if (res.isNotEmpty) {
      final oldestMessage = reverse ? res.last : res.first;
      _timestamp = oldestMessage.createdAt;
    } else {
      _timestamp = null;
    }

    loading = false;
    hasNext = res.length == limit;
    return res;
  }

  // Json Serialization

  Map<String, dynamic> toJson() => _$PreviousMessageListQueryToJson(this);
}
