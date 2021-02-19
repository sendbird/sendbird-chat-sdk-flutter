import '../constant/enums.dart';
import '../message/base_message.dart';
import '../models/error.dart';
import '../params/message_list_params.dart';
import '../sdk/sendbird_sdk_api.dart';

import 'base_query.dart';

class PreviousMessageListQuery extends QueryBase {
  /// Channel type
  ChannelType channelType;

  /// Channel url
  String channelUrl;

  /// Determines whether to sort the retrieved messages in reverse
  /// order. If false, the results are in ascending order.
  bool reverse = false;

  /// Restricts the search scope only to retrieve the messages with
  /// the specified message type.
  MessageTypeFilter messageTypeFilter = MessageTypeFilter.all;

  /// Restricts the search scope only to retrieve the messages with the
  /// specified custom message type.
  List<String> customTypesFilter;

  /// Restricts the search scope only to retrieve the messages sent by
  /// the users with the specified user IDs.
  List<String> senderIdsFilter;

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
  bool includeParentMessageText = false;

  /// Determines whether to include the reactions to the messages in the results.
  /// default value is false
  bool includeReplies = false;

  /// Determines whether to include the thread information of the messages
  /// in the results when the results contain root messages. default value is false
  bool includeThreadInfo = false;

  /// Determines whether to retrieve sub channel messages on Dynamic
  /// Partitioning. This property is only working for [OpenChannel]
  bool showSubChannelMessagesOnly = false;

  int _timestamp = double.maxFinite.round();

  PreviousMessageListQuery();

  @override
  Future<List<BaseMessage>> loadNext() async {
    if (channelUrl == null || channelType == null) {
      throw InvalidParameterError();
    }
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    loading = true;

    final sdk = SendbirdSdk().getInternal();
    final params = MessageListParams()
      ..previousResultSize = limit
      ..reverse = reverse
      ..customTypes = customTypesFilter
      ..messageType = messageTypeFilter
      ..senderIds = senderIdsFilter
      ..includeMetaArray = includeMetaArray
      ..includeParentMessageText = includeParentMessageText
      ..includeReactions = includeReactions
      ..includeReplies = includeReplies
      ..includeThreadInfo = includeThreadInfo
      ..showSubChannelMessagesOnly = showSubChannelMessagesOnly;

    final res = await sdk.api.getMessages(
        channelType: channelType,
        channelUrl: channelUrl,
        params: params.toJson(),
        timestamp: _timestamp);

    _timestamp = res.length != 0 ? res.last.createdAt : null;

    loading = false;
    token = '';
    hasNext = res.length == limit;
    return res;
  }
}
