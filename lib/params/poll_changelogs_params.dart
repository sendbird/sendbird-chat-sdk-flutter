import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

@JsonSerializable()
class PollChangeLogsParams {
  String channelUrl;
  ChannelType channelType;
  bool showPartialVoterList = false;

  PollChangeLogsParams({
    required this.channelUrl,
    required this.channelType,
    showPartialVoterList,
  });
}
