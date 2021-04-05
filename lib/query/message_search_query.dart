import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/query/base_query.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';

part 'message_search_query.g.dart';

/// A query object to search messages
@JsonSerializable()
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

  MessageSearchQuery();

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

  // Json Serialization

  Map<String, dynamic> toJson() => _$MessageSearchQueryToJson(this);
}
