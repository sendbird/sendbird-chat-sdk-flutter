import '../constant/enums.dart';
import '../core/message/base_message.dart';
import '../core/models/error.dart';
import '../query/base_query.dart';
import '../sdk/sendbird_sdk_api.dart';

/// A query object to search messages
class MessageSearchQuery extends QueryBase {
  ///Keyword to search
  String keyword;

  /// Channel url
  String channelUrl;

  /// Channel custom type to filter
  String channelCustomType;

  /// Determines whether to sort the retrieved messages in reverse
  /// order.
  ///
  /// If `false`, the results are in ascending order. Default is `false`
  bool reverse = false;

  /// `true` to be exact match for keyword
  bool exactMatch;

  /// timestamp to begin search
  int messageTimestampFrom;

  /// timestamp to end search
  int messageTimestampTo;

  String beforeIndex;
  String afterIndex;

  List<String> targetUserIds;

  /// Message search result sort order
  MessageSearchQueryOrder order = MessageSearchQueryOrder.timestamp;

  @override
  Future<List<BaseMessage>> loadNext() async {
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    loading = true;

    final sdk = SendbirdSdk().getInternal();
    final res = await sdk.api.searchMessages(
      keyword: keyword,
      channelUrl: channelUrl,
      customType: channelCustomType,
      reverse: reverse,
      exactMatch: exactMatch,
      beforeIndex: beforeIndex,
      afterIndex: afterIndex,
      token: token,
      targetUserIds: targetUserIds,
      startAt: messageTimestampFrom,
      endAt: messageTimestampTo,
      sortField: messageSearchQueryOrderEnumMap[order],
      limit: limit,
    );

    loading = false;
    token = res.next;
    hasNext = res.hasNext;
    return res.results;
  }
}
