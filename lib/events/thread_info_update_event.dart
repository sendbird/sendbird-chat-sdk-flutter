import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/channel/group/features/thread_info.dart';
import 'package:sendbird_sdk/events/base_event.dart';

part 'thread_info_update_event.g.dart';

/// Represents thread update information.
///
/// This object is returned through the event handler when
/// a threaded reply is added or deleted. This object is needed to
/// be applied to the parent message.
@JsonSerializable(createToJson: false)
class ThreadInfoUpdateEvent implements BaseEvent {
  /// Information about threaded message
  final ThreadInfo threadInfo;

  /// Unique id of the message that contains threaded information
  final int rootMessageId;

  /// Unique url of the channel where threaded message belongs
  final String channelUrl;

  /// Type of the channel where threaded message belongs
  final ChannelType channelType;

  ThreadInfoUpdateEvent({
    this.threadInfo,
    this.rootMessageId,
    this.channelType,
    this.channelUrl,
  });

  factory ThreadInfoUpdateEvent.fromJson(Map<String, dynamic> json) =>
      _$ThreadInfoUpdateEventFromJson(json);
}
