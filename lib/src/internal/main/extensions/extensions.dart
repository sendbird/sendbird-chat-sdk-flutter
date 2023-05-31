// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:sendbird_chat/src/public/main/define/enums.dart';

extension ObjectAsString on Object {
  String asString() => toString().split('.').last;
}

extension IntMax on int {
  static int get max {
    return kIsWeb ? 9007199254740991.round() : 1.7976931348623157e+308.round();
  }
}

extension ChannelTypeUrlString on ChannelType {
  String get urlString {
    switch (this) {
      case ChannelType.group:
        return 'group_channels';
      case ChannelType.open:
        return 'open_channels';
    }
  }

  String get commandString {
    switch (this) {
      case ChannelType.group:
        return 'group';
      case ChannelType.open:
        return 'open';
    }
  }
}

extension ChannelListQueryIncludeOptionListToJson
    on List<ChannelListQueryIncludeOption> {
  Map<String, bool> toJson() {
    final hasEmpty = contains(ChannelListQueryIncludeOption.includeEmpty);
    final hasMember = contains(ChannelListQueryIncludeOption.includeMember);
    final hasFrozen = contains(ChannelListQueryIncludeOption.includeFrozen);
    final hasMetaData = contains(ChannelListQueryIncludeOption.includeMetadata);
    final hasReadReceipt =
        contains(ChannelListQueryIncludeOption.includeReadReceipt);
    final hasDeliveryReceipt =
        contains(ChannelListQueryIncludeOption.includeDeliveryReceipt);

    return {
      if (hasEmpty) 'show_empty': true,
      if (hasMember) 'show_member': true,
      if (hasFrozen) 'show_frozen': true,
      if (hasMetaData) 'show_metadata': true,
      if (hasReadReceipt) 'show_read_receipt': true,
      if (hasDeliveryReceipt) 'show_delivery_receipt': true,
    };
  }
}
