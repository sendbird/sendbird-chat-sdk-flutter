import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';

part 'poll_voter_list_query_params.g.dart';

@JsonSerializable()
class PollVoterListQueryParams {
  int pollId;
  int pollOptionId;
  ChannelType channelType;
  String channelUrl;
  int limit;

  PollVoterListQueryParams({
    required this.pollId,
    required this.pollOptionId,
    required this.channelType,
    required this.channelUrl,
    this.limit = 20, // Default
  });

  // Json Serialization
  Map<String, dynamic> toJson() => _$PollVoterListQueryParamsToJson(this);

  factory PollVoterListQueryParams.fromJson(Map<String, dynamic> json) {
    return _$PollVoterListQueryParamsFromJson(json);
  }
}
