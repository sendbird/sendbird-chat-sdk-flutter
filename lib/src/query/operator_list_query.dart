import 'package:flutter/foundation.dart';

import '../constant/enums.dart';
import '../models/error.dart';
import '../sdk/sendbird_sdk_api.dart';

import 'base_query.dart';

/// A query object to retrieve operators.
class OperatorListQuery extends QueryBase {
  /// Channel type
  ChannelType channelType;

  /// Channel url
  String channelUrl;

  OperatorListQuery({
    @required this.channelType,
    @required this.channelUrl,
  });

  @override
  Future<List> loadNext() async {
    if (channelUrl == null || channelType == null) {
      throw InvalidParameterError();
    }
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    loading = true;

    final sdk = SendbirdSdk().getInternal();
    final res = await sdk.api.getOperators(
      token: token,
      limit: limit,
      channelType: channelType,
      channelUrl: channelUrl,
    );

    loading = false;
    token = res.next;
    hasNext = res.next != '';
    return res.operators;
  }
}
