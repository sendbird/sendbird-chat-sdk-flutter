import 'package:json_annotation/json_annotation.dart';

import '../../constant/enums.dart';

import 'reaction_event.dart';

part 'reaction.g.dart';

/// Represents a reaction.
@JsonSerializable()
class Reaction {
  final String key;
  List<String> userIds;
  int updatedAt;

  @JsonKey(ignore: true)
  Map<String, int> updatedAts;

  Reaction({
    this.key,
    this.userIds,
    this.updatedAt,
  }) {
    updatedAts =
        Map.fromIterable(userIds, key: (e) => e, value: (e) => updatedAt);
  }

  bool merge(ReactionEvent event) {
    if (updatedAt < event.updatedAt) {
      updatedAt = event.updatedAt;
    }

    final userUpdatedAt = updatedAts[event.userId] ?? 0;
    if (userUpdatedAt > event.updatedAt) {
      return false;
    }

    updatedAts[event.userId] = event.updatedAt;

    if (event.operation == ReactionEventAction.add) {
      userIds.add(event.userId);
    } else {
      userIds.remove(event.userId);
    }

    return true;
  }

  factory Reaction.fromJson(Map<String, dynamic> json) =>
      _$ReactionFromJson(json);
}
