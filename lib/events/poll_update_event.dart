import 'package:sendbird_sdk/events/base_event.dart';

class PollUpdateEvent implements BaseEvent {
  int pollId;
  int messageId;
  Map<String, dynamic> json;

  PollUpdateEvent({
    required this.pollId,
    required this.messageId,
    required this.json,
  });

  factory PollUpdateEvent.fromJson(Map<String, dynamic> res) {
    return PollUpdateEvent(
      pollId: res['poll']['id'],
      messageId: res['poll']['message_id'],
      json: res,
    );
  }
}
