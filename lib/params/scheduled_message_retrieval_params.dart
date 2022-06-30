import 'package:json_annotation/json_annotation.dart';

part 'scheduled_message_retrieval_params.g.dart';

@JsonSerializable()
class ScheduledMessageRetrievalParams {
  final String channelUrl;
  final int scheduledMessageId;

  ScheduledMessageRetrievalParams(
      {required this.channelUrl, required this.scheduledMessageId});

  Map<String, dynamic> toJson() {
    return _$ScheduledMessageRetrievalParamsToJson(this);
  }
}
