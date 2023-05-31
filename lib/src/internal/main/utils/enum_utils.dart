// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

String memberStateFilterEnumForQuery(MyMemberStateFilter filter) {
  switch (filter) {
    case MyMemberStateFilter.all:
      return 'all';
    case MyMemberStateFilter.invited:
      return 'invited_only';
    case MyMemberStateFilter.joined:
      return 'joined_only';
    case MyMemberStateFilter.invitedByFriend:
      return 'invited_by_friend';
    case MyMemberStateFilter.invitedByNonFriend:
      return 'invited_by_non_friend';
  }
}

String groupChannelSuperFilterEnum(SuperChannelFilter filter) {
  switch (filter) {
    case SuperChannelFilter.all:
      return 'all';
    case SuperChannelFilter.exclusiveChannelOnly:
      return 'exclusive_only';
    case SuperChannelFilter.superChannelOnly:
      return 'super';
    case SuperChannelFilter.nonsuperChannelOnly:
      return 'nonsuper';
    case SuperChannelFilter.broadcastChannelOnly:
      return 'broadcast_only';
  }
}

T enumDecode<T>(Map<T, dynamic> enumValues, dynamic source,
    {required T unknownValue}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries.singleWhere((e) => e.value == source).key;
  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}
