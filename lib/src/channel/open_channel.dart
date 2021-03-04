import 'package:json_annotation/json_annotation.dart';
import 'package:sendbirdsdk/src/events/channel_event.dart';

import '../channel/base_channel.dart';
import '../models/command.dart';
import '../constant/enums.dart';
import '../constant/types.dart';
import '../models/error.dart';
import '../models/user.dart';
import '../params/open_channel_params.dart';
import '../sdk/sendbird_sdk_api.dart';
import '../sdk/sendbird_sdk_internal.dart';
import '../services/db/cache_service.dart';

part 'open_channel.g.dart';

/// Represents open channel
///
/// In most case, any static or instance method will throw a [SBError] if
/// anything goes wrong such as parameter is not provided or connection has not
/// been maded. Use method with try/catch block or then/catchError callback
///
/// ```
/// try {
///    final channel = OpenChannel.getChannel('1234');
///    //do something with channel
/// } catch (e) {
///    //handle error
/// }
/// ```
/// or
/// ```
/// OpenChannel.getChannel('1234').then((channel) {
///   //do seomthing with channel
/// }).catchError((e) {
///   //handle error
/// })
/// ```
///
@JsonSerializable()
class OpenChannel extends BaseChannel {
  /// Number of participants in this channel
  int participantCount;

  /// Operators of this channel
  List<User> operators;

  @JsonKey(ignore: true)
  bool entered = false;

  SendbirdSdkInternal _sdk = SendbirdSdk().getInternal();

  /// **WARNING:** Do not use default constructor to initialize manually
  OpenChannel({
    this.participantCount,
    this.operators,
    String channelUrl,
    String name,
    String coverUrl,
    User creator,
    int createdAt,
    String data,
    String customType,
    bool isFrozen,
    bool isEphemeral,
  }) : super(
          channelUrl: channelUrl,
          name: name,
          coverUrl: coverUrl,
          createdAt: createdAt,
          data: data,
          customType: customType,
          isFrozen: isFrozen,
          isEphemeral: isEphemeral,
          fromCache: false,
          dirty: false,
        );

  /// Gets an [OpenChannel] with given [channelUrl].
  static Future<OpenChannel> getChannel(String channelUrl) async {
    final sdk = SendbirdSdk().getInternal();
    var channel = sdk.cache.find<OpenChannel>(channelKey: channelUrl);
    if (channel != null && !channel.dirty) {
      channel.fromCache = true;
      return channel;
    }

    return OpenChannel.refreshChannel(channelUrl);
  }

  /// Refreshes an [OpenChannel] with given [channelUrl]
  static Future<OpenChannel> refreshChannel(String channelUrl) async {
    final sdk = SendbirdSdk().getInternal();
    final channel = await sdk.api.getChannel(
      channelType: ChannelType.open,
      channelUrl: channelUrl,
      passive: false,
    );
    return channel;
  }

  /// Creates an [OpenChannel] with given [params] and optional [progress].
  static Future<OpenChannel> createChannel(
    OpenChannelParams params, {
    OnUploadProgressCallback progress,
  }) async {
    if (params == null) {
      throw InvalidParameterError();
    }
    final sdk = SendbirdSdk().getInternal();
    return sdk.api.createOpenChannel(
      params,
      progress: (sentBytes, totalBytes) {
        if (progress != null) progress(sentBytes, totalBytes);
      },
    );
  }

  /// Updates an [OpenChannel] with given [params] and optional [progress].
  ///
  /// [ChannelEventHandler.onChannelChanged] event can be invoked based on
  /// the given [params]
  Future<OpenChannel> updateChannel(
    OpenChannelParams params, {
    OnUploadProgressCallback progress,
  }) async {
    if (params == null) {
      throw InvalidParameterError();
    }
    if (params.channelUrl == null) {
      params.channelUrl = channelUrl;
    }
    if (params.channelUrl != channelUrl) {
      throw InvalidParameterError();
    }

    return _sdk.api.updateOpenChannel(
      params,
      progress: (sentBytes, totalBytes) {
        if (progress != null) progress(sentBytes, totalBytes);
      },
    );
  }

  /// Deletes this channel
  Future<void> deleteChannel() async {
    await _sdk.api.deleteChannel(
      channelType: channelType,
      channelUrl: channelUrl,
    );
    removeFromCache();
  }

  /// Enters to this channel
  Future<void> enter() async {
    final cmd = Command.buildEnterChannel(this);
    final result = await _sdk.cmdManager.sendCommand(cmd);
    if (result == null) {
      throw WebSocketError();
    }
    participantCount = result.payload['participant_count'];
    entered = true;
  }

  /// Exits from this channel
  Future<void> exit() async {
    final cmd = Command.buildExitChannel(this);
    final result = await _sdk.cmdManager.sendCommand(cmd);
    participantCount = result.payload['participant_count'];
    entered = false;
    removeFromCache();
  }

  /// Returns `true` if a given user with [userId] is operator
  bool isOperator(String userId) {
    return operators.where((e) => e.userId == userId).isNotEmpty;
  }

  /// Builds a message object from serialized data
  // static OpenChannel buildFromSeralizedData(ByteData data) {
  //   return null;
  // }

  /// Serializes message object
  // ByteData serialize() {
  //   return null;
  // }

  factory OpenChannel.fromJsonAndCached(Map<String, dynamic> json) {
    final channel = _$OpenChannelFromJson(json);
    channel.saveToCache();
    return channel;
  }

  factory OpenChannel.fromJson(Map<String, dynamic> json) =>
      _$OpenChannelFromJson(json);

  @override
  void copyWith(dynamic others) {
    super.copyWith(others);
    if (others is OpenChannel) {
      participantCount = others.participantCount;
      operators = List<User>.from(others.operators);
      entered = others.entered;
    }
  }
}
