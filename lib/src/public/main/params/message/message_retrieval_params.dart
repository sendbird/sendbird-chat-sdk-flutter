// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/base_message_fetch_params.dart';

part 'message_retrieval_params.g.dart';

/// An object consists a set of parameters to retrieve information from a message.
@JsonSerializable()
class MessageRetrievalParams extends BaseMessageFetchParams {
  /// The [ChannelType].
  ChannelType channelType;

  /// The channel url.
  String channelUrl;

  /// The message ID.
  int messageId;

  MessageRetrievalParams({
    required this.channelType,
    required this.channelUrl,
    required this.messageId,
  });

  static MessageRetrievalParams fromJson(Map<String, dynamic> json) {
    return _$MessageRetrievalParamsFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll(_$MessageRetrievalParamsToJson(this));
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
