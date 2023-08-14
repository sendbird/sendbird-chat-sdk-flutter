import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/constant/types.dart';
import 'package:sendbird_sdk/core/channel/base/base_channel.dart';
import 'package:sendbird_sdk/core/models/command.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/params/open_channel_params.dart';
import 'package:sendbird_sdk/request/channel/open_channel_create_request.dart';
import 'package:sendbird_sdk/request/channel/open_channel_delete_request.dart';
import 'package:sendbird_sdk/request/channel/open_channel_refresh_request.dart';
import 'package:sendbird_sdk/request/channel/open_channel_update_request.dart';
import 'package:sendbird_sdk/sdk/internal/sendbird_sdk_internal.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:sendbird_sdk/services/db/cache_service.dart';
import 'package:sendbird_sdk/services/db/cache_utils.dart';

part 'open_channel.g.dart';
part 'open_channel_operations.dart';

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
  @JsonKey(defaultValue: [])
  List<User> operators;

  @JsonKey(ignore: true)
  bool entered = false;

  SendbirdSdkInternal _sdk = SendbirdSdk().getInternal();

  /// **WARNING:** Do not use default constructor to initialize manually
  OpenChannel({
    required this.participantCount,
    required this.operators,
    required String channelUrl,
    String? name,
    String? coverUrl,
    User? creator,
    int? createdAt,
    String? data,
    String? customType,
    bool isFrozen = false,
    bool isEphemeral = false,
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

    return OpenChannel.refresh(channelUrl);
  }

  /// Refreshes an [OpenChannel] with given [channelUrl]
  static Future<OpenChannel> refresh(String channelUrl) async {
    final sdk = SendbirdSdk().getInternal();
    final channel = await sdk.api.send<OpenChannel>(
      OpenChannelRefreshRequest(
        channelUrl: channelUrl,
        options: [ChannelQueryIncludeOption.metaData],
        passive: false,
      ),
    );
    return channel;
  }

  /// Creates an [OpenChannel] with given [params] and optional [progress].
  static Future<OpenChannel> createChannel(
    OpenChannelParams params, {
    OnUploadProgressCallback? progress,
  }) async {
    final sdk = SendbirdSdk().getInternal();
    return sdk.api.send<OpenChannel>(
        OpenChannelCreateRequest(params, onProgress: progress));
  }

  /// Updates an [OpenChannel] with given [params] and optional [progress].
  ///
  /// [ChannelEventHandler.onChannelChanged] event can be invoked based on
  /// the given [params]
  Future<OpenChannel> updateChannel(
    OpenChannelParams params, {
    OnUploadProgressCallback? progress,
  }) async {
    params.channelUrl ??= channelUrl;
    if (params.channelUrl != channelUrl) {
      throw InvalidParameterError();
    }

    return _sdk.api.send<OpenChannel>(
        OpenChannelUpdateRequest(params, onProgress: progress));
  }

  /// Deletes this channel
  Future<void> deleteChannel() async {
    _sdk.api.send(OpenChannelDeleteRequest(channelUrl));
    removeFromCache();
  }

  /// Returns `true` if a given user with [userId] is operator
  bool isOperator(String userId) {
    return operators.where((e) => e.userId == userId).isNotEmpty;
  }

  // Json serialization

  factory OpenChannel.fromJsonAndCached(Map<String, dynamic> json, {int? ts}) {
    final channel = _$OpenChannelFromJson(json);
    channel.saveToCache();
    json.cacheMetaData(channel: channel, ts: ts);
    return channel;
  }

  factory OpenChannel.fromJson(Map<String, dynamic> json) =>
      _$OpenChannelFromJson(json);

  Map<String, dynamic> toJson() => _$OpenChannelToJson(this);

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;
    if (!(super == (other))) return false;

    final eq = ListEquality().equals;
    return other is OpenChannel &&
        other.participantCount == participantCount &&
        eq(other.operators, operators);
  }

  @override
  int get hashCode => Object.hash(
        super.hashCode,
        participantCount,
        operators,
      );

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
