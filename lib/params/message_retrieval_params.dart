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

  /// Determine to retrieve reactions or not. default is `false`
  @JsonKey(name: 'include_reactions')
  bool includeReactions = false;

  /// Determines whether the metaarray of the message is included in the results.
  @JsonKey(name: 'with_sorted_meta_array')
  bool includeMetaArray = false;

  /// Determines whether to include the parent message text in the results
  /// when the messages are replies in a thread. If the type of the parent
  /// message is `UserMessage` the  value is a `message`. If it is
  /// `FileMessage`, the value is the `name` of the uploaded file.
  /// default value is false
  bool includeParentMessageText = false;

  /// Determines whether to include the thread information of the messages
  /// in the results when the results contain root messages. default value is false
  bool includeThreadInfo = false;

  /// Determines whether to include the reactions to the messages in the results.
  /// default value is false
  bool includeReplies = false;

  /// Determines wheter to include parent message info in the results
  bool includeParentMessageInfo = false;

  /// Determines wheter to include option to reply to channel
  bool replyToChannel = false;

  MessageRetrievalParams({
    required this.channelType,
    required this.channelUrl,
    required this.messageId,
  });

  Map<String, dynamic> toJson() {
    final json = _$MessageRetrievalParamsToJson(this);
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
