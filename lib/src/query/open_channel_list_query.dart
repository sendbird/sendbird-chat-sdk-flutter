import '../channel/open_channel.dart';
import '../constant/enums.dart';
import '../models/error.dart';
import '../query/base_query.dart';
import '../sdk/sendbird_sdk_api.dart';

/// A query object to retrieve list of open channel.
class OpenChannelListQuery extends QueryBase {
  /// Query result includes frozen channels if `true`
  /// default value is `true`
  bool includeFrozenChannel = true;

  // Query result includes metaData for channel if `true`
  // default value is `false`
  // bool includeMetaData = false;

  /// Filter for channel url
  String channelUrl;

  /// Filter for channel name
  String channelName;

  /// Filter for channel custom type
  String customType;

  OpenChannelListQuery();

  @override
  Future<List<OpenChannel>> loadNext() async {
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    loading = true;

    List<ChannelQueryIncludeOption> options = [];
    if (includeFrozenChannel)
      options.add(ChannelQueryIncludeOption.frozenChannel);
    // if (includeMetaData) options.add(ChannelQueryIncludeOption.metaData);

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
