import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/params/base_message_fetch_params.dart';

part 'message_retrieval_params.g.dart';

/// An object consists a set of parameters to retrieve information from a message.
@JsonSerializable()
class MessageRetrievalParams extends BaseMessageFetchParams {
  /// Specifies the URL of a channel to retrieve a message.
  String channelUrl;

  /// Specifies a type of the channel.
  ChannelType channelType;

  /// Specifies the unique ID of a message to retrieve.
  int messageId;

  /// Determine to retrieve reactions or not. default is `false`
  @override
  @JsonKey(name: 'include_reactions')
  bool includeReactions = false;

  /// Determines whether the metaarray of the message is included in the results.
  @override
  @JsonKey(name: 'with_sorted_meta_array')
  bool includeMetaArray = false;

  /// Determines whether to include the parent message text in the results
  /// when the messages are replies in a thread. If the type of the parent
  /// message is `UserMessage` the  value is a `message`. If it is
  /// `FileMessage`, the value is the `name` of the uploaded file.
  /// default value is false
  @override
  bool? includeParentMessageText = false;

  /// Determines whether to include the thread information of the messages
  /// in the results when the results contain root messages. default value is false
  @override
  bool includeThreadInfo = false;

  /// Determines whether to include the reactions to the messages in the results.
  /// default value is false
  @override
  bool? includeReplies = false;

  /// Determines wheter to include parent message info in the results
  @override
  bool includeParentMessageInfo = false;

  /// Determines wheter to include option to reply to channel
  bool replyToChannel = false;

  MessageRetrievalParams({
    required this.channelType,
    required this.channelUrl,
    required this.messageId,
  });

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll(_$MessageRetrievalParamsToJson(this));
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
