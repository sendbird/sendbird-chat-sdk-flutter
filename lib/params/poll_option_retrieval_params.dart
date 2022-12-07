import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';

part 'poll_option_retrieval_params.g.dart';

@JsonSerializable()
class PollOptionRetrievalParams {
  String channelUrl;
  int pollOptionId;
  int pollId;
  ChannelType channelType;

  PollOptionRetrievalParams({
    required this.channelUrl,
    required this.pollOptionId,
    required this.pollId,
    required this.channelType,
  });

  Map<String, dynamic> toJson() {
    final json = _$PollOptionRetrievalParamsToJson(this);
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
