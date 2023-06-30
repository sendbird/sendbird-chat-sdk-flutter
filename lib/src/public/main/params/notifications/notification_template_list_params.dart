// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/main/query/base_query.dart';

/// Params for retrieving Notification template list.
/// @since 4.0.3
class NotificationTemplateListParams {
  /// The key filter to retrieve only selected templates with given keys. Defaults to null.
  /// @since 4.0.3
  final List<String>? keys;

  /// Whether the result is set to be reversed or not. Defaults to false.
  /// @since 4.0.3
  final bool reverse;

  /// The maximum number of items per queried page.
  /// @since 4.0.3
  final int limit;

  NotificationTemplateListParams({
    this.keys,
    this.reverse = false,
    this.limit = BaseQuery.defaultQueryLimit,
  });
}
