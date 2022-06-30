import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/events/base_event.dart';
import 'package:sendbird_sdk/features/poll/poll.dart';

part 'poll_update_event.g.dart';

/// Represents Poll Update event
@JsonSerializable()
class PollUpdateEvent implements BaseEvent {
  Poll poll;
  String status;
  int ts;

  PollUpdateEvent({
    required this.poll,
    required this.status,
    required this.ts,
  });

  factory PollUpdateEvent.fromJson(Map<String, dynamic> res) {
    final status = <String, dynamic>{'status': res['poll']['status']};

    res.addAll(status);
    return _$PollUpdateEventFromJson(res);
  }
}
