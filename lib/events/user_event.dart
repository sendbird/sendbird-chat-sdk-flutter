import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/events/base_event.dart';

part 'user_event.g.dart';

/// Represents user event
@JsonSerializable(createToJson: false)
class UserEvent implements BaseEvent {
  @JsonKey(fromJson: userEventValueOf, name: 'cat')
  UserEventCategory category;

  final Map<String, dynamic> data;

  int ts;

  List<User> get friendDiscoveries => data['friend_discoveries'];
  User get blocker => User.fromJson(data['blocker']);
  User get blockee => User.fromJson(data['blockee']);

  UserEvent({required this.category, required this.data, required this.ts});

  static UserEvent fromJson(Map<String, dynamic> json) =>
      _$UserEventFromJson(json);
}
