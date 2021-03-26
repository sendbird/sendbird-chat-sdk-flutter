import 'package:json_annotation/json_annotation.dart';

import 'base_event.dart';

import '../core/channel/open/open_channel.dart';
import '../core/channel/group/group_channel.dart';

part 'mcnt_event.g.dart';

/// Represents mcnt event
@JsonSerializable()
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
