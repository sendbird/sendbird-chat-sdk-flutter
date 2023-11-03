// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

part 'base_message_fetch_params.g.dart';

/// Represents a base for message fetch params.
@JsonSerializable()
class BaseMessageFetchParams {
  /// Whether the meta arrays should be included in the results.
  @JsonKey(name: 'with_sorted_meta_array')
  bool includeMetaArray = false;

  /// Whether the reaction data should be included in the results.
  bool includeReactions = false;

  /// Whether the thread information should be included in the results.
  bool includeThreadInfo = false;

  /// Whether the information of a parent message should be included in the reply messages included in the results.
  bool includeParentMessageInfo = false;

  /// Determines the reply types to include in the results.
  @JsonKey(name: 'include_reply_type')
  ReplyType? replyType;

  static BaseMessageFetchParams fromJson(Map<String, dynamic> json) {
    return _$BaseMessageFetchParamsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    final json = _$BaseMessageFetchParamsToJson(this);
    if (replyType != null) {
      json['include_reply_type'] = replyType?.name;
    }
    json['include_parent_message_info'] = includeParentMessageInfo;
    json.removeWhere((key, value) => value == null);
    return json;
  }

  void copyWith(BaseMessageFetchParams other) {
    includeMetaArray = other.includeMetaArray;
    includeReactions = other.includeReactions;
    includeThreadInfo = other.includeThreadInfo;
    includeParentMessageInfo = other.includeParentMessageInfo;
    replyType = other.replyType;
  }
}
