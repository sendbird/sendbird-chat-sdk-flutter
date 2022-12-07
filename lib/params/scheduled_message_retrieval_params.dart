import 'package:json_annotation/json_annotation.dart';

part 'scheduled_message_retrieval_params.g.dart';

@JsonSerializable()
class ScheduledMessageRetrievalParams {
  /// Specifies the URL of the channel
  final String channelUrl;

  /// Specifies the ID of the scheduled message
  final int scheduledMessageId;

  ScheduledMessageRetrievalParams({
    required this.channelUrl,
    required this.scheduledMessageId,
  });

  Map<String, dynamic> toJson() {
    return _$ScheduledMessageRetrievalParamsToJson(this);
  }
}
