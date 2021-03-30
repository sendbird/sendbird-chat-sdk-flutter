import 'package:json_annotation/json_annotation.dart';

import 'base_event.dart';

import '../constant/enums.dart';

part 'reaction_event.g.dart';

/// Represents an reaction event that happens on [BaseMessage].
///
/// This object is needed to apply to the [BaseMessage] based on [messageId]
/// when this is acquired from [ChannelEventHandler.onReactionUpdated]
@JsonSerializable(createToJson: false)
class ReactionEvent implements BaseEvent {
  final String channelUrl;

  @JsonKey(unknownEnumValue: ChannelType.group)
  final ChannelType channelType;

  /// Corresponding message id
  @JsonKey(name: 'msg_id')
  int messageId;

  /// Reaction key
  @JsonKey(name: 'reaction')
  final String key;

  /// [User]'s id who triggers this event
  final String userId;

  /// Operation type of this event
  final ReactionEventAction operation;

  /// Timestamp for update
  final int updatedAt;

  ReactionEvent({
    this.channelType,
    this.channelUrl,
    this.messageId,
    this.key,
    this.userId,
    this.operation,
    this.updatedAt,
  });

  factory ReactionEvent.fromJson(Map<String, dynamic> json) =>
      _$ReactionEventFromJson(json);
}
