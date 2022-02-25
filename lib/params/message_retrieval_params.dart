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
