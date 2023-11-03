// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/reaction/reaction_event.dart';

part 'reaction.g.dart';

/// Objects representing a reaction.
@JsonSerializable()
class Reaction {
  /// The key of the reaction.
  final String key;

  /// The user ids.
  @JsonKey(defaultValue: [])
  List<String> userIds;

  /// The updated time of the reaction in milliseconds.
  int updatedAt;

  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, int> updatedAts = {};

  Reaction({
    required this.key,
    required this.userIds,
    required this.updatedAt,
  }) {
    updatedAts = {for (var e in userIds) e: updatedAt};
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

    final eq = const ListEquality().equals;
    return other is Reaction &&
        other.key == key &&
        eq(other.userIds, userIds) &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode => Object.hash(key, userIds, updatedAt);
}
