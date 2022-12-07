import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/params/poll_voter_list_query_params.dart';
import 'package:sendbird_sdk/query/base_query.dart';
import 'package:sendbird_sdk/request/poll/poll_option_get_list_voters_request.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';

part 'poll_voter_list_query.g.dart';

/// A query object to retrieve list of voters for specific option.
@JsonSerializable()
class PollVoterListQuery extends QueryBase {
  /// Parameters for Poll Voter List Query Request
  final PollVoterListQueryParams params;

  PollVoterListQuery({required this.params}) : super() {
    limit = params.limit;
  }

  @override
  Future<List<User>> loadNext() async {
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    loading = true;

    final sdk = SendbirdSdk().getInternal();
    final res = await sdk.api.send<PollVoterListQueryResponse>(
      PollOptionGetListVotersRequest(
        channelType: params.channelType,
        channelUrl: params.channelUrl,
        pollId: params.pollId,
        pollOptionId: params.pollOptionId,
        token: token,
        limit: limit,
      ),
    );

    loading = false;
    token = res.next;
    hasNext = res.next != '';
    return res.voters;
  }

  // Json Serialization
  Map<String, dynamic> toJson() => _$PollVoterListQueryToJson(this);
}
