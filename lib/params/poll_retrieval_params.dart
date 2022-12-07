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

  /// Channel type corresponding to channel_url parameter
  ChannelType channelType;

  PollRetrievalParams({
    required this.channelUrl,
    required this.pollId,
    required this.channelType,
  });
}
