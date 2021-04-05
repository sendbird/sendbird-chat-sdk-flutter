import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/channel/open/open_channel.dart';
import 'package:sendbird_sdk/events/base_event.dart';

part 'mcnt_event.g.dart';

/// Represents mcnt event
@JsonSerializable(createToJson: false)
class MCNTEvent implements BaseEvent {
  List<GroupChannel> groupChannels;

  List<OpenChannel> openChannels;

  @JsonKey(name: 'sts')
  int systemTimestamp;

  @JsonKey(name: 'ts')
  int timestamp;

  MCNTEvent({
    this.groupChannels,
    this.openChannels,
    this.systemTimestamp,
    this.timestamp,
  });

  factory MCNTEvent.fromJson(Map<String, dynamic> json) =>
      _$MCNTEventFromJson(json);
}
