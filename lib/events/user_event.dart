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

  List<User> get friendDiscoveries =>
      data != null ? data['friend_discoveries'] : null;
  User get blocker => data != null ? User.fromJson(data['blocker']) : null;
  User get blockee => data != null ? User.fromJson(data['blockee']) : null;

  UserEvent({this.category, this.data, this.ts});

  static UserEvent fromJson(Map<String, dynamic> json) =>
      _$UserEventFromJson(json);
}
