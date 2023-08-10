import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';

part 'base_message_fetch_params.g.dart';

@JsonSerializable()
class BaseMessageFetchParams {
  /// Determines whether to include the metaarray information of the
  /// messages in the results. default value is false
  @JsonKey(name: 'with_sorted_meta_array')
  bool includeMetaArray = false;

  /// Determines whether to include the reactions to the messages
  /// in the results. default value is false
  bool includeReactions = false;

  /// Determines whether to include the parent message text in the results
  /// when the messages are replies in a thread. If the type of the parent
  /// message is `UserMessage` the  value is a `message`. If it is
  /// `FileMessage`, the value is the `name` of the uploaded file.
  /// default value is false
  @Deprecated('Use `includeParentMessageInfo` instead')
  bool? includeParentMessageText;

  /// Determines whether to include the reactions to the messages in the results.
  /// default value is false
  @Deprecated('Use `replyType` instead')
  bool? includeReplies;

  /// Determines whether to include the thread information of the messages
  /// in the results when the results contain root messages. default value is false
  bool includeThreadInfo = false;

  /// Determines wheter to include parent message info in the results
  bool includeParentMessageInfo = false;

  /// Determines message's reply type
  @JsonKey(name: 'include_reply_type')
  ReplyType? replyType;

  Map<String, dynamic> toJson() {
    final json = _$BaseMessageFetchParamsToJson(this);
    // ignore: deprecated_member_use_from_same_package
    final replies = includeReplies;
    // ignore: deprecated_member_use_from_same_package
    final parentText = includeParentMessageText ?? includeParentMessageText;
    if (replies != null) {
      json['include_reply_type'] = replies ? 'ALL' : 'NONE';
    }
    if (parentText != null) {
      json['include_parent_message_info'] = parentText;
    }
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
