import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';

part 'message_retrieval_params.g.dart';

/// An object consists a set of parameters to retrieve information from a message.
@JsonSerializable()
class MessageRetrievalParams {
  /// Specifies the URL of a channel to retrieve a message.
  String channelUrl;

  /// Specifies a type of the channel.
  ChannelType channelType;

  /// Specifies the unique ID of a message to retrieve.
  int messageId;

  /// Determines whether the metaarray of the message is included in the results.
  @JsonKey(name: "with_sorted_meta_array")
  bool includeMetaArray = false;

  /// Determines whether to include the parent message text in the
  /// results when the message is a reply in a thread. If the type
  /// of the parent message is `UserMessage`, the value is a `message`.
  /// If it is `FileMessage`, the value is the `name` of the uploaded file.
  bool includeParentMessageText = false;

  /// Determines whether to include the thread information of the
  /// message when it is a parent message.
  bool includeThreadInfo = false;

  bool get isValid =>
      channelUrl != null && channelType != null && messageId != null;

  Map<String, dynamic> toJson() {
    final json = _$MessageRetrievalParamsToJson(this);
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
