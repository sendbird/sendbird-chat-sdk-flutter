// An object consists a set of parameters to create/update poll
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';

part 'poll_retrieval_params.g.dart';

@JsonSerializable()
class PollRetrievalParams {
  /// An unique identification for channel.
  String channelUrl;

  /// Possible options for which a user can vote
  int pollId;

  ///If true the option resources inside the response will have a property partial_voter_list.
  bool showPartialVoterList;

  /// Channel type corresponding to channel_url parameter
  ChannelType channelType;

  PollRetrievalParams({
    required this.channelUrl,
    required this.pollId,
    this.showPartialVoterList = false,
    required this.channelType,
  });
}
