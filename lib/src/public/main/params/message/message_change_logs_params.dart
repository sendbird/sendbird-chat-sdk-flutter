// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/params/message/base_message_fetch_params.dart';

part 'message_change_logs_params.g.dart';

/// An object consists a set of parameters to retrieve message's change log
@JsonSerializable()
class MessageChangeLogParams extends BaseMessageFetchParams {
  static MessageChangeLogParams fromJson(Map<String, dynamic> json) {
    return _$MessageChangeLogParamsFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$MessageChangeLogParamsToJson(this);
}
