// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/reaction/reaction.dart';

part 'reaction_event.g.dart';

/// Objects representing a reaction event.
@JsonSerializable(createToJson: false)
class ReactionEvent {
  /// The channel type.
  @JsonKey(
    defaultValue: ChannelType.group,
    unknownEnumValue: ChannelType.group,
  )
  final ChannelType channelType; // Check

  /// The channel url.
  @JsonKey(defaultValue: '')
  final String channelUrl; // Check

  /// The message ID which contains the [Reaction] of this event.
  @JsonKey(name: 'msg_id', defaultValue: 0)
  int messageId;

  /// The key of the [Reaction] this event belongs to.
  @JsonKey(name: 'reaction', defaultValue: '')
  final String key;

  /// The user ID of the [User] who have created this reaction event.
  @JsonKey(defaultValue: '')
  final String userId;

  /// Refer to [ReactionEventAction].
  @JsonKey(defaultValue: ReactionEventAction.delete)
  final ReactionEventAction operation;

  /// The updated timestamp of the reaction event in milliseconds.
  @JsonKey(defaultValue: 0)
  final int updatedAt;

  ReactionEvent({
    required this.channelType,
    required this.channelUrl,
    required this.messageId,
    required this.key,
    required this.userId,
    required this.operation,
    required this.updatedAt,
  });

  factory ReactionEvent.fromJson(Map<String, dynamic> json) =>
      _$ReactionEventFromJson(json);
}
