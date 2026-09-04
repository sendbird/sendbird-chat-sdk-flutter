// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

extension ObjectAsString on Object {
  String asString() => toString().split('.').last;
}

extension ChannelTypeUrlString on ChannelType {
  String get urlString {
    switch (this) {
      case ChannelType.group:
        return 'group_channels';
      case ChannelType.open:
        return 'open_channels';
      case ChannelType.feed:
        return 'group_channels'; // Check
    }
  }

  String get commandString {
    switch (this) {
      case ChannelType.group:
        return 'group';
      case ChannelType.open:
        return 'open';
      case ChannelType.feed:
        return 'group'; // Check
    }
  }
}

extension ChannelListQueryIncludeOptionListToJson
    on List<ChannelListQueryIncludeOption> {
  // show_empty / show_frozen are intentionally NOT handled here: they must be
  // sent explicitly (including `false`), but this presence-based serialization
  // can only ever emit `true`. Each list request sets them directly from the
  // query's boolean instead (group/public: both; open: show_frozen only; feed:
  // show_empty only) — do not re-add them here. (CLNP-8901)
  Map<String, bool> toJson() {
    final hasMember = contains(ChannelListQueryIncludeOption.includeMember);
    final hasMetaData = contains(ChannelListQueryIncludeOption.includeMetadata);
    final hasReadReceipt =
        contains(ChannelListQueryIncludeOption.includeReadReceipt);
    final hasDeliveryReceipt =
        contains(ChannelListQueryIncludeOption.includeDeliveryReceipt);
    final hasChatNotification =
        contains(ChannelListQueryIncludeOption.includeChatNotification);

    return {
      if (hasMember) 'show_member': true,
      if (hasMetaData) 'show_metadata': true,
      if (hasReadReceipt) 'show_read_receipt': true,
      if (hasDeliveryReceipt) 'show_delivery_receipt': true,
      if (hasChatNotification) 'include_chat_notification': true,
    };
  }
}

enum ChannelListQueryIncludeOption {
  includeMember,
  includeMetadata,
  includeReadReceipt,
  includeDeliveryReceipt,
  includeChatNotification,
}
