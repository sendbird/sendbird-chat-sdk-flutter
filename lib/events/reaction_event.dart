import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/events/base_event.dart';

part 'reaction_event.g.dart';

/// Represents an reaction event that happens on [BaseMessage].
///
/// This object is needed to apply to the [BaseMessage] based on [messageId]
/// when this is acquired from [ChannelEventHandler.onReactionUpdated]
@JsonSerializable(createToJson: false)
class ReactionEvent implements BaseEvent {
  @JsonKey(defaultValue: '')
  final String channelUrl;

  @JsonKey(
    defaultValue: ChannelType.group,
    unknownEnumValue: ChannelType.group,
  )
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
