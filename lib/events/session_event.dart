import 'package:json_annotation/json_annotation.dart';

import 'base_event.dart';

part 'session_event.g.dart';

/// Represents session information
@JsonSerializable(createToJson: false)
class SessionEvent extends BaseEvent {
  @JsonKey(defaultValue: 0)
  final int expiresIn;

  final String newKey;

  final String ekey;

  final String key;

  String get sessionKey => key ?? newKey ?? null;

  SessionEvent({this.expiresIn, this.newKey, this.ekey, this.key});

  factory SessionEvent.fromJson(Map<String, dynamic> json) =>
      _$SessionEventFromJson(json);
}
