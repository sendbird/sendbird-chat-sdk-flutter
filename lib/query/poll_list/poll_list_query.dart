import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/features/poll/poll.dart';
import 'package:sendbird_sdk/params/poll_list_query_params.dart';
import 'package:sendbird_sdk/query/base_query.dart';
import 'package:sendbird_sdk/request/poll/poll_list_get_request.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';

part 'poll_list_query.g.dart';

/// A query object to retrieve list of polls.
@JsonSerializable()
class PollListQuery extends QueryBase {
  /// Parameters for Poll List Query Request
  final PollListQueryParams params;

  PollListQuery({required this.params}) : super() {
    limit = params.limit;
  }

  @override
  Future<List<Poll>> loadNext() async {
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    loading = true;

    final sdk = SendbirdSdk().getInternal();
    final res = await sdk.api.send<PollListQueryResponse>(
      PollListGetRequest(
        channelType: params.channelType,
        channelUrl: params.channelUrl,
        token: token,
        limit: limit,
      ),
    );

    loading = false;
    token = res.next;
    hasNext = res.next != '';
    return res.polls;
  }

  // Json Serialization
  Map<String, dynamic> toJson() => _$PollListQueryToJson(this);
}
