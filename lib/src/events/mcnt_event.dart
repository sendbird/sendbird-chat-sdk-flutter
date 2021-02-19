import 'package:json_annotation/json_annotation.dart';
import 'package:sendbirdsdk/sendbirdsdk.dart';

part 'mcnt_event.g.dart';

@JsonSerializable()
class MCNTEvent {
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
