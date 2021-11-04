import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/events/base_event.dart';

part 'session_event.g.dart';

/// Represents session information
@JsonSerializable(createToJson: false)
class SessionEvent extends BaseEvent {
  final String? newKey;

  final String? ekey;

  final String? key;

  String get sessionKey => key ?? newKey ?? '';

  SessionEvent({this.newKey, this.ekey, this.key});

  factory SessionEvent.fromJson(Map<String, dynamic> json) =>
      _$SessionEventFromJson(json);
}
