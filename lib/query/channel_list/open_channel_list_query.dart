import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/core/channel/open/open_channel.dart';
import 'package:sendbird_sdk/core/models/error.dart';
import 'package:sendbird_sdk/core/models/responses.dart';
import 'package:sendbird_sdk/query/base_query.dart';
import 'package:sendbird_sdk/request/channel/open_channel_list_request.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';

part 'open_channel_list_query.g.dart';

/// A query object to retrieve list of open channel.
@JsonSerializable()
class OpenChannelListQuery extends QueryBase {
  /// Channel url contains
  String? channelUrl;

  /// Channel name contains
  String? channelName;

  /// Filters channel custom type
  String? customType;

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

    final options = [
      if (includeFrozenChannel) ChannelQueryIncludeOption.frozenChannel,
      if (includeMetaData) ChannelQueryIncludeOption.metaData
    ];

    final sdk = SendbirdSdk().getInternal();
    final res = await sdk.api.send<ChannelListQueryResponse<OpenChannel>>(
      OpenChannelListRequest(
        channelName: channelName,
        channelUrl: channelUrl,
        customType: customType,
        token: token,
        limit: limit,
        options: options,
      ),
    );

    loading = false;
    token = res.next;
    hasNext = res.next != '';
    return res.channels;
  }

  // Json Serialization

  Map<String, dynamic> toJson() => _$OpenChannelListQueryToJson(this);
}
