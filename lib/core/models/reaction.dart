import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/events/reaction_event.dart';

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

  Map<String, dynamic> toJson() => _$ReactionToJson(this);

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;

    final eq = ListEquality().equals;
    return other is Reaction &&
        other.key == key &&
        eq(other.userIds, userIds) &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode => hashValues(key, userIds, updatedAt);
}
