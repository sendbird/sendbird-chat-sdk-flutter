import '../constant/enums.dart';
import '../core/channel/open/open_channel.dart';
import '../core/models/error.dart';
import '../query/base_query.dart';
import '../sdk/sendbird_sdk_api.dart';

/// A query object to retrieve list of open channel.
class OpenChannelListQuery extends QueryBase {
  /// Channel url
  String channelUrl;

  /// Channel name
  String channelName;

  /// Filters channel custom type
  String customType;

  /// Query result includes frozen channels if `true`
  /// default value is `true`
  bool includeFrozenChannel = true;

  // Query result includes metaData for channel if `true`
  // default value is `false`
  bool includeMetaData = true;

  OpenChannelListQuery();

  @override
  Future<List<OpenChannel>> loadNext() async {
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    loading = true;

    List<ChannelQueryIncludeOption> options = [
      if (includeFrozenChannel) ChannelQueryIncludeOption.frozenChannel,
      if (includeMetaData) ChannelQueryIncludeOption.metaData
    ];

    final sdk = SendbirdSdk().getInternal();
    final res = await sdk.api.getOpenChannels(
      channelName: channelName,
      channelUrl: channelUrl,
      customType: customType,
      token: token,
      limit: limit,
      options: options,
    );

    loading = false;
    token = res.next;
    hasNext = res.next != '';
    return res.channels;
  }
}
